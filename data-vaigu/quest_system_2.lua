---@class Quest
---@field name string
---@field missions table
---@field monsterEvents table
---@field encounters table
---@field monsters table
---@field scripts table
---@field startupScripts table
---@field npcs table
---@field startupItems table
---@field startupNpcs table
---@field questlog table
---@field mission integer
---@field state integer
---@field localizer string
Quest = {}
Quest.__index = Quest
function Quest:New(name)
	local newObj = {
		name = name,
		localizer = name,
		missions = {},
		monsterEvents = {},
		encounters = {},
		monsters = {},
		scripts = {},
		startupScripts = {},
		npcs = {},
		startupItems = {},
		questlog = function() end,
	}

	setmetatable(newObj, self)
	return newObj
end
setmetatable(Quest, {
	__call = function(class, ...)
		return class:New(...)
	end,
})

QUEST_SCRIPT_TYPE = {
	DIALOG = "DIALOG",
	CUSTOM_SCRIPT = "CUSTOM_SCRIPT",
	STARTUP_ITEMS = "STARTUP_ITEMS",
	STARTUP_SCRIPT = "STARTUP_SCRIPT",
}

--#region Immediate execution
function Quest:Storage(storages)
	storages()
	return self
end
function Quest:Constant(constant)
	constant()
	return self
end
--#endregion

--#region Not quest state dependant
function Quest:Questlog(questlog)
	self.questlog = questlog
	return self
end
--#endregion

--#region Not quest state dependant, but related to quest state
function Quest:MonsterEvent(MonsterEvent)
	table.insert(self.monsterEvents, MonsterEvent)
	return self
end
function Quest:EncounterData(data)
	table.insert(self.encounters, data)
	return self
end
function Quest:Monster(monster)
	table.insert(self.monsters, monster)
	return self
end
--#endregion

--#reqion Quest state dependant
QuestFactory = {}
QuestFactory.__index = QuestFactory
function QuestFactory.Dialog(names, dialogs)
	return { names = names, dialogs = dialogs, scriptType = QUEST_SCRIPT_TYPE.DIALOG }
end
function QuestFactory.Script(script)
	return { script = script, scriptType = QUEST_SCRIPT_TYPE.CUSTOM_SCRIPT }
end
function QuestFactory.StartupItems(items, anchor)
	return { items = items, anchor = anchor, scriptType = QUEST_SCRIPT_TYPE.STARTUP_ITEMS }
end
function QuestFactory.StartupScript(script)
	return { script = script, scriptType = QUEST_SCRIPT_TYPE.STARTUP_SCRIPT }
end
function Quest:Script(script)
	table.insert(self.scripts, { script = script })
	return self
end
function Quest:StartupItems(items, anchor)
	table.append(self.startupItems, { items = items, anchor = anchor })
	return self
end
---@private
function Quest:AddDialog(context)
	local names, dialogs = context.names, context.dialogs
	local mission, state = context.mission, context.state
	if not mission then
		logger.debug(T(":quest: missing mission for dialog", { quest = self.name }))
	end
	if not state then
		logger.debug(T(":quest: missing state for dialog", { quest = self.name }))
	end
	if not dialogs then
		logger.debug(T(":quest: missing dialog for dialog", { quest = self.name }))
	end
	if not name then
		logger.debug(T(":quest: missing name for dialog", { quest = self.name }))
	end

	if type(names) ~= "table" then
		names = { names }
	end

	for _, name in pairs(names) do
		self.npcs[name] = self.npcs[name] or {}
		self.npcs[name].missions = self.npcs[name].missions or {}
		self.npcs[name].missions[mission] = self.npcs[name].missions[mission] or {}
		self.npcs[name].missions[mission].states = self.npcs[name].missions[mission].states or {}
		self.npcs[name].missions[mission].states[state] = dialogs
	end

	return self
