local customItemRegistrySingleton = nil
CustomItemRegistry = {}
function CustomItemRegistry:new()
	if customItemRegistrySingleton then
		return customItemRegistrySingleton
	end
	local newObj = {}
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(CustomItemRegistry, {
	__call = function(class, ...)
		return class:new(...)
	end,
})
customItemRegistrySingleton = CustomItemRegistry()
CustomItemRegistry.states = {}
function CustomItemRegistry:register(aid)
	self.states[aid] = {}
	return self
end

function CustomItemRegistry:getState(aid)
	return self.states[aid]
end

function CustomItemRegistry:unregister(aid)
	self.states[aid] = nil
end

function T(template, variables)
	local result = template
	for key, value in pairs(variables) do
		result = result:gsub(":" .. key .. ":", value)
	end
	return result
end

function OnLook(callback, stringIdentifier, questId)
	questId = questId or LOCALIZER_UNIVERSAL
	for language, quests in pairs(TRANSLATION_TABLES) do
		quests[questId][stringIdentifier] = callback
	end
end

function LoadStartupNpc(npcs, anchor)
	for _, npcData in pairs(npcs) do
		local pos = npcData.pos or npcData.position or npcData.offset
		if anchor then
			pos = anchor:Moved(pos)
		else
			pos = ExtractCoords(pos)
		end
		if not Tile(pos) then
			print(T("TRYING TO CREATE NPC :name: ON NONEXISTANT TILE POSITION:", { name = npcData.name }))
			PrintPosition(pos, true)
		end
		local npc = Game.createNpc(npcData.name, pos)
		if not npc then
			print(T("Could not create npc :name:", { name = npcData.name }))
			PrintPosition(pos, true)
		end
		npc:setMasterPos(pos)
	end
end

function LoadStartupMonsters(monsters, anchor)
	for _, monsterData in pairs(monsters) do
		local pos = monsterData.pos or monsterData.position or monsterData.offset
		if anchor then
			pos = anchor:Moved(pos)
		else
			pos = ExtractCoords(pos)
		end

		local monster = Game.createMonster(monsterData.name, pos)
		if not Tile(pos) then
			print(T("TRYING TO CREATE MONSTER :name: ON NONEXISTING TILE POSITION:", { name = monsterData.ame }))
			PrintPosition(pos, true)
		end
		if not monster then
			print(T("Could not create monster :name:", { name = monsterData.name }))
			PrintPosition(pos, true)
		end
	end
end

local function createCustomItemOnMap(context)
	local id = context.id
	local count = context.count
	local aid = context.aid
	local uid = context.uid
	local desc = context.desc
	local text = context.text

	local pos = context.pos
	local item = Game.createItem(id, count, pos)
	if not item then
		print(debug.traceback(T("Cannot create item :id:, on position :pos:", { id = id, pos = pos:ToString() })))
		return
	end
	if aid and aid ~= 0 then
		item:setActionId(aid)
		item:setUniqueId(1000)
	end
	if uid and uid ~= 0 then
		item:setUniqueId(uid)
	end

	if desc and type(desc) == "string" then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, desc)
	end
	if text and type(text) == "string" then
		item:setAttribute(ITEM_ATTRIBUTE_TEXT, text)
	end
end

local function registerItemCustomActions(context)
	local aid = context.aid

	local thisItemRegistry = CustomItemRegistry():register(aid):getState(aid)
	for key, value in pairs(context) do
		thisItemRegistry[key] = value
	end
end

local function normalizeItemData(itemConfig, anchor)
	local context = {}
	context.id = itemConfig.id
	context.count = itemConfig.count or 1
	context.aid = itemConfig.actionid or itemConfig.aid or itemConfig.actionId
	context.uid = itemConfig.uniqueid or itemConfig.uid or itemConfig.uniqueId
	context.desc = itemConfig.description or itemConfig.desc
	context.text = itemConfig.text
	context.rewards = itemConfig.rewards
	context.requiredState = itemConfig.requiredState
	context.nextState = itemConfig.nextState
	context.expReward = itemConfig.expReward or itemConfig.exp or itemConfig.experience
	context.specialActionsOnSuccess = itemConfig.specialActionsOnSuccess
	context.specialActionsOnFail = itemConfig.specialActionsOnFail
	context.onLook = itemConfig.onLook or itemConfig.onlook
	local pos = itemConfig.pos or itemConfig.offset or itemConfig.position or itemConfig.offpos or itemConfig.vector
	if pos then
		if anchor then
			pos = anchor:Moved(pos)
		else
			pos = ExtractCoords(pos)
		end
		if pos.x == 0 or pos.y == 0 then
			pos = nil
		end
	end
	context.pos = pos
	return context
end

local function loadStartupItem(itemConfig, anchor)
	local context = normalizeItemData(itemConfig, anchor)

	if context.pos then
		createCustomItemOnMap(context)
	end
	if context.aid and context.aid ~= 0 then
		registerItemCustomActions(context)
	end
end

function LoadStartupItems(items, anchor)
	for _, itemConfig in pairs(items) do
		loadStartupItem(itemConfig, anchor)
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

local nextAvailableSpellId = 0
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