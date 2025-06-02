---@class Quest
---@field name string
---@field monsterEvents table
---@field encounters table
---@field monsters table
---@field scripts table
---@field npcs table
---@field onUseDeclarations table
---@field questlog function
---@field currentMission integer
---@field missions table
---@field state integer
---@field localizer string
Quest = {}
Quest.__index = Quest
function Quest:New(name)
	local newObj = {
		name = name,
		localizer = name,
		missions = {},
		currentMission = 0,
		monsterEvents = {},
		encounters = {},
		monsters = {},
		scripts = {},
		npcs = {},
		onUseDeclarations = {},
		questlog = nil,
	}

	setmetatable(newObj, self)
	return newObj
end
setmetatable(Quest, {
	---@return Quest Quest
	__call = function(class, ...)
		return class:New(...)
	end,
})

QUEST_SCRIPT_TYPE = {
	DIALOG = "DIALOG",
	CUSTOM_SCRIPT = "CUSTOM_SCRIPT",
	ON_USE_DECLARATION = "ON_USE_DECLARATION",
}

function Quest:GetName()
	return self.name
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
function Quest:NoQuestlog()
	self.questlog = function() end
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
function QuestFactory.OnUseDeclarations(items)
	return { items = items, scriptType = QUEST_SCRIPT_TYPE.ON_USE_DECLARATION }
end
function Quest:Script(script)
	table.insert(self.scripts, { script = script })
	return self
end
function Quest:OnUseDeclaration(items, anchor) --Unused
	table.insert(self.onUseDeclarations, { items = items, anchor = anchor })
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
	if not names then
		logger.debug(T(":quest: missing name for dialog", { quest = self.name }))
	end

	for _, lang in pairs(LANGUAGES) do
		for requredKeywords, actionsAndRequirements in pairs(dialogs) do
			for key, value in pairs(actionsAndRequirements) do
				if type(value) == "string" then
					MissingStrings:TestAllLanaguages(value, self.localizer)
				end
			end
		end
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
		self.npcs[name].missions[mission].localizer = self.localizer
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
function Quest:AddOnUseDeclaration(context)
	local items, anchor = context.items, context.anchor
	local mission, state = context.mission, context.state

	for _, item in pairs(items) do
		-- default: onUse requiredState is exact mission state it was declared in
		if not item.requiredState then
			item.requiredState = {}
			item.requiredState[mission] = state
		end
		if item.key then
			item.requiredState[item.key] = MISSION_NOT_STARTED

			item.nextState = item.nextState or {}
			item.nextState[item.key] = item.nextState[item.key] or MISSION_FINISHED
		end
	end

	table.insert(self.onUseDeclarations, { items = items, anchor = anchor })
	return self
end
--#endregion

function Quest:Mission(mission)
	if self.missions[mission] then
		logger.error(T("[Quest:Mission] Mission :storage: was already registered!!!", { storage = mission }))
		return
	end

	self.currentMission = mission
	self.missions[self.currentMission] = {}
	return self
end
local scriptTypeToCallback = {
	[QUEST_SCRIPT_TYPE.DIALOG] = Quest.AddDialog,
	[QUEST_SCRIPT_TYPE.CUSTOM_SCRIPT] = Quest.AddScript,
	[QUEST_SCRIPT_TYPE.ON_USE_DECLARATION] = Quest.AddOnUseDeclaration,
}

function Quest:State(stateDataCallback)
	table.insert(self.missions[self.currentMission], stateDataCallback)
	return self
end

function Quest:Register()
	if not self.questlog then
		logger.error(debug.traceback(T("Quest :name: has no questlog. Define questlog with Quest::Questlog or explicitly declare no questlog with Quest::NoQuestlog", { name = self:GetName() })))
	end

	QuestRegistry:Register(self)
end

local storageToMaxState = {}
local function questlogLookups()
	for _, quest in pairs(Quests) do
		for _, mission in pairs(quest.missions) do
			storageToMaxState[mission.storage] = mission.maxState
		end
	end
end

function Player:setMissionFinishedByStorage(storage)
	local finishedState = storageToMaxState[storage]
	self:setStorageValueByKey(storage, finishedState)
end

---@class QuestRegistry
---@field private registry table
QuestRegistry = {}
QuestRegistry.__index = QuestRegistry
QuestRegistry.registry = {}

function QuestRegistry:UnpackStateData()
	for _, quest in pairs(self.registry) do
		for missionStorage, states in pairs(quest.missions) do
			for _, stateData in pairs(states) do
				local context = { stateData() }
				local state = context[1]

				for i, data in ipairs(context) do
					if i ~= 1 then
						local callback = scriptTypeToCallback[data.scriptType]
						data.mission = missionStorage
						data.state = state
						callback(quest, data)
					end
				end
			end
		end
	end
end

