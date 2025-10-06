function Player:isMale()
	return self:getSex() == PLAYERSEX_MALE
end

local defaultSeparator = ",\n"
function RequiredItemNamesCountToString(items, separator)
	local text = ""
	if TableSize(items) == 0 then
		logger.warn("[RequiredItemNamesCountToString] items size is 0")
		return text
	end
	separator = separator or defaultSeparator
	for _, item in pairs(items) do
		text = text .. T(":count: :name::separator:", { count = item.count, name = ItemType(item.id):getName(), separator = separator })
	end
	return text:sub(1, -3)
end

function RequiredItemNamesToString(items, separator)
	local text = ""
	if TableSize(items) == 0 then
		logger.warn("[RequiredItemNamesToString] items size is 0")
		return text
	end
	separator = separator or defaultSeparator
	for _, item in pairs(items) do
		text = text .. T(":name::separator:", { name = ItemType(item.id):getName(), separator = separator })
	end
	return text:sub(1, -3)
end

function who_called_me()
	local info = debug.getinfo(2, "n")
	if info and info.name then
		return info.name
	else
		return "<unknown>"
	end
end

function SerializeToUtilFolder(str, filename)
	local file, err = io.open(filename, "w+")
	if not file then
		logger.warn("[SerializeToUtilFolder] Error opening file: " .. err)
		return false
	end
	file:write(str)
	file:flush()
	file:close()
	logger.warn(T("[SerializeToUtilFolder][:caller: caller] serialized file :filename: ", { caller = who_called_me(), filename = filename }))
end

function Player:teleportToReflectedPoint(midpoint)
	local vectorToMidpoint = self:getPosition():VectorTo(midpoint)
	local reflectedPoint = midpoint:Moved(vectorToMidpoint)
	self:teleportTo(reflectedPoint)
end

function Player:teleportToOtherSideIfNonDiagonal(midpoint)
	local vectorToMidpoint = self:getPosition():VectorTo(midpoint)
	if not vectorToMidpoint:IsFacingDiagonalSnap() then
		self:teleportTo(midpoint:MovedByVector(vectorToMidpoint))
	end
end

function Class()
	local class = {}
	class.index = class
	setmetatable(class, {
		call = function(class, ...)
			return class:_new(...)
		end,
	})
	class._new = function(obj, ...)
		local newObj = class:New(...)
		setmetatable(newObj, class)
		return newObj
	end
	return class
end

function Game.createDelayedEffects(position, effect, effectCount, delayBetweenEffectsSeconds)
	effect = effect or CONST_ME_TELEPORT
	effectCount = effectCount or 3
	for i = 1, effectCount do
		addEvent(function()
			position:sendMagicEffect(effect)
		end, i * delayBetweenEffectsSeconds * 1000)
	end
end

TRANSFERABLE_COINS_GAIN_MULTIPLIER = 10
function Player:AddAllCoins(coins)
	self:addTibiaCoins(coins)
	self:addTransferableCoins(coins * TRANSFERABLE_COINS_GAIN_MULTIPLIER)
end

---@param damageMap table
---@param lastHitKiller nil|Creature
---@return table topKillers -- lastHitKiller is considered the to have top damage regardles of actual damage
function GetTopKillers(damageMap, lastHitKiller)
	if not (lastHitKiller and lastHitKiller:getPlayer()) then
		lastHitKiller = nil
	end

	local damageMapSorted = {}
	for playerId, damage in pairs(damageMap) do
		local player = Player(playerId)
		if not player then
			goto continue
		end
		if player == lastHitKiller then
			goto continue
		end
		table.insert(damageMapSorted, { player = player, damage = damage.total })
		::continue::
	end

	table.sort(damageMapSorted, function(a, b)
		return a.damage > b.damage
	end)

	local topKillers = { lastHitKiller }
	for _, playerDamage in pairs(damageMapSorted) do
		table.insert(topKillers, playerDamage.player)
	end
	return topKillers
end

function SecondsToMinSec(seconds)
	local minutes = math.floor(seconds / 60)
	local remainingSeconds = seconds % 60
	return minutes, remainingSeconds
end

function FirstCharToUpper(str)
	return str:gsub("^%l", string.upper)
end

function Player:getFiveBlessingsCost()
	local level = self:getLevel()
	if level <= MAX_LVL_TO_GET_FREE_BLESS then
		return 0
	end
	return getBlessingsCost(level) * 5
