-- quest system
PROMOTION_PRICE = 15000
PROMOTION_LEVEL = 20
ALL_BLESSINGS_COUNT = 5
ALL_CONDITIONS = {
	CONDITION_POISON,
	CONDITION_FIRE,
	CONDITION_ENERGY,
	CONDITION_BLEEDING,
	CONDITION_PARALYZE,
	CONDITION_DROWN,
	CONDITION_FREEZING,
	CONDITION_DAZZLED,
	CONDITION_CURSED,
}

TOPIC_DEFAULT = 0

MESSAGE_GREET = 1
MESSAGE_FAREWELL = 2
MESSAGE_WALKAWAY = 16
MESSAGE_SENDTRADE = 18

ANY_MESSAGE = "ANY_MESSAGE"
NOT_ENOUGH_CAP_OR_SLOTS = "NOT_ENOUGH_CAP_OR_SLOTS"

LOCALIZER_PRIEST = "LOCALIZER_PRIEST"
LOCALIZER_LUA_RAIDS = "LOCALIZER_LUA_RAIDS"
LOCALIZER_TASK_BOSS_LOCATIONS = "LOCALIZER_TASK_BOSS_LOCATIONS"
LOCALIZER_QUESTLOG = "LOCALIZER_QUESTLOG"
LOCALIZER_NPC_NAME = "LOCALIZER_NPC_NAME" -- modify cpp definition in case of changes
LOCALIZER_BANK_SYSTEM = "LOCALIZER_BANK_SYSTEM"

GREET = "DIALOG_MESSAGE_GREET"
FAREWELL = "DIALOG_MESSAGE_FAREWELL"
WALKAWAY = "DIALOG_MESSAGE_WALKAWAY"
SENDTRADE = "DIALOG_MESSAGE_SENDTRADE"
INCOMPREHENSIBLE = "DIALOG_MESSAGE_INCOMPREHENSIBLE"

MISSION_NOT_STARTED = -1
MISSION_STARTED = 1
MISSION_FINISHED = 2 ^ 31 - 1

DEFAULT_MAX_STATE = MISSION_FINISHED
DEFAULT_MIN_STATE = -MISSION_FINISHED

REPORT_TASK_TO_NPC = MISSION_FINISHED - 1

ACCESS_NOT_GRANTED = -1
ACCESS_GRANTED = 1
MISSION_START_VALUE = 1

ANY_STATE = { min = DEFAULT_MIN_STATE, max = DEFAULT_MAX_STATE }

TOPIC_DEFAULT = 0

REQUIREMENT_STATUS = {
	REQUIREMENT_PASSED = "REQUIREMENT_PASSED",
	REQUIREMENT_NOT_PASSED = "REQUIREMENT_NOT_PASSED",
	--Unused
	--AT_LEAST_ONE_CONDITION_PASSED = "AT_LEAST_ONE_CONDITION_PASSED"
	--NO_CONDITIONS_PASSED = "NO_CONDITIONS_PASSED"
}

RESOLVER_STATUS = {
	AT_LEAST_ONE_REQUIREMENT_NOT_PASSED = "AT_LEAST_ONE_REQUIREMENT_NOT_PASSED",
	ALL_REQUIREMENTS_PASSED = "ALL_REQUIREMENTS_PASSED",
}

DISCARD_DIALOG = "DISCARD_DIALOG"
SUCCESS_RESOLVE = "SUCCESS_RESOLVE"
FAIL_RESOLVE = "FAIL_RESOLVE"

local specialMessageTypes = { MESSAGE_GREET = MESSAGE_GREET, MESSAGE_FAREWELL = MESSAGE_FAREWELL, MESSAGE_WALKAWAY = MESSAGE_WALKAWAY, MESSAGE_SENDTRADE = MESSAGE_SENDTRADE }
local specialMessageTypeToMessage = {
	[MESSAGE_GREET] = GREET,
	[MESSAGE_FAREWELL] = FAREWELL,
	[MESSAGE_WALKAWAY] = WALKAWAY,
	[MESSAGE_SENDTRADE] = SENDTRADE,
}

local FIRST_AVAILABLE_TOPIC = 100000
NEXT_TOPIC = NEXT_TOPIC or FIRST_AVAILABLE_TOPIC
function NextTopic()
	NEXT_TOPIC = NEXT_TOPIC + 1
	return NEXT_TOPIC
end

function GrantPlayerExpByAid(player, actionId)
	local expValue = CustomItemRegistry:GetState(actionId).expReward
	if not expValue then
		return
	end
	AddExperienceWithAnnouncement(player, expValue)
