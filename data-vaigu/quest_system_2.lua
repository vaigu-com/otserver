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
---@field localizer string
Quest = {}
Quest.__index = Quest
function Quest:New(name)
	local newObj = {
		name = name,
		missions = {},
		monsterEvents = {},
		encounterLevers = {},
		encounterFights = {},
		monsters = {},
		scripts = {},
		npcs = {},
		startupItems = {},
		startupNpcs = {},
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
function Quest:Localizer(localizer)
	self.localizer = localizer
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
function Quest.Dialog(name, dialogs)
	return { name = name, dialogs = dialogs, scriptType = QUEST_SCRIPT_TYPE.DIALOG }
end
function Quest.Script(script)
	return { script = script, scriptType = QUEST_SCRIPT_TYPE.CUSTOM_SCRIPT }
end
function Quest.StartupItems(items, anchor)
	return { items = items, anchor = anchor, scriptType = QUEST_SCRIPT_TYPE.STARTUP_ITEMS }
end
---@private
function Quest:AddDialog(context)
	local name, dialogs = context.name, context.dialogs
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

	self.npcs[name] = self.npcs[name] or {}
	self.npcs[name].missions = self.npcs[name].missions or {}
	self.npcs[name].missions[mission] = self.npcs[name].missions[mission] or {}
	self.npcs[name].missions[mission].states = self.npcs[name].missions[mission].states or {}
	self.npcs[name].missions[mission].states[state] = dialogs
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

	--38f
	for key, item in pairs(items) do
		if item.nextState or item.content then
			item.requiredState = item.requiredState or { [mission] = state }
		end
	end

	table.append(self.startupItems, { items = items, anchor = anchor })
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
		for _, mission in pairs(npc.missions) do
			mission.localizer = mission.localizer or self.localizer --or LOCALIZERS.LOCALIZER_UNIVERSAL --38f
		end
	end
	QuestRegistry:Register(self)
end

local function normalizeQuestlogData()
	for _, quest in pairs(Quests) do
		for storage, mission in pairs(quest.missions) do
			mission.minstate = mission.minstate or 1
			mission.maxState = mission.maxState or #(mission.states or {})
			mission.completedState = mission.completedState or mission.maxState
			mission.storage = storage
		end
	end
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
		print("startupItems::onStartup")
		print(next(self.registry))
		for _, quest in pairs(self.registry) do
			print("questASD", quest.startupItems)
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

function QuestRegistry:RegisterQuestData()
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
	self.registry[name] = { name = name }
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
	print("NpcRegistry::ExtractDialogs")
	for name, mission in pairs(npc.missions) do
		print("missionData K V")
		for key, value in pairs(mission) do
			print(key, value)
		end
		extractedDialogs[mission.localizer] = {}
		for requiredState, stateData in pairs(mission.states) do
			extractedDialogs[mission.localizer][requiredState] = stateData
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