end

function ItemsToString(items)
	items = items or {}

	local str = ""
	for _, item in pairs(items) do
		local id = item.id
		local itemName = ItemType(id):getName()
		local count = item.count
		str = str .. T(":count: :itemName:\n", {
			count = count,
			itemName = itemName,
		})
	end
	return str
end

---using key types other than string/number is not recommended
---@param key string|number|any
---@return any any If present, returns value in player kv store, else returns default value
function Player:getStorageValueByKey(key)
	return self:kv():get(key) or MISSION_NOT_STARTED
end
---@param key string|number|any
---@return any any If present, returns value in player kv store, else returns nil
function Player:getStorageValueByKeyRaw(key, type)
	return self:kv():get(key)
end

local function validateKey(key)
	if key == nil then
		logger.error(debug.traceback("[Player:setStorageValueByKey] key is nil"))
		error("[Player:setStorageValueByKey] key is nil")
	end
	local components = key:split("-")
	if not components then
		logger.error(debug.traceback("[Player:setStorageValueByKey] key has no components"))
	end
	for i, component in ipairs(components) do
		if component == "" then
			logger.error(debug.traceback(T("[Player:setStorageValueByKey] key :key: component :i: is empty string", { key = key, i = i })))
		end
	end
end

---@param key string|number|any
---@param nextValue any
---@return any
function Player:setStorageValueByKey(key, nextValue)
	validateKey(key)
	local previousValue = self:getStorageValueByKey(key)
	self:kv():set(key, nextValue)
	self:updateStorage(key, nextValue, previousValue, os.time())
end

---@param key string|number|any
function Player:removeStorageValueByKey(key)
	local previousValue = self:getStorageValueByKey(key)
	self:kv():remove(key)
	self:updateStorage(key, nil, previousValue, os.time())
end

function Player:incrementStorageByKey(key, addend)
	addend = addend or 1
	local currentValue = self:getStorageValueByKey(key)
	local nextValue = currentValue + addend
	self:setStorageValueByKey(key, nextValue)
end
function Player:incrementStorageByKeyClampZero(key, addend)
	addend = addend or 1
	local currentValue = self:getStorageValueByKey(key)
	local nextValue = math.max(currentValue, 0) + addend
	self:setStorageValueByKey(key, nextValue)
end

function Game.getStorageValueByKey(key)
	return kv.get(key) or MISSION_NOT_STARTED
end
function Game.setStorageValueByKey(key, value)
	return kv.set(key, value)
end

function Shop:getStorageValueByKey(key)
	return self:kv():get(key) or MISSION_NOT_STARTED
end
function Shop:setStorageValueByKey(key, value)
	return self:kv():set(key, value)
end

function T(template, variables)
	if not variables then
		logger.warn(debug.traceback("[T] no variables table provided"))
	end

	local filledTemplate = template
	for key, value in pairs(variables) do
		filledTemplate = filledTemplate:gsub(":" .. key .. ":", value)
	end
	return filledTemplate
end

NUMBER_TO_ORDINAL_STRING = {
	[1] = "first",
	[2] = "second",
	[3] = "third",
	[4] = "fourth",
	[5] = "fifth",
	[6] = "sixth",
	[7] = "seventh",
	[8] = "eighth",
	[9] = "ninth",
	[10] = "tenth",
	[11] = "eleventh",
	[12] = "twelfth",
	[13] = "thirteenth",
	[14] = "fourteenth",
	[15] = "fifteenth",
}

---@deprecated
RegisterEncounter = function()
	logger.error("[RegisterEncounter] is deprecated. Use EncounterData()")
end

function Player:ExpForNextlevel()
	local nextLevel = self:getLevel() + 1
	return Game.getExperienceForLevel(nextLevel) - self:getExperience()
end

function SendPlayerIsPzLocked(player)
	player:sendTextMessage(MESSAGE_FAILURE, "You can not use this after attacking another player.")
end

function Player:errorIfCannotUseCooldownItem(cooldownKV)
	if self:isOnMinigame() then
		return "You cannot use this item on events."
	end
	if self:hasExhaustion(cooldownKV) then
		return "You need to wait before using this again."
	end
	return nil
end

function RegisterOnLook(callback, stringIdentifier, localizer)
	localizer = localizer or LOCALIZERS.Universal
	for language, localizerToStrIdentifier in pairs(TRANSLATION_TABLES) do
		localizerToStrIdentifier[localizer][stringIdentifier] = callback
	end
