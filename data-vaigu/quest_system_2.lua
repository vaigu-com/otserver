---@class Quest
---@field name string
---@field missions table
---@field monsterEvents table
---@field encounterLevers table
---@field encounterFights table
---@field monsters table
---@field scripts table
---@field npcs table
---@field startupItems table
---@field startupNpcs table
---@field questlog table
---@field mission integer
---@field state integer
Quest = {}
Quest.__index = Quest
function Quest:New(name)
	local newObj = {}
	newObj.name = name
	newObj.missions = {}
	newObj.monsterEvents = {}
	newObj.encounterLevers = {}
	newObj.encounterFights = {}
	newObj.monsters = {}
	newObj.scripts = {}
	newObj.npcs = {}
	newObj.startupItems = {}
	newObj.startupNpcs = {}
	newObj.questlog = function() end

	setmetatable(newObj, self)
	return newObj
end
setmetatable(Quest, {
	__call = function(class, ...)
		return Quest:New(...)
	end,
})

QUEST_SCRIPT_TYPE = {
	DIALOG = "DIALOG",
	CUSTOM_SCRIPT = "CUSTOM_SCRIPT",
	STARTUP_ITEMS = "STARTUP_ITEMS",
}

local scriptTypeToCallback = {
	[QUEST_SCRIPT_TYPE.DIALOG] = Quest.AddDialog,
	[QUEST_SCRIPT_TYPE.CUSTOM_SCRIPT] = Quest.AddScript,
	[QUEST_SCRIPT_TYPE.STARTUP_ITEMS] = Quest.AddStartupItems,
}

function Quest:Mission(mission)
	self.mission = mission
	return self
end

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
function Quest:EncounterLever(lever)
	table.insert(self.encounterLevers, lever)
	return self
end
function Quest:EncounterFight(fight)
	table.insert(self.encounterFights, fight)
	return self
end
function Quest:Monster(monster)
	table.insert(self.monsters, monster)
	return self
end
--#endregion

--#reqion Quest state dependant
function Quest.Dialog(npcName, dialogs)
	return { npcName = npcName, dialogs = dialogs, scriptType = QUEST_SCRIPT_TYPE.DIALOG }
end
function Quest.Script(func)
	return { func = func, scriptType = QUEST_SCRIPT_TYPE.CUSTOM_SCRIPT }
end
function Quest.StartupItems(items, anchor)
	return { items = items, anchor = anchor, scriptType = QUEST_SCRIPT_TYPE.STARTUP_ITEMS }
end
---@private
function Quest:AddDialog(context)
	local npcName, dialog = context.npcName, context.dialog
	local mission, state = context.mission, context.state

	self.npcs[npcName] = self.npcs[npcName] or {}
	self.npcs[npcName].missions = self.npcs[npcName].missions or {}
	self.npcs[npcName].missions[mission] = self.npcs[npcName].missions[mission] or {}
	self.npcs[npcName].missions[mission].states = self.npcs[npcName].missions[mission].states or {}
	self.npcs[npcName].missions[mission].states[state] = dialog
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
	local items, anchor = context.items, context.achor
	local mission, state = context.mission, context.state
	--This addition might prove to be breaking change
	for key, item in pairs(items) do
		if item.nextState or item.content then
			item.requiredState = item.requiredState or { [self.mission] = self.state }
		end
	end

	self.startupItems[items] = anchor
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

function Quest:Register()
	QuestRegistry():Register(self)
end

local function normalizeQuestData()
	for questId, quest in pairs(Quests) do
		for missionNumber, mission in pairs(quest.missions) do
			mission.startValue = mission.startValue or 0
			mission.endValue = mission.endValue or #mission.states
		end
	end
end

---@class QuestRegistry
---@field private registry table
QuestRegistry = {}
QuestRegistry.__index = QuestRegistry
local QuestRegistrySingleton = nil
function QuestRegistry:New(...)
	if QuestRegistrySingleton then
		return QuestRegistrySingleton
	end
	QuestRegistrySingleton = {}
	QuestRegistrySingleton.__index = self
	self.registry = {}
	setmetatable(QuestRegistrySingleton, self)
	return QuestRegistrySingleton
end
setmetatable(QuestRegistry, {
	__call = function(class, ...)
		return QuestRegistry:New(...)
	end,
})

function QuestRegistry:CreateQuestlog()
	for _, quest in pairs(self.registry) do
		quest.questlog()
	end
	normalizeQuestData()
end
function QuestRegistry:CreateMonsterEvent()
	for _, quest in pairs(self.registry) do
		for _, monsterEvent in pairs(quest.monsterEvents) do
			monsterEvent()
		end
	end
end
function QuestRegistry:CreateEncounterLevers()
	for _, quest in pairs(self.registry) do
		for _, lever in pairs(quest.encounterLevers) do
			lever()
		end
	end
end
function QuestRegistry:CreateEncounterFight()
	for _, quest in pairs(self.registry) do
		for _, fight in pairs(quest.encounterFights) do
			fight()
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
		for npcName, data in pairs(quest.npcs) do
			NpcRegistry:AppendNpcData(data)
		end
	end
end
function QuestRegistry:CreateStartupItems()
	local startupItems = GlobalEvent("QuestSystemCreateStartupItems")
	function startupItems.onStartup()
		for _, quest in pairs(self.registry) do
			for items, anchor in pairs(quest.startupItems) do
				LoadStartupItems(items, anchor)
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

function QuestRegistry:CreateQuests()
	self:CreateQuestlog()
	self:CreateMonsterEvent()
	self:CreateEncounterLevers()
	self:CreateEncounterFight()
	self:CreateMonster()
	self:RegisterNpcData()
	NpcRegistry:RegisterNpcDefinitions()
	self:CreateStartupItems()
	self:RunScripts()
end

function QuestRegistry:Register(quest)
	self.registry[quest.name] = quest
	return self.registry[quest.name]
end

function QuestRegistry:Get(name)
	return self.registry[name]
end

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

---@class NpcRegistry
---@field private registry table
---@field private CreateNpcDefinitions function
NpcRegistry = {}
NpcRegistry.__index = NpcRegistry
local npcRegistrySingleton = nil
function NpcRegistry:New(...)
	if npcRegistrySingleton then
		return npcRegistrySingleton
	end
	npcRegistrySingleton = {}
	npcRegistrySingleton.__index = self
	self.registry = {}
	setmetatable(npcRegistrySingleton, self)
	return npcRegistrySingleton
end
setmetatable(NpcRegistry, {
	__call = function(class, ...)
		return NpcRegistry:New(...)
	end,
})

---@package
function NpcRegistry:Register(name)
	self.registry[name] = { name = name }
	return self.registry[name]
end

---@package
function NpcRegistry:Get(name)
	return self.registry[name] or self:Register(name)
end

---@param newData NpcContext
function NpcRegistry:AppendNpcData(newData)
	local name = newData.name
	local npcData = self:Get(name)
	npcData = MergedTable(npcData, newData)
	self.registry[name] = npcData
end

function NpcRegistry:RegisterNpcDefinitions()
	for _, npc in pairs(self.registry) do
		RegisterNpcDefinition(npc)
	end
end