function QuestRegistry.NormalizeQuestlog()
	local normalizeQuestlogStartup = GlobalEvent("Quest/NormalizeQuestlog")
	function normalizeQuestlogStartup.onStartup()
		for _, quest in pairs(Quests) do
			quest.questId = NextQuestId()
			IdToQuest[quest.questId] = quest
			for _, mission in pairs(quest.missions) do
				local min, max
				if mission.states then
					min, max = FindMinMaxKey(mission.states)
				end
				mission.minState = mission.minState or min or DEFAULT_MIN_STATE
				mission.maxState = mission.maxState or max or DEFAULT_MAX_STATE
				mission.finishedState = mission.finishedState or MISSION_FINISHED
				mission.missionId = NextMissionId()
				for _, desc in pairs(mission.states or {}) do
					if type(desc) == "string" then
						MissingStrings:TestAllLanaguages(desc, quest.localizer)
					end
				end

				StorageToMission[mission.storage] = mission
				IdToMission[mission.missionId] = mission
				Game.linkMissionToStorages(mission.storage, mission.linkedStorages or {})
			end
		end
	end
	normalizeQuestlogStartup:register()
end

function QuestRegistry:CreateQuestlog()
	for _, quest in pairs(self.registry) do
		quest.questlog(quest.localizer)
	end
end
function QuestRegistry:CreateMonstersEvents()
	for _, quest in pairs(self.registry) do
		for _, monsterEvent in pairs(quest.monsterEvents) do
			monsterEvent()
		end
	end
end
function QuestRegistry:CreateEncounters()
	local encountersStartup = GlobalEvent("Quest/CreateEncounters")
	function encountersStartup.onStartup()
		for _, quest in pairs(self.registry) do
			for _, encounter in pairs(quest.encounters) do
				encounter()
			end
		end
	end
	encountersStartup:register()
end
function QuestRegistry:CreateMonsters()
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
function QuestRegistry:RegisterOnUseDeclarations()
	local onUseDeclarations = GlobalEvent("Quest/RegisterOnUseDeclarations")
	function onUseDeclarations.onStartup()
		for _, quest in pairs(self.registry) do
			for _, itemsData in pairs(quest.onUseDeclarations) do
				RegisterOnUseDeclaration(itemsData.items, itemsData.anchor)
			end
		end
	end
	onUseDeclarations:register()
end
function QuestRegistry:RunScripts()
	for _, quest in pairs(self.registry) do
		for _, scriptData in pairs(quest.scripts) do
			local script = scriptData.script
			script({ mission = scriptData.mission, state = scriptData.state })
		end
	end
end

local function normalizeItem(item)
	local normalized = {}
	normalized.id = item.id
	normalized.aid = item.aid or item.actionid or item.actionId
	normalized.uid = item.uid or item.uniqueid or item.uniqueId
	normalized.key = item.key
	normalized.pos = item.pos or item.position
	return normalized
end

local function generateDummyAction(keyItem)
	local dummyAction = Action()
	function dummyAction.onUse(_, _, _, _, _, _)
		return false
	end
	local normalized = normalizeItem(keyItem)
	if normalized.id then
		dummyAction:id(normalized.id)
	end
	if normalized.aid then
		dummyAction:aid(normalized.aid)
	end
	if normalized.uid then
		dummyAction:uid(normalized.uid)
	end
	if normalized.pos then
		dummyAction:position(normalized.pos)
	end
	if normalized.key then
		dummyAction:key(normalized.key)
	end

	return dummyAction
end

local function registerDummyActions()
	for quest, keyItems in pairs(QuestKeyItems) do
		for _, keyItem in pairs(keyItems) do
			local dummyAction = generateDummyAction(keyItem)
			if not dummyAction:isRegistered() then
				dummyAction:register()
			end
		end
	end
end

function QuestRegistry:RegisterQuestData()
	self:UnpackStateData()
	self:CreateQuestlog()
	self:CreateMonstersEvents()
	self:CreateMonsters()
	self:CreateEncounters()
	self:RegisterNpcData()
	self:RegisterOnUseDeclarations()
	self:RunScripts()
	self.NormalizeQuestlog()
	questlogLookups()
	registerDummyActions()
end

function QuestRegistry:Register(quest)
	table.insert(self.registry, quest)
	return self
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

function NpcRegistry:GetAll()
	return self.registry
end

function NpcRegistry:AppendNpcData(data)
	local npc = self:Get(data.name)
	npc = MergedTable(npc, data)
	self.registry[data.name] = npc
end

function NpcRegistry:ExtractDialogs(npc)
	local extractedDialogs = {}

	for missionState, mission in pairs(npc.missions) do
		extractedDialogs[mission.localizer] = extractedDialogs[mission.localizer] or {}
		extractedDialogs[mission.localizer][missionState] = mission.states or {}
		for requiredState, stateData in pairs(mission.states or {}) do
			extractedDialogs[mission.localizer][missionState][requiredState] = stateData
		end
	end
	extractedDialogs[LOCALIZERS.Universal] = npc.dialogs

	return extractedDialogs
end

function NpcRegistry:RegisterNpcDefinitions()
	for _, npc in pairs(self.registry) do
		npc.dialogs = self:ExtractDialogs(npc)
		RegisterNpcDefinition(npc)
	end
end