end

-- used on cpp side to exctract global vars
---@param str string eg. Storage.ExampleQuest.Mission1 will extract the Mission1 value
function FindGlobalValueByNestedString(str)
	local nodes = {}
	for node in str:gmatch("[^%.]+") do
		nodes[#nodes + 1] = node
	end

	local result = _G
	for _, node in pairs(nodes) do
		result = result[node]
	end
	return result
end

function IterateSpectators(spectators, callback)
	for _, cid in pairs(spectators) do
		callback(cid)
	end
end

---@param var nil|string|function|table
---@param context table
---@return any
function Evaluate(var, context)
	if type(var) == "function" then
		return var(context)
	end
	if type(var) == "table" then
		return var[context]
	end
	if type(var) == "nil" then
		return nil
	end
	if type(var) == "string" or type(var) == "number" or type(var) == "boolean" then
		return var
	end
end

function SwappedKeyValue(table)
	local result = {}
	for key, value in pairs(table) do
		result[value] = key
	end
	return result
end

-- modified function made by "Roddet"
local xRange = 7
local yRange = 5
function Game.startCountdown(position, totalSeconds)
	if not totalSeconds or totalSeconds <= 0 then
		return
	end

	local minutes = math.floor(totalSeconds / 60)
	local seconds = totalSeconds % 60

	local output = ""
	if minutes < 1 then
		output = seconds
	else
		output = T(":minutes: m :seconds: s", { minutes = minutes, seconds = seconds })
		output = minutes .. "m " .. seconds .. "s"
	end
	local spectators = Game.getSpectators(position, true, true, xRange, xRange, yRange, yRange)
	for _, spectator in pairs(spectators) do
		spectator:say(output, TALKTYPE_MONSTER_SAY, true, spectator, position)
	end

	addEvent(Game.startCountdown, 1000, position, seconds - 1)
end

local nextSpellId = 1000000
function NextSpellId()
	nextSpellId = nextSpellId + 1
	return nextSpellId
end

local nextWordId = 2000000
function NextSpellWords()
	nextWordId = nextWordId + 1
	local nextWord = "###" .. nextWordId
	return nextWord
end

local maxSearchDepth = 10
local function printVariablesWithValueX(tbl, prefix, expectedVal, currentDepth)
	if currentDepth > maxSearchDepth then
		return
	end

	prefix = prefix or ""
	for k, v in pairs(tbl) do
		if k == "_G" then
			goto continue
		end
		local name = prefix .. tostring(k)
		if v == expectedVal then
			print(name, "=", v)
		elseif type(v) == "table" then
			printVariablesWithValueX(v, name .. ".", expectedVal, currentDepth + 1)
		end
		::continue::
	end
end

function PrintVariablesWithValue(expectedVal)
	print("---PRINTING VARIABLE NAMES WITH VALUE OF " .. expectedVal .. " ---")
	for k, v in pairs(_G) do
		if v == expectedVal then
			print(k, "=", v)
		elseif type(v) == "table" then
			printVariablesWithValueX(v, k .. ".", expectedVal, 1)
		end
	end
	print("---DONE----")
end

function Player:ClearConditions(conditions)
	for _, condition in pairs(conditions or ALL_CONDITIONS) do
		self:removeCondition(condition)
	end
end

local safeLowValue = -2e+300
local safeHighValue = 2e+300

function FindMinMaxKey(table)
	local max = safeLowValue
	local min = safeHighValue
	local numericValues = 0
	for key, _ in pairs(table) do
		if type(key) == "number" then
			max = math.max(max, key)
			min = math.min(min, key)
			numericValues = numericValues + 1
		end
	end

	if numericValues == 0 then
		return nil, nil
	end
	return min, max
end

function FindMinMaxValue(table)
	local max = safeLowValue
	local min = safeHighValue
	local numericValues = 0
	for _, value in pairs(table) do
		if type(value) == "number" then
			max = math.max(max, value)
			min = math.min(min, value)
			numericValues = numericValues + 1
		end
	end

	if numericValues == 0 then
		return nil, nil
	end
	return min, max
end

function Deepcopied(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[Deepcopied(orig_key)] = Deepcopied(orig_value)
		end
		setmetatable(copy, Deepcopied(getmetatable(orig)))
	else
		copy = orig
	end
	return copy
end

-- <br>toppest of keks</br>
function TableSize(tab)
	local size = 0
	for _, _ in pairs(tab) do
		size = size + 1
	end
	return size
end

local function parseString(var)
	if type(var) == "string" then
		return var
	end
	if type(var) == "number" then
		return tostring(var)
	end
	if type(var) == "function" then
		return "function"
	end
	if type(var) == "table" then
		return "table"
	end
	return "unknown"
end

function PrintTableRecursive(tbl, indent)
	indent = indent or 0
	for key, value in pairs(tbl) do
		local keyString = parseString(key)
		local valueString = parseString(value)
		if type(value) == "table" then
			print(string.rep(" ", indent) .. keyString .. ":")
			PrintTableRecursive(value, indent + 4)
		else
			print(string.rep(" ", indent) .. "|-" .. keyString .. ": " .. valueString)
		end
	end
end

function PrintAnything(thing)
	if type(thing) ~= "table" then
		print(thing)
		return
	end
	PrintTableRecursive(thing)
end

local addonToStr = {
	[0] = "No addons",
	[1] = "First addon only",
	[2] = "Second addon only",
	[3] = "First and Second addon",
}

local function announceReceivedOutfit(player, outfitId, addons)
	local addonStr = addonToStr[addons]
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("You have gained the :outfitName: outfit! (:addonStr:)", { outfitName = Game.getOutfitNameByLookType(outfitId), addonStr = addonStr }))
end

function Player:AddOutfitsAndAddons(outfitsAndAddons)
	for _, data in pairs(outfitsAndAddons) do
		local outfitId = data.outfitId or data.outfit or data.id
		local addons = data.addon or data.addons or 0

		self:addOutfit(outfitId)
		if addons then
			self:addOutfitAddon(outfitId, addons)
		end
		announceReceivedOutfit(self, outfitId, addons)
	end
	self:addOutfit()
end

function Player:AddMounts(mounts)
	for _, mountId in pairs(mounts) do
		self:addMount(mountId)
	end
end

function AddExperienceWithAnnouncement(player, exp)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("You have gained :exp: experience!", { exp = exp }))
	player:addExperience(exp)
	player:getPosition():sendMagicEffect(CONST_ME_STUN)