end
---@private
function Quest:AddScript(context)
	local script = context.script
	local mission, state = context.mission, context.state

	table.insert(self.scripts, { script = script, mission = mission, state = state })
	return self
end
---@private
function Quest:AddStartupItems(context)
	local items, anchor = context.items, context.anchor
	local mission, state = context.mission, context.state

	--38f
	for key, item in pairs(items) do
		if item.nextState or item.content then
			item.requiredState = item.requiredState or { [mission] = state }
		end
	end

	table.append(self.startupItems, { items = items, anchor = anchor })
	return self
end
---@private
function Quest:AddStartupScript(context)
	local script = context.script
	local mission, state = context.mission, context.state

	table.insert(self.startupScripts, { script = script, mission = mission, state = state })
	return self
end
--#endregion

--38f
function Quest:StartupNpcs(npcs, anchor)
	self.startupNpcs[npcs] = anchor
	return self
end

--[[
function Quest:Npc(name, context)
	self.npcs[name].context = self.npcs[name].context or {}
	for key, value in pairs(context) do
		self.npcs[name].context[key] = value
	end
	return self
end
]]

function Quest:Mission(mission)
	self.mission = mission
	return self
end
local scriptTypeToCallback = {
	[QUEST_SCRIPT_TYPE.DIALOG] = Quest.AddDialog,
	[QUEST_SCRIPT_TYPE.CUSTOM_SCRIPT] = Quest.AddScript,
	[QUEST_SCRIPT_TYPE.STARTUP_ITEMS] = Quest.AddStartupItems,
	[QUEST_SCRIPT_TYPE.STARTUP_SCRIPT] = Quest.AddStartupScript,
}
function Quest:State(state, ...)
	self.state = state
	for _, context in pairs({ ... }) do
		local callback = scriptTypeToCallback[context.scriptType]
		context.mission = self.mission
		context.state = state
		callback(self, context)
	end
	return self
end

function Quest:Register()
	for _, npc in pairs(self.npcs) do
		for _, mission in pairs(npc.missions or {}) do
			mission.localizer = mission.localizer or self.localizer
		end
	end
	QuestRegistry:Register(self)
end

local function normalizeQuestlogData()
	for _, quest in pairs(Quests) do
		for storage, mission in pairs(quest.missions) do
			mission.minState = mission.minState or 1
			mission.maxState = mission.maxState or #(mission.states or {})
			mission.finishedState = mission.finishedState or mission.maxState
			mission.storage = storage
		end
	end
end

local storageToMaxState = {}
local function extractExtraQuestlogData()
	for _, quest in pairs(Quests) do
		for storage, mission in pairs(quest.missions) do
			storageToMaxState[storage] = mission.maxState
		end
	end
end

function Player:setMissionFinishedByStorage(storage)
	local finishedState = storageToMaxState[storage]
	self:setStorageValue(storage, finishedState)
end

---@class QuestRegistry
---@field private registry table
QuestRegistry = {}
QuestRegistry.__index = QuestRegistry
QuestRegistry.registry = {}

function QuestRegistry:CreateQuestlog()
	for _, quest in pairs(self.registry) do
		quest.questlog()
	end
	normalizeQuestlogData()
	extractExtraQuestlogData()
end
function QuestRegistry:CreateMonsterEvent()
	for _, quest in pairs(self.registry) do
		for _, monsterEvent in pairs(quest.monsterEvents) do
			monsterEvent()
		end
	end
end
function QuestRegistry:CreateEncounters()
	for _, quest in pairs(self.registry) do
		for _, encounter in pairs(quest.encounters) do
			encounter()
		end
	end
end
function QuestRegistry:CreateMonster()
	for _, quest in pairs(self.registry) do
		for _, monster in pairs(quest.monsters) do
			monster()
		end
	end
end
function QuestRegistry:RegisterNpcData()
	for _, quest in pairs(self.registry) do
		for name, data in pairs(quest.npcs) do
			data.name = data.name or name
			data.localizer = data.localizer or quest.localizer
			NpcRegistry:AppendNpcData(data)
		end
	end
