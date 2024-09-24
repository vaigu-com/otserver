---@class Quest
Quest = {}
function Quest:New(name)
	local newObj = {}
	self.name = name
	self.missions = {}
	self.constants = {}
	self.monsterEvents = {}
	self.encounterLevers = {}
	self.encounterFights = {}
	self.monsters = {}
	self.scripts = {}
	self.npcs = {}
	self.startupItems = {}
	self.startupNpcs = {}
	self.storages = function() end
	self.questlog = function() end

	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(Quest, {
	__call = function(class, ...)
		return Quest:New(...)
	end,
})

function Quest:Mission(mission)
	self.mission = mission
	return self
end
function Quest:State(state)
	self.state = state
	return self
end

function Quest:Dialog(npcName, dialog)
	self.npcs[npcName] = self.npcs[npcName] or {}
	self.npcs[npcName].missions = self.npcs[npcName].missions or {}
	self.npcs[npcName].missions[self.mission] = self.npcs[npcName].missions[self.mission] or {}
	self.npcs[npcName].missions[self.mission].states = self.npcs[npcName].missions[self.mission].states or {}
	self.npcs[npcName].missions[self.mission].states[self.state] = dialog
	return self
end
function Quest:Storage(storages)
	self.storages = storages
end
function Quest:Constant(constant)
	table.insert(self.constants, constant)
	return self
end
function Quest:Questlog(questlog)
	self.questlog = questlog
end
function Quest:MonsterEvent(MonsterEvent)
	table.insert(self.monsterEvents, MonsterEvent)
	return self
end
function Quest:EncounterLever(lever)
	table.insert(self.encounterLevers, lever)
end
function Quest:EncounterFight(fight)
	table.insert(self.encounterFights, fight)
end
function Quest:Monster(monster)
	table.insert(self.monsters, monster)
	return self
end
function Quest:StartupItems(items, anchor)
	--[[
	ToDo: check all quests if this is necessary
	for key, item in pairs(items) do
		if item.rewards then
			item.requiredState = { [self.mission] = self.state }
		end
	end
	]]


	self.startupItems[items] = anchor
end
function Quest:StartupNpcs(npcs, anchor)
	self.startupNpcs[npcs] = anchor
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

function Quest:Script(script)
	table.insert(self.scripts, script)
end

function Quest:Register()
	QuestRegistry:Register(self)
end

--
local function normalizeQuestData()
	for questId, quest in pairs(Quests) do
		for missionNumber, mission in pairs(quest.missions) do
			mission.startValue = mission.startValue or 0
			mission.endValue = mission.endValue or #mission.states
		end
	end
end

function QuestRegistry:CreateConstants()
	for _, quest in pairs(self.registry) do
		for _, constants in pairs(quest.constants) do
			constants()
		end
	end
end
function QuestRegistry:CreateStorages()
	for _, quest in pairs(self.registry) do
		quest.storages()
	end
end

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
			NpcRegistry():AddNpcData(npcName, data)
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
		for _, script in pairs(quest.scripts) do
			script()
		end
	end
end

---@class QuestRegistry
---@field private registry table
QuestRegistry = {}
local QuestRegistrySingleton = nil
function QuestRegistry:New(...)
	if QuestRegistrySingleton then
		return QuestRegistrySingleton
	end
	QuestRegistrySingleton = {}
	self.__index = self
	self.registry = {}
	setmetatable(QuestRegistrySingleton, self)
	self:CreateQuests()
	return QuestRegistrySingleton
end
setmetatable(QuestRegistry, {
	__call = function(class, ...)
		return QuestRegistry:New(...)
	end,
})

print(Storage.Exercisedummy	)
function QuestRegistry:CreateQuests()
	local questSystemNpcDefinitions = GlobalEvent("QuestSystemQuestDefinitions")
	function questSystemNpcDefinitions.onStartup()
		self:CreateConstants()
		self:CreateStorages()
		self:CreateQuestlog()
		self:CreateMonsterEvent()
		self:CreateEncounterLevers()
		self:CreateEncounterFight()
		self:CreateMonster()
		self:RegisterNpcData()
		NpcRegistry:CreateNpcs()
		self:RunScripts()
	end
	questSystemNpcDefinitions:register()
end

function QuestRegistry:Register(quest)
	self.registry[quest.name] = quest
	return self[quest.name]
end

function QuestRegistry:Get(name)
	return self.registry[name]
end

function NpcRegistry:CreateNpcs()
	for _, npc in pairs(self.registry) do
		CreateNpcDefinition(npc)
	end
end

---@class NpcRegistry
---@field private registry table
---@field private CreateNpcDefinitions function
NpcRegistry = {}
local npcRegistrySingleton = nil
function NpcRegistry:New(...)
	if npcRegistrySingleton then
		return npcRegistrySingleton
	end
	npcRegistrySingleton = {}
	self.__index = self
	self.registry = {}
	setmetatable(npcRegistrySingleton, self)
	return npcRegistrySingleton
end
setmetatable(NpcRegistry, {
	__call = function(class, ...)
		return NpcRegistry:New(...)
	end,
})

function NpcRegistry:Register(name)
	self.registry[name] = {}
	return self.registry[name]
end

function NpcRegistry:Get(name)
	return self.registry[name] or self:Register(name)
end

function NpcRegistry:AddNpcData(name, newData)
	local npcData = self:Get(name)
	npcData = MergedTable(npcData, newData)
	self.registry[name] = npcData
end
