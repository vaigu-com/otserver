---@deprecated
RegisterEncounter = function()
	logger.error("[RegisterEncounter] is deprecated. Use EncounterData and Encounter")
end

function Player:errorIfCannotUseCooldownItem(cooldownKV)
	if self:isOnEvent() then
		return "You cannot use this item on events."
	end
	if self:hasExhaustion(cooldownKV) then
		return "You need to wait before using this again."
	end
	return true
end

function Player:isOnEvent()
	if
		self:getStorageValue(Storage.GrimEvent.Joined) >= 1
		or self:getStorageValue(Storage.hasteLock) == 1
		or self:getStorageValue(Storage.healLock) == 1
	then
		return true
	end
end

function T(template, variables)
	local result = template
	for key, value in pairs(variables) do
		result = result:gsub(":" .. key .. ":", value)
	end
	return result
end

function RegisterOnLook(callback, stringIdentifier, questId)
	questId = questId or LOCALIZER_UNIVERSAL
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

	addEvent(Game.setCountdown, 1000, position, seconds - 1)
end

local nextAvailableSpellId = 40000
function NextSpellId()
	nextAvailableSpellId = nextAvailableSpellId + 1
	local nextAvailableSpellIdString = "###" .. nextAvailableSpellId
	return nextAvailableSpellIdString
end

function SimpleTextDisplay(player, item, string)
	local title = "You read the following."
	local message = string or ("Report this bug to the gamemaster. Debug info: AID:" .. item:getActionId())
	local close = "Close"
	local aid = item:getActionId()

	player:registerEvent("SimpleDisplayOnLook")

	local window = ModalWindow(aid, title, message)
	window:addButton(101, close)
	window:setDefaultEscapeButton(101)

	window:sendToPlayer(player)
	player:unregisterEvent("SimpleDisplayOnLook")
	return DONT_SHOW_ONLOOK
end

-- usage: [storage] = "english description",
local aidToCustomDesc = {
	-- keys
	[5003] = "Don't let the skeletons out!",
	-- misc
	[5640] = "a honeyflower patch.",
	[5641] = "a banana palm.",
	[5642] = "a gargoyle statue.\n You read: \n\n Either loved or hated \n\nCitizen Honoris Causa\n\nPtaaq",
	[11082] = "Map of burried spell.",
	[11083] = "Map of brasilian Ratland.",
	[11085] = "Overdue package.\nThis is a big parcel with lot of orders. The recipient is the Mirkotown depot, 2nd floor",
	[11086] = "Bait in a can.",
	[11088] = "Anon's father's float.",
	[11090] = "Anon's father's fishing reel.",
	[11092] = "Anon's father's stool.",
}

local function tryFindAnyDescription(onLookContext)
	local player = onLookContext.player
	local item = onLookContext.item
	local description = aidToCustomDesc[item:getActionId()] or item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
	local translatedDescription = player:Localizer(nil):Context({ item = item, player = player }):Get(description)
	if translatedDescription and translatedDescription ~= "" then
		return nil, translatedDescription
	end
	if description and description ~= "" then
		return nil, description
	end
end

local function tryDisplayItemText(onLookContext)
	local player = onLookContext.player
	local item = onLookContext.item
	local text = item:getAttribute(ITEM_ATTRIBUTE_TEXT)
	if text == nil or text == "" then
		return
	end

	local translatedText = player:Localizer(nil):Context({ item = item }):Get(text)
	if translatedText and translatedText ~= "" then
		SimpleTextDisplay(player, item, translatedText)
		return DONT_SHOW_ONLOOK
	end
	return text
end

local function tryInvokeCustomFunction(onLookContext)
	return onLookContext.onLook(onLookContext)
end

local displayFuctions = {
	tryDisplayItemText,
	tryInvokeCustomFunction,
	tryFindAnyDescription,
}

function ParseCustomOnLook(item, player)
	local aid = item:getActionId()
	if not aid or aid <= 0 then
		return nil
	end

	local itemConfig = CustomItemRegistry():GetState(aid)
	local onLookContext = { player = player, aid = aid, item = item, onLook = itemConfig.onLook }
	for _, check in pairs(displayFuctions) do
		local status, description = check(onLookContext)
		if status == DONT_SHOW_ONLOOK then
			return DONT_SHOW_ONLOOK
		end
		if description then
			return description
		end
	end
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

function FindMinMaxKey(table)
	local max = -1
	local min = 2e+300
	for key, _ in pairs(table) do
		if type(key) ~= "number" then
			goto continue
		end
		if key > max then
			max = key
		end
		if key < min then
			min = key
		end
		::continue::
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