end

function PredictNetHealthgain(primaryDamage, primaryType, secondaryDamage, secondaryType)
	local primaryMultiplier = -1
	if primaryType == COMBAT_HEALING then
		primaryMultiplier = 1
	end

	local secondaryMultiplier = -1
	if secondaryType == COMBAT_HEALING then
		secondaryMultiplier = 1
	end

	return primaryDamage * primaryMultiplier + secondaryDamage * secondaryMultiplier
end

function TryReverseTable(tab)
	if not tab then
		return
	end
	local n = #tab
	for i = 1, math.floor(n / 2) do
		tab[i], tab[n - i + 1] = tab[n - i + 1], tab[i]
	end
end

function ReverseTable(tab)
	local n = #tab
	for i = 1, math.floor(n / 2) do
		tab[i], tab[n - i + 1] = tab[n - i + 1], tab[i]
	end
end

function normalizedItemData(itemData, localizer)
	local normalized = {}
	for key, value in pairs(itemData) do
		normalized[key] = value
	end

	normalized.id = itemData.id
	normalized.count = itemData.count or 1
	normalized.aid = itemData.actionid or itemData.aid or itemData.actionId
	normalized.uid = itemData.uniqueid or itemData.uid or itemData.uniqueId
	normalized.key = itemData.key
	normalized.desc = itemData.description or itemData.desc
	normalized.text = itemData.text
	normalized.rewards = itemData.rewards
	normalized.requiredState = itemData.requiredState
	normalized.nextState = itemData.nextState
	normalized.expReward = itemData.expReward or itemData.exp or itemData.experience
	normalized.specialActionsOnSuccess = itemData.specialActionsOnSuccess
	normalized.specialActionsOnFail = itemData.specialActionsOnFail
	normalized.onLook = itemData.onLook or itemData.onlook
	normalized.immovable = itemData.immovable
	local pos = itemData.pos or itemData.offset or itemData.position or itemData.offpos or itemData.vector
	if pos then
		logger.warn("[normalizedItemData] pos is deprecated")
	end
	normalized.pos = pos
	normalized.source = itemData.source

	normalized.localizer = itemData.localizer or localizer
	return normalized
end
