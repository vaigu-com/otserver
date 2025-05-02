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

---using types other than string/number is not recommended
---@param key string|number|any
---@return any
function Player:getStorageValueByKey(key)
	return self:kv():get(key) or MISSION_NOT_STARTED
end
---using types other than string/number is not recommended
---@param key string|number|any
---@param nextValue any
---@return any
function Player:setStorageValueByKey(key, nextValue)
	local previousValue = self:getStorageValueByKey(key)
	self:kv():set(key, nextValue)
	self:updateStorage(key, nextValue, previousValue, os.time())
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

---@class DataClass
DataClass = DataClass

function T(template, variables)
	if not variables then
		logger.warn(debug.traceback("[T] no variables table provided"))
	end
	local result = template
	for key, value in pairs(variables) do
		result = result:gsub(":" .. key .. ":", value)
	end
	return result
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
	return true
end

function RegisterOnLook(callback, stringIdentifier, questId)
	questId = questId or LOCALIZERS.Universal
	for language, quests in pairs(TRANSLATION_TABLES) do
		quests[questId][stringIdentifier] = callback
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

local nextAvailableSpellId = 40000
function NextSpellId()
	nextAvailableSpellId = nextAvailableSpellId + 1
	local nextAvailableSpellIdString = "###" .. nextAvailableSpellId
	return nextAvailableSpellIdString
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

function Player:AddOutfitsAndAddons(outfitsAndAddons)
	for _, data in pairs(outfitsAndAddons) do
		local outfit = data.outfitId or data.outfit or data.id
		local addon = data.addon

		self:addOutfit(outfit)
		if addon then
			self:addOutfitAddon(outfit, addon)
		end
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