end

function string:contains(patterns)
	if type(patterns) ~= "table" then
		return MsgContains(self, patterns)
	end
	for _, pattern in pairs(patterns) do
		if MsgContains(self, pattern) then
			return true
		end
	end
	return false
end

function Player:IncrementStorages(storages, addend)
	addend = addend or 1
	for _, storage in pairs(storages) do
		self:IncrementStorage(storage, addend)
	end
end

function Player:IncrementStorage(storage, addend)
	self:setStorageValueByKey(storage, self:getStorageValueByKey(storage) + (addend or 1))
	return self:getStorageValueByKey(storage)
end

function NextState(player, storages)
	for storage, newValue in pairs(storages) do
		player:setStorageValueByKey(storage, newValue)
	end
end

function Player:NextState(storages)
	if not storages then
		return false
	end
	for storage, nextValue in pairs(storages) do
		if type(nextValue) == "string" then
			self:IncrementStorage(storage, tonumber(nextValue))
		else
			self:setStorageValueByKey(storage, nextValue)
		end
	end
end

function Player:RefreshStorage(storage)
	local currentValue = self:getStorageValueByKey(storage)
	self:setStorageValueByKey(storage, currentValue)
end

function Player:RefreshStorages(storages)
	for storage, _ in pairs(storages) do
		self:RefreshStorage(storage)
	end
end

local function parseRequiredState(requiredState)
	local min
	local max
	local neq
	local excludeMin
	local excludeMax
	local errorMessage

	if type(requiredState) == "number" then
		min = requiredState
		max = requiredState
		neq = nil
		excludeMin = false
		excludeMax = false
		errorMessage = nil
	elseif type(requiredState) == "table" then
		min = requiredState.min or MISSION_NOT_STARTED
		max = requiredState.max or DEFAULT_MAX_STATE
		neq = requiredState.neq
		excludeMin = requiredState.excludeMin
		excludeMax = requiredState.excludeMax
		errorMessage = requiredState.errorMessage or nil
	end

	return {
		min = min,
		max = max,
		neq = neq,
		excludeMin = excludeMin,
		excludeMax = excludeMax,
		errorMessage = errorMessage,
	}
end

function Player:HasExactMissionState(missionState)
	return self:HasRequiredState(missionState.mission, missionState.state)
end

function Player:HasAtLeastMissionState(missionState)
	return self:HasRequiredState(missionState.mission, { min = missionState.state })
end

function Player:HasHigherMissionState(missionState)
	return self:HasRequiredState(missionState.mission, { min = missionState.state, excludeMin = true })
end

function Player:HasRequiredState(storage, requiredState)
	local currentState = self:getStorageValueByKey(storage)

	local requirements = parseRequiredState(requiredState)

	if requirements.excludeMin then
		if currentState <= requirements.min then
			return false
		end
	else
		if currentState < requirements.min then
			return false
		end
	end

	if requirements.excludeMin then
		if currentState >= requirements.max then
			return false
		end
	else
		if currentState > requirements.max then
			return false
		end
	end

	if requirements.neq ~= nil and requirements.neq == currentState then
		return false
	end

	return true
end

function Player:HasRequiredStates(requiredStates)
	if not requiredStates then
		return true
	end
	for storage, requiredState in pairs(requiredStates) do
		if not self:HasRequiredState(storage, requiredState) then
			return false
		end
	end
	return true
end

-- First matched incorrect value breaks the loop and returns an error
function Player:ErrorMessageIfHasIncorrectStorageValues(storages)
	if not storages then
		return true
	end
	for storage, requiredState in pairs(storages) do
		if not self:HasRequiredState(storage, requiredState) then
			if type(requiredState) == "table" then
				return requiredState.errorMessage, false
			end
			return nil, false
		end
	end
	return nil, true
end

function UpdateStorages(storages)
	for storage, newValue in pairs(storages) do
		Game.setStorageValueByKey(storage, newValue)
	end
end

function SpawnMonstersAtPos(monsterName, pos, count)
	count = count or 1
	for _ = 1, count do
		Game.createMonster(monsterName, pos)
	end
end

function SpawnMonstersAtPlayer(monsterName, player, count)
	if not player then
		return true
	end
	count = count or 1
	local pos = player:getPosition()
	for _ = 1, count do
		Game.createMonster(monsterName, pos)
	end
end