end
function QuestRegistry:CreateStartupItems()
	local startupItems = GlobalEvent("QuestSystemCreateStartupItems")
	function startupItems.onStartup()
		for _, quest in pairs(self.registry) do
			for _, itemsData in pairs(quest.startupItems) do
				LoadStartupItems(itemsData.items, itemsData.anchor)
			end
		end
	end
	startupItems:register()
end
function QuestRegistry:CreateStartupNpcs()
	local startupNpcs = GlobalEvent("QuestSystemCreateStartupNpcs")
	function startupNpcs.onStartup()
		for _, quest in pairs(self.registry) do
			for npcs, anchor in pairs(quest.startupNpcs) do
				LoadStartupNpcs(npcs, anchor)
			end
		end
	end
	startupNpcs:register()
end
function QuestRegistry:RunScripts()
	for _, quest in pairs(self.registry) do
		for _, scriptData in pairs(quest.scripts) do
			local script = scriptData.script
			script({ mission = scriptData.mission, state = scriptData.state })
		end
	end
end
function QuestRegistry:RegisterStartupScripts()
	local startupScripts = GlobalEvent("QuestSystemRegisterStartupScripts")
	function startupScripts.onStartup()
		for _, quest in pairs(self.registry) do
			for _, scriptData in pairs(quest.startupScripts) do
				local script = scriptData.script
				script({ mission = scriptData.mission, state = scriptData.state })
			end
		end
	end
	startupScripts:register()
end

function QuestRegistry:RegisterQuestData()
	self:CreateQuestlog()
	self:CreateMonsterEvent()
	self:CreateMonster()
	self:CreateEncounters()
	self:RegisterNpcData()
	self:CreateStartupItems()
	self:RunScripts()
	self:RegisterStartupScripts()
end

function QuestRegistry:Register(quest)
	self.registry[quest.name] = quest
	return self.registry[quest.name]
end

function QuestRegistry:Get(name)
	return self.registry[name]
end

--[[
---@class NpcContext
---@field public name string
---@field public greetJob string
---@field public jobs string[]
---@field public outfit number[]
---@field public dialogues table
---@field public voices string[]
---@field public pos Position
NpcContext = {}
NpcContext.__index = NpcContext
function NpcContext:New(...)
	local newObj = {}
	for key, value in pairs({ ... }) do
		newObj[key] = value
	end
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(NpcContext, {
	__call = function(class, ...)
		return NpcContext:New(...)
	end,
})
]]
--

---@class NpcRegistry
---@field private registry table
---@field private CreateNpcDefinitions function
NpcRegistry = {}
NpcRegistry.__index = NpcRegistry
NpcRegistry.registry = {}

---@package
function NpcRegistry:Register(name)
	self.registry[name] = { name = name, missions = {} }
	return self.registry[name]
end

---@package
function NpcRegistry:Get(name)
	return self.registry[name] or self:Register(name)
end

function NpcRegistry:AppendNpcData(data)
	local npc = self:Get(data.name)
	npc = MergedTable(npc, data)
	self.registry[data.name] = npc
end

function NpcRegistry:ExtractDialogs(npc)
	local extractedDialogs = {}

	for missionStorage, mission in pairs(npc.missions) do
		extractedDialogs[mission.localizer] = extractedDialogs[mission.localizer] or {}
		extractedDialogs[mission.localizer][missionStorage] = mission.states or {}
		for requiredState, stateData in pairs(mission.states or {}) do
			extractedDialogs[mission.localizer][missionStorage][requiredState] = stateData
		end
	end

	return extractedDialogs
end

function NpcRegistry:RegisterNpcDefinitions()
	for _, npc in pairs(self.registry) do
		npc.dialogs = self:ExtractDialogs(npc)
		RegisterNpcDefinition(npc)
	end
end