---@class DialogContext
---@field player Player player object
---@field cid number player id
---@field msg string player message
---@field npcDialogData table Dialog and dialogs
---@field npcHandler table
---@field npc userdata npc object
---@field specialMessageType string
---@field localizer number
---@field greetContext nil|table
---@field requirements table
---@field incomprehensibleError string
DialogContext = {}
DialogContext.__index = DialogContext
setmetatable(DialogContext, {
	__call = function(class, player, msg, npcDialogData, npcHandler, npc, specialMessageType)
		local instance = setmetatable({}, class)
		instance.player = player
		instance.cid = player:getId()
		instance.msg = msg
		if specialMessageType then
			instance.msg = specialMessageTypeToMessage[specialMessageType]
		end
		instance.npcDialogData = npcDialogData
		instance.npcHandler = npcHandler
		instance.npc = npc
		instance.specialMessageType = specialMessageType
		instance.requirements = nil
		instance.resolvedStatus = nil
		instance.patternFields = {}
		return instance
	end,
})

function DialogContext:GetGreetContext()
	return self.greetContext
end
function DialogContext:GetResolutionContext()
	return self.resolutionContext
end

function DialogContext:SendIncomprehensibleError()
	local player = self.player
	local npc = self.npc
	local npcHandler = self.npcHandler
	local incomprehensibleError = self.incomprehensibleError or INCOMPREHENSIBLE

	local errorMessage = player:Localizer(LOCALIZERS.Universal):Context(self):Get(incomprehensibleError)
	npcHandler:say(errorMessage, npc, player)
	return true
end

local function hasRequiredQuestlineState(state, requiredState)
	if type(requiredState) == "table" then
		local min = requiredState.min or -1
		local max = requiredState.max or DEFAULT_MAX_STATE
		if state < min then
			return false
		end
		if state > max then
			return false
		end
	elseif type(requiredState) == "number" then
		if state ~= requiredState then
			return false
		end
	end
	return true
end

local function isPattern(pattern)
	for _, value in pairs(pattern) do
		if value:gmatch("<[^%s]->")() then
			return true
		end
		if value:gmatch("%[[^%s]-%]")() then
			return true
		end
	end
	return false
end

PATTERN_MESSAGE_TYPE = {
	REQUIRED = "REQUIRED",
	OPTIONAL = "OPTIONAL",
	KEYWORD = "KEYWORD",
}

function DialogContext:ExtractPatternFields()
	local fields = {}
	local requiredFieldsCount = 0
	for k in self.pattern:gmatch("[^%s]+") do
		local wordData = {
			word = k,
			messageType = PATTERN_MESSAGE_TYPE.KEYWORD,
		}
		if k:gmatch("<.*>")() then
			wordData.word = k:gmatch("[^<>]+")()
			wordData.messageType = PATTERN_MESSAGE_TYPE.REQUIRED
			requiredFieldsCount = requiredFieldsCount + 1
		end
		if k:gmatch("%[.*%]")() then
			wordData.word = k:gmatch("[^%[%]]+")()
			wordData.messageType = PATTERN_MESSAGE_TYPE.OPTIONAL
		end

		table.insert(fields, wordData)
	end
	return fields, requiredFieldsCount
end

function DialogContext:IfPlayerMessageConformsToPattern(fields, requiredFields)
	local i = 1
	local requiredWordsMatched = 0
	self.patternFields = {}
	for playerWord in self.msg:gmatch("[^%s]+") do
		local field = fields[i]
		if not field then
			return false
		end
		if field.messageType == PATTERN_MESSAGE_TYPE.KEYWORD then
			if field.word ~= playerWord then
				return false
			end
		end
		if field.messageType == PATTERN_MESSAGE_TYPE.REQUIRED then
			self.patternFields[field.word] = playerWord
			requiredWordsMatched = requiredWordsMatched + 1
		end
		if field.messageType == PATTERN_MESSAGE_TYPE.OPTIONAL then
			self.patternFields[field.word] = playerWord
		end
		i = i + 1
	end
	if requiredWordsMatched < requiredFields then
		return false
	end
	return true
end

function DialogContext:MatchPattern()
	local fields, requiredFieldsCount = self:ExtractPatternFields()
	return self:IfPlayerMessageConformsToPattern(fields, requiredFieldsCount)
end

function DialogContext:PlayerSaidRequiredWord()
	local msg = self.msg
	local pattern = self.keyword
	if type(pattern) ~= "table" then
		pattern = { pattern }
	end
	if self.anyMessage and table.contains(pattern, ANY_MESSAGE) then
		return true
	end

	if not isPattern(pattern) then
		return table.contains(pattern, msg)
	end

	for _, value in pairs(pattern) do
		self.pattern = value
		if self:MatchPattern() then
			return true
		end
	end

	return false
end

-- refer to quest_system_doc.lua for guidelines
function TryResolveDialog(player, msg, npcDialogData, npcHandler, npc, messageType)
	player = Player(player)
	local dialogContext = DialogContext(player, msg, npcDialogData, npcHandler, npc, messageType)
	return dialogContext:TryResolveDialog():IsResolved()
end

function DialogContext:ResolveUniversalQuest()
	local universalKeywordToDialog = self.npcDialogData[LOCALIZERS.Universal]
	if not universalKeywordToDialog then
		return
	end
	self.localizer = LOCALIZERS.Universal
	self.keywordToDialog = universalKeywordToDialog
	self:ResolveKeyword()
	if self:IsResolved() then
		return
	end
end

function DialogContext:ResolveDialogDefault()
	for localizer, storageToRequiredState in pairs(self.npcDialogData) do
		if localizer == LOCALIZERS.Universal then
			goto continue
		end
		if type(storageToRequiredState) ~= "table" then
			logger.error("storages arent table!")
			return
		end
		self.localizer = localizer
		self.storageToRequiredState = storageToRequiredState
		self:ResolveStorage()
		if self:IsResolved() then
			return
		end
		::continue::
	end
	self:ResolveUniversalQuest()
end

function DialogContext:ResolveDialogAnyMsg()
	self.anyMessage = true
	self:ResolveDialogDefault()
end

function DialogContext:SetDefaultGreetFarewellWalkaway()
	if not self.specialMessageType then
		return
	end
	local translatedMessage = self.player:Localizer(LOCALIZERS.Universal):Context(self):Get(self.msg)
	self.npcHandler:setMessage(self.specialMessageType, translatedMessage)
	self.resolvedStatus = SUCCESS_RESOLVE
	self.greetContext = GreetCallbackContext()
end

local dialogResolvers = {
	DialogContext.ResolveDialogDefault,
	DialogContext.SetDefaultGreetFarewellWalkaway,
	DialogContext.ResolveDialogAnyMsg,
}

function DialogContext:TryResolveDialog()
	if not self.msg then
		return self
	end

	for _, resolver in pairs(dialogResolvers) do
		resolver(self)
		if self:IsResolved() then
			return self
		end
	end
	self:SendIncomprehensibleError()
	return self
end

function DialogContext:ResolveStorage()
	for storage, requiredStatetoKeywords in pairs(self.storageToRequiredState) do
		if storage == LOCALIZERS.Universal then
			goto continue
		end
		if type(requiredStatetoKeywords) ~= "table" then
			logger.error("keywords arent table!")
			return
		end
		self.storage = storage
		self.requiredStatetoKeywords = requiredStatetoKeywords
		self:ResolveState()
		if self:IsResolved() then
			return
		end
		::continue::
	end
end

function DialogContext:ResolveState()
	local state = self.player:getStorageValueByKey(self.storage)
	self.state = state
	for requiredState, keywordToDialog in pairs(self.requiredStatetoKeywords) do
		local canProceed = hasRequiredQuestlineState(state, requiredState)
		if not canProceed then
			goto continue
		end
		self.keywordToDialog = keywordToDialog
		self:ResolveKeyword()
		if self:IsResolved() then
			return
		end
		::continue::
	end
end

function DialogContext:ResolveKeyword()
	if not self.keywordToDialog then
		return
	end

	for keyword, data in pairs(self.keywordToDialog) do
		self.keyword = keyword
		if not self:PlayerSaidRequiredWord() then
			goto continue
		end
		local resolutionContext = ResolutionContext.FromDialogContext(self, data)
		self.patternFields = {}

		self.resolvedStatus = resolutionContext:Resolve()
		if self:IsResolved() then
			self.resolutionContext = resolutionContext
			self.greetContext = self.resolutionContext:GetGreetContext()
			return
		end
		::continue::
	end
end

function DialogContext:IsResolved()
	return self.resolvedStatus == SUCCESS_RESOLVE or self.resolvedStatus == FAIL_RESOLVE
end

function ParseTopicMinMax(config)
	local min = 0
	local max = 2 ^ 15

	local requiredTopic = config.requiredTopic
	if type(requiredTopic) == "number" then
		min = requiredTopic
		max = requiredTopic
	elseif type(requiredTopic) == "table" then
		min = requiredTopic.min
		max = requiredTopic.max
	end
	return min, max
end

function InitializeSpecialMessages(player, config, npcHandler, npc, msg)
	player = Player(player)

	PlayerDialogDataRegistry:Register(player)

	local cid = player:getId()
	npcHandler.topic[cid] = TOPIC_DEFAULT

	for _, specialMessageType in pairs({ specialMessageTypes.MESSAGE_WALKAWAY, specialMessageTypes.MESSAGE_FAREWELL, specialMessageTypes.MESSAGE_SENDTRADE }) do
		local dialogContext = DialogContext(player, msg, config, npcHandler, npc, specialMessageType)
		dialogContext:TryResolveDialog()
		if not dialogContext:IsResolved() then
			local message = player:Localizer(LOCALIZERS.Universal):Get(config[specialMessageType]) or player:Localizer(LOCALIZERS.Universal):Get(specialMessageType)
			npcHandler:setMessage(specialMessageType, message)
		end
	end

	local specialMessageType = specialMessageTypes.MESSAGE_GREET
	local dialogContext = DialogContext(player, msg, config, npcHandler, npc, specialMessageType)
	dialogContext:TryResolveDialog()
	if not dialogContext:IsResolved() then
		local message = player:Localizer(LOCALIZERS.Universal):Get(config[specialMessageType]) or player:Localizer(LOCALIZERS.Universal):Get(specialMessageType)
		npcHandler:setMessage(specialMessageType, message)
		return GreetCallbackContext()
	else
		return dialogContext:GetGreetContext()
	end
end

function InitializeGreet(player, config, npcHandler, npc, msg)
	player = Player(player)

	PlayerDialogDataRegistry:Register(player)
	local cid = player:getId()

	npcHandler.topic[cid] = TOPIC_DEFAULT

	local specialMessageType = specialMessageTypes.MESSAGE_GREET
	local dialogContext = DialogContext(player, msg, config, npcHandler, npc, specialMessageType)
	dialogContext:TryResolveDialog()
	if dialogContext:IsResolved() then
		return dialogContext:GetGreetContext()
	else
		local message = player:Localizer(LOCALIZERS.Universal):Get(config[specialMessageType]) or player:Localizer(LOCALIZERS.Universal):Get(specialMessageType)
		npcHandler:setMessage(specialMessageType, message)
		return GreetCallbackContext()
	end
end

PlayerDialogDataRegistry = {}
PlayerDialogDataRegistry.__index = PlayerDialogDataRegistry
PlayerDialogDataRegistry.registry = {}

PlayerCustomDialogDataRegistry = {}
PlayerCustomDialogDataRegistry.__index = PlayerCustomDialogDataRegistry
PlayerCustomDialogDataRegistry.registry = {}

PlayerDialogData = {}
function PlayerDialogData:New()
	local newObj = {}
	setmetatable(newObj, PlayerDialogData)
	newObj.data = {}
	self.__index = self
	return newObj
end
setmetatable(PlayerDialogData, {
	__call = function(class, ...)
		return class:New(...)
	end,
})

function PlayerDialogData:Add(data)
	table.insert(self.data, data)
	return self
end
function PlayerDialogData:Latest()
	return self.data[#self.data] or {}
end
function PlayerDialogData:Previous()
	return self.data[#self.data - 1] or {}
end
function PlayerDialogData:ByIndex(index)
	return self.data[index] or {}
end

function PlayerDialogDataRegistry:Register(player)
	self.registry[player:getId()] = PlayerDialogData()
	return self.registry[player:getId()]
end
function PlayerDialogDataRegistry:Get(player)
	local playerId = player:getId()
	self.registry[playerId] = self.registry[playerId] or self:Register(player)
	return self.registry[playerId]
end

function PlayerCustomDialogDataRegistry:Register(player)
	self.registry[player:getId()] = PlayerDialogData()
	return self.registry[player:getId()]
end

function PlayerCustomDialogDataRegistry:Get(player)
	local playerId = player:getId()
	self.registry[playerId] = self.registry[playerId] or self:Register(player)
	return self.registry[player:getId()]
end

function dump2(object)
	if type(object) == "table" then
		local partialResult = "{ "
		for key, value in pairs(object) do
			partialResult = partialResult .. "[" .. tostring(key) .. "] = " .. dump2(value) .. ","
		end
		return partialResult .. "} "
	else
		return tostring(object)
	end
end
