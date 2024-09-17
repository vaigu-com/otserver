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
-- Todo: make "data\npclib\npc_system\npc_handler.lua" load from lua; fix npc's after server reload
TOPIC_DEFAULT = 0

MESSAGE_GREET = 1
MESSAGE_FAREWELL = 2
MESSAGE_WALKAWAY = 16

ANY_MESSAGE = "ANY_MESSAGE"
NOT_ENOUGH_CAP_OR_SLOTS = "NOT_ENOUGH_CAP_OR_SLOTS"

LOCALIZER_UNIVERSAL = "LOCALIZER_UNIVERSAL"
LOCALIZER_PRIEST = "LOCALIZER_PRIEST"
LOCALIZER_LUA_RAIDS = "LOCALIZER_LUA_RAIDS"
LOCALIZER_TASK_BOSS_LOCATIONS = "LOCALIZER_TASK_BOSS_LOCATIONS"
LOCALIZER_QUESTLOG = "LOCALIZER_QUESTLOG"
LOCALIZER_NPC_NAME = "LOCALIZER_NPC_NAME" -- modify cpp definition in case of changes
LOCALIZER_BANK_SYSTEM = "LOCALIZER_BANK_SYSTEM"
GREET = "LOCALIZER_GREET"
FAREWELL = "LOCALIZER_FAREWELL"
WALKAWAY = "LOCALIZER_WALKAWAY"

QUEST_NOT_STARTED = -1

CONDITION_STATUS = {
	CONDITION_PASSED = "CONDITION_PASSED",
	CONDITION_NOT_PASSED = "CONDITION_NOT_PASSED",
	AT_LEAST_ONE_CONDITION_NOT_PASSED = "AT_LEAST_ONE_CONDITION_NOT_PASSED",
	ALL_CONDITIONS_PASSED = "ALL_CONDITIONS_PASSED",
}

DISCARD_DIALOG = "DISCARD_DIALOG"
SUCCESS_RESOLVE = "SUCCESS_RESOLVE"
FAIL_RESOLVE = "FAIL_RESOLVE"

local defaultMaxState = 99999

local specialMessageTypes = { MESSAGE_GREET, MESSAGE_FAREWELL, MESSAGE_WALKAWAY }
local specialMessageTypeToMessage = {
	[MESSAGE_GREET] = "LOCALIZER_GREET",
	[MESSAGE_FAREWELL] = "LOCALIZER_FAREWELL",
	[MESSAGE_WALKAWAY] = "LOCALIZER_WALKAWAY",
}

-- ToDo: create item kv field (string) in rme
-- ToDo: storage keys will be converted to kv, therefore this function will no longer be needed
local FIRST_AVAILABLE_STORAGE = 8100
NEXT_STORAGE = NEXT_STORAGE or FIRST_AVAILABLE_STORAGE
function NextStorage()
	NEXT_STORAGE = NEXT_STORAGE + 1
	return NEXT_STORAGE
end

function GrantPlayerExpByAid(player, actionId)
	local expValue = CustomItemRegistry():GetState(actionId).expReward
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
	self:setStorageValue(storage, self:getStorageValue(storage) + (addend or 1))
	return self:getStorageValue(storage)
end

function UpdateStorages(player, storages)
	for storage, newValue in pairs(storages) do
		player:setStorageValue(storage, newValue)
	end
end

function Player:UpdateStorages(storages)
	if not storages then
		return false
	end
	for storage, newValue in pairs(storages) do
		if type(newValue) == "string" then
			self:IncrementStorage(storage, tonumber(newValue))
		else
			self:setStorageValue(storage, newValue)
		end
	end
end

function Player:RefreshStorage(storage)
	local currentValue = self:getStorageValue(storage)
	self:setStorageValue(storage, currentValue)
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
	local errorMessage

	if type(requiredState) == "number" then
		min = requiredState
		max = defaultMaxState
		neq = nil
		errorMessage = ""
	elseif type(requiredState) == "table" then
		min = requiredState.min or QUEST_NOT_STARTED
		max = requiredState.max or defaultMaxState
		neq = requiredState.neq
		errorMessage = requiredState.errorMessage or ""
	end

	return min, max, neq, errorMessage
end

function Player:HasCorrectStorageValues(storages)
	if not storages then
		return true
	end
	for storage, requiredState in pairs(storages) do
		local min, max, neq = parseRequiredState(requiredState)

		local currentState = self:getStorageValue(storage)
		if currentState < min then
			return false
		end
		if currentState > max then
			return false
		end
		if neq ~= nil and neq == currentState then
			return false
		end
	end
	return true
end

-- First matched incorrect value returns error
function Player:ErrorMessageIfHasIncorrectStorageValues(storages)
	if not storages then
		return true
	end
	for storage, requiredState in pairs(storages) do
		local min, max, neq, errorMessage = parseRequiredState(requiredState)

		local currentState = self:getStorageValue(storage)
		if currentState < min then
			return errorMessage
		end
		if currentState > max then
			return errorMessage
		end
		if neq ~= nil and neq == currentState then
			return errorMessage
		end
	end
	return nil
end

function UpdateGlobalStorages(storages)
	for storage, newValue in pairs(storages) do
		Game.setStorageValue(storage, newValue)
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

function Player:AddOutfitsAndAddons(outfitsAndAddons)
	for _, data in pairs(outfitsAndAddons) do
		local outfit = data.outfitId or data.outfit
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
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("You received :exp: experience!", { exp = exp }))
	player:addExperience(exp)
	player:getPosition():sendMagicEffect(CONST_ME_STUN)
end

---@class DialogContext
---@field player Player player object
---@field cid number player id
---@field msg string player message
---@field npcDialogData table Dialog and dialogs
---@field npcHandler table
---@field npc userdata npc object
---@field specialMessageType string
---@field questlineAid number
---@field dialogs table
---@field requirements table
---@alias Player table
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
		return instance
	end,
})

local requirementsWhitelist = {
	requiredTopic = true,
	requiredItems = true,
	requiredState = true,
	requiredGlobalState = true,
	requiredMoney = true,
	specialConditions = true,
}
local actionsWhitelist = {
	specialActionsOnSuccess = true,
	removeRequiredItems = true,
	rewards = true,
	spawnMonstersOnSuccess = true,
	outfitRewards = true,
	mountRewards = true,
	expReward = true,
	nextState = true,
	nextGlobalState = true,
	nextTopic = true,
	preserveTopic = true,
	addDialogData = true,
	text = true,
}

---@class ResolutionContext
---@field requirements table
---@field actionsOnSuccess table
---@field player Player
---@field cid integer?
---@field npc Npc?
---@field specialMessageType string?
---@field questlineAid integer
---@field npcHandler NpcHandler?
---@field topic integer?
---@field extractedParams table
ResolutionContext = {}
ResolutionContext.__index = ResolutionContext
setmetatable(ResolutionContext, {
	__call = function(class, ...)
		return class:New(...)
	end,
})

function ResolutionContext.FromDialogContext(context, data)
	local newObj = {}
	setmetatable(newObj, ResolutionContext)
	newObj:ParseRequirementsActionsOther(context)
	newObj:ParseRequirementsActionsOther(data)
	newObj.__index = newObj
	return newObj
end

function ResolutionContext:ParseRequirementsActionsOther(table)
	self.requirements = self.requirements or {}
	self.actionsOnSuccess = self.requirements or {}
	for key, value in pairs(table) do
		if requirementsWhitelist[key] then
			self.requirements[key] = value
		elseif actionsWhitelist[key] then
			self.actionsOnSuccess[key] = value
		else
			self[key] = value
		end
	end
end

function ResolutionContext:New()
	local newObj = {}
	newObj.__index = ResolutionContext
	setmetatable(newObj, ResolutionContext)
	return newObj
end

function ResolutionContext.FromEncounter(encounterData, player)
	local newObj = {}
	setmetatable(newObj, ResolutionContext)
	newObj:ParseRequirementsActionsOther(encounterData)
	newObj.questlineAid = encounterData.questlineAid
	newObj.player = player
	newObj.__index = ResolutionContext
	return newObj
end

function ResolutionContext.FromCustomItemState(item, player)
	local newObj = {}
	setmetatable(newObj, ResolutionContext)
	newObj.questlineAid = item.questlineAid
	newObj.player = player
	newObj.__index = ResolutionContext
	newObj:ParseRequirementsActionsOther(item)
	return newObj
end

function DialogContext:SendIncomprehensibleError()
	local player = self.player
	local npc = self.npc
	local npcHandler = self.npcHandler
	local npcDialogData = self.npcDialogData
	local errorMessageIdentifier = npcDialogData["INCOMPREHENSIBLE"] or "INCOMPREHENSIBLE"
	local errorMessage = player:Localizer(LOCALIZER_UNIVERSAL):Context(self):Get(errorMessageIdentifier)
	npcHandler:say(errorMessage, npc, player)
	return true
end

local function hasRequiredQuestlineState(state, requiredState)
	if type(requiredState) == "table" then
		local min = requiredState.min or -1
		local max = requiredState.max or defaultMaxState
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
	do
		return true
	end
	if pattern:gmatch("<[^%s]->")() then
		return true
	end
	if pattern:gmatch("%[[^%s]-%]")() then
		return true
	end
	return false
end

PATTERN_MESSAGE_TYPE = {
	REQUIRED = "REQUIRED",
	OPTIONAL = "OPTIONAL",
	KEYWORD = "KEYWORD",
}

function DialogContext:ExtractPatternFields()
	local expectedFields = {}
	local requiredFieldsCount = 0
	for k in self.pattern:gmatch("[^%s]+") do
		local wordData = {}
		if k:gmatch("<.*>")() then
			wordData.word = k:gmatch("[^<>]+")()
			wordData.messageType = PATTERN_MESSAGE_TYPE.REQUIRED
			requiredFieldsCount = requiredFieldsCount + 1
		elseif k:gmatch("%[.*%]")() then
			wordData.word = k:gmatch("[^%[%]]+")()
			wordData.messageType = PATTERN_MESSAGE_TYPE.OPTIONAL
		else
			wordData.word = k
			wordData.messageType = PATTERN_MESSAGE_TYPE.KEYWORD
			requiredFieldsCount = requiredFieldsCount + 1
		end

		table.insert(expectedFields, wordData)
	end
	return expectedFields, requiredFieldsCount
end

function DialogContext:IfPlayerMessageConformsToPattern(expectedFields, requiredFieldsCount)
	local i = 1
	local requiredWordsMatched = 0
	self.extractedParams = {}
	print("#expected, requiredCount", #expectedFields, requiredFieldsCount)
	for playerWord in self.msg:gmatch("[^%s]+") do
		local expectedField = expectedFields[i]
		if not expectedField then
			print("requiredmatched, count",requiredWordsMatched, requiredFieldsCount)
			return requiredWordsMatched >= requiredFieldsCount
		end
		print("expected:", expectedField.word, "player said:", playerWord)
		if expectedField.messageType == PATTERN_MESSAGE_TYPE.KEYWORD then
			if expectedField.word ~= playerWord then
				return false
			end
			requiredWordsMatched = requiredWordsMatched + 1
		end
		if expectedField.messageType == PATTERN_MESSAGE_TYPE.REQUIRED then
			self.extractedParams[expectedField.word] = playerWord
			requiredWordsMatched = requiredWordsMatched + 1
		end
		if expectedField.messageType == PATTERN_MESSAGE_TYPE.OPTIONAL then
			self.extractedParams[expectedField.word] = playerWord
		end
		i = i + 1
	end
	return requiredWordsMatched >= requiredFieldsCount
end

function DialogContext:MatchPattern()
	local patternFieldNames, requiredFieldsCount = self:ExtractPatternFields()
	if #patternFieldNames > requiredFieldsCount then
		return false
	end
	return self:IfPlayerMessageConformsToPattern(patternFieldNames, requiredFieldsCount)
end

function DialogContext:PlayerSaidRequiredWord()
	local msg = self.msg
	local pattern = self.keyword
	if type(pattern) ~= "table" then
		pattern = { pattern }
	end
	if not isPattern(pattern) then
		print("is not pattern", pattern, msg)
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
	local universalKeywordToDialog = self.npcDialogData[LOCALIZER_UNIVERSAL]
	if not universalKeywordToDialog then
		return
	end
	self.questlineAid = nil
	self.keywordToDialog = universalKeywordToDialog
	self:ResolveQuestState()
	if self:IsResolved() then
		return
	end
end

function DialogContext:ResolveQuests()
	for questlineAid, stateToKeywords in pairs(self.npcDialogData) do
		if questlineAid == LOCALIZER_UNIVERSAL then
			goto continue
		end
		if type(stateToKeywords) ~= "table" then
			return
		end
		self.questlineAid = questlineAid
		self.stateToKeywords = stateToKeywords
		self:ResolveQuest()
		if self:IsResolved() then
			return
		end
		::continue::
	end
	self:ResolveUniversalQuest()
end

function DialogContext:ResolveQuestsAnyMsg()
	self.msg = ANY_MESSAGE
	self:ResolveQuests()
end

function DialogContext:SetDefaultGreetFarewellWalkaway()
	if not self.specialMessageType then
		return
	end
	local translatedMessage = self.player:Localizer(LOCALIZER_UNIVERSAL):Context(self):Get(self.msg)
	self.npcHandler:setMessage(self.specialMessageType, translatedMessage)
	self.resolvedStatus = SUCCESS_RESOLVE
end

local dialogResolvers = {
	DialogContext.ResolveQuests,
	DialogContext.SetDefaultGreetFarewellWalkaway,
	DialogContext.ResolveQuestsAnyMsg,
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

function DialogContext:ResolveQuest()
	local state = self.player:getStorageValue(self.questlineAid)
	self.state = state
	for requiredState, keywordToDialog in pairs(self.stateToKeywords) do
		local canProceed = hasRequiredQuestlineState(state, requiredState)
		if not canProceed then
			goto continue
		end
		self.keywordToDialog = keywordToDialog
		self:ResolveQuestState()
		if self:IsResolved() then
			return
		end
		::continue::
	end
end

function DialogContext:ResolveQuestState()
	if not self.keywordToDialog then
		return
	end

	for keyword, data in pairs(self.keywordToDialog) do
		self.keyword = keyword
		if not self:PlayerSaidRequiredWord() then
			goto continue
		end
		local resolutionContext = ResolutionContext.FromDialogContext(self, data)

		self.resolvedStatus = resolutionContext:Resolve()
		if self:IsResolved() then
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

-- Dialog requirements
function ResolutionContext:CheckTopic()
	local requirements = self.requirements
	if not requirements.requiredTopic then
		return CONDITION_STATUS.CONDITION_PASSED
	end

	local topic = self.npcHandler.topic[self.cid]
	local min, max = ParseTopicMinMax(requirements)
	if topic < min or topic > max then
		return CONDITION_STATUS.CONDITION_NOT_PASSED
	end
	return CONDITION_STATUS.CONDITION_PASSED
end

function ResolutionContext:CheckRequiredItems()
	local requirements = self.requirements
	if not requirements.requiredItems then
		return CONDITION_STATUS.CONDITION_PASSED
	end

	if not self.player:HasItems(requirements.requiredItems) then
		self.errorMessage = requirements.textNoRequiredItems
		return CONDITION_STATUS.CONDITION_NOT_PASSED
	end
	return CONDITION_STATUS.CONDITION_PASSED
end

function ResolutionContext:CheckRequiredState()
	local requirements = self.requirements
	if not requirements.requiredState then
		return CONDITION_STATUS.CONDITION_PASSED
	end

	local errorMessage = self.player:ErrorMessageIfHasIncorrectStorageValues(requirements.requiredState)
	if errorMessage then
		self.errorMessage = errorMessage or requirements.textNoRequiredState
		return CONDITION_STATUS.CONDITION_NOT_PASSED
	end
	return CONDITION_STATUS.CONDITION_PASSED
end

function ResolutionContext:CheckGlobalState()
	local requirements = self.requirements
	if not requirements.requiredGlobalState then
		return CONDITION_STATUS.CONDITION_PASSED
	end

	for key, value in pairs(requirements.requiredGlobalState) do
		if Game.getStorageValue(key) ~= value then
			self.errorMessage = requirements.textNoRequiredGlobalState
			return CONDITION_STATUS.CONDITION_NOT_PASSED
		end
	end
	return CONDITION_STATUS.CONDITION_PASSED
end

function ResolutionContext:CheckCanAddRewards()
	local actions = self.actionsOnSuccess
	if not actions.rewards then
		return CONDITION_STATUS.CONDITION_PASSED
	end

	local result, errorMessage = self.player:CanAddItems(actions.rewards, self.questlineAid)
	if result ~= true then
		self.player:sendTextMessage(MESSAGE_FAILURE, errorMessage) -- DO NOT TRANSLATE
		self.errorMessage = NOT_ENOUGH_CAP_OR_SLOTS
		return CONDITION_STATUS.CONDITION_NOT_PASSED
	end
	return CONDITION_STATUS.CONDITION_PASSED
end

function ResolutionContext:CheckRequiredMoney()
	local requirements = self.requirements
	if not requirements.requiredMoney then
		return CONDITION_STATUS.CONDITION_PASSED
	end

	local balance = Bank.balance(self.player)
	local playerMoney = self.player:getMoney()
	local totalPlayerMoney = balance + playerMoney
	if totalPlayerMoney < requirements.requiredMoney then
		self.errorMessage = requirements.textNoRequiredMoney
		return CONDITION_STATUS.CONDITION_NOT_PASSED
	end
	return CONDITION_STATUS.CONDITION_PASSED
end

function ResolutionContext:CheckSpecialConditions()
	local requirements = self.requirements
	if not requirements.specialConditions then
		return CONDITION_STATUS.CONDITION_PASSED
	end

	for _, context in pairs(requirements.specialConditions) do
		local conditionContext = MergedTable(context, self)
		local condition = conditionContext.condition
		local outcome, errorMessage = condition(conditionContext)
		if outcome ~= conditionContext.requiredOutcome then
			self.errorMessage = errorMessage or conditionContext.textNoRequiredCondition
			self.npcHandler.topic[self.cid] = conditionContext.nextTopic or TOPIC_DEFAULT
			return CONDITION_STATUS.CONDITION_NOT_PASSED
		end
	end
	return CONDITION_STATUS.CONDITION_PASSED
end

-- Dialog actions (on success)
function ResolutionContext:TriggerSpecialActions()
	local actions = self.actionsOnSuccess
	if not actions.specialActionsOnSuccess then
		return
	end

	for _, context in pairs(actions.specialActionsOnSuccess) do
		local action = context.action
		local actionContext = MergedTable(action, self)
		action(actionContext)
	end
end

function ResolutionContext:RemoveRequiredItems()
	local requirements = self.requirements
	local actions = self.actionsOnSuccess

	if not requirements.requiredItems then
		return
	end

	if actions.removeRequiredItems ~= false then
		self.player:RemoveItems(actions.requiredItems)
	end
end

function ResolutionContext:AddRewards()
	local actions = self.actionsOnSuccess
	if not actions.rewards then
		return
	end

	self.player:AddItems(actions.rewards)
end

function ResolutionContext:RemoveRequiredMoney()
	local requirements = self.requirements
	if not requirements.requiredMoney then
		return
	end

	self.player:removeMoneyBank(requirements.requiredMoney)
end

function ResolutionContext:SpawnMonsters()
	local actions = self.actionsOnSuccess
	if not actions.spawnMonstersOnSuccess then
		return
	end

	for monsterName, count in pairs(actions.spawnMonstersOnSuccess) do
		for _ = 1, count do
			Game.createMonster(monsterName, self.player:getPosition())
		end
	end
end

function ResolutionContext:AddOutfits()
	local actions = self.actionsOnSuccess
	if not actions.outfitRewards then
		return
	end

	self.player:AddOutfitsAndAddons(actions.outfitRewards)
end

function ResolutionContext:AddMounts()
	local actions = self.actionsOnSuccess
	if not actions.mountRewards then
		return
	end

	self.player:AddMounts(actions.mountRewards)
end

function ResolutionContext:AddExperience()
	local actions = self.actionsOnSuccess
	if not actions.expReward then
		return
	end

	AddExperienceWithAnnouncement(self.player, actions.expReward)
end

function ResolutionContext:UpdatePlayerState()
	local actions = self.actionsOnSuccess
	if not actions.nextState then
		return
	end

	self.player:UpdateStorages(actions.nextState)
end

function ResolutionContext:UpdateGlobalState()
	local actions = self.actionsOnSuccess
	if not actions.nextGlobalState then
		return
	end

	UpdateGlobalStorages(actions.nextGlobalState)
end

function ResolutionContext:SetNextTopic()
	local actions = self.actionsOnSuccess
	if actions.preserveTopic == true then
		return
	end

	self.npcHandler.topic[self.cid] = actions.nextTopic or 0
	addEvent(function()
		self.npcHandler.topic[self.cid] = actions.nextTopic or 0
	end, 5)
end

function ResolutionContext:AddDialogData()
	local actions = self.actionsOnSuccess
	if actions.addDialogData ~= false then
		PlayerDialogDataRegistry():Get(self.player):Add(self)
	end
end

function ResolutionContext:TrySendTranslateSuccessMessage()
	if not self.actionsOnSuccess.text then
		return
	end

	local translatedMessage = self.player:Localizer(self.questlineAid):Context(self):Get(self.actionsOnSuccess.text)
	if not translatedMessage then
		return
	end

	if self.specialMessageType then
		self.npcHandler:setMessage(self.specialMessageType, translatedMessage)
	else
		self.npcHandler:say(translatedMessage, self.npc, self.player)
	end
end

function ResolutionContext:TrySendTranslateFailMessage()
	if not self.actionsOnSuccess.text then
		return
	end

	local translatedMessage = self.player:Localizer(self.questlineAid):Context(self):Get(self.errorMessage)
	if not translatedMessage then
		return
	end

	if self.specialMessageType then
		self.npcHandler:setMessage(self.specialMessageType, translatedMessage)
	else
		self.npcHandler:say(translatedMessage, self.npc, self.player)
	end
end

function ResolutionContext:AppendExtractedParams()
	print("apeending extracted")
	for key, value in pairs(self.extractedParams or {}) do
		print(key, value)
		self[key] = value
	end
end

local resolutionConditions = {
	ResolutionContext.CheckTopic,
	ResolutionContext.CheckRequiredItems,
	ResolutionContext.CheckRequiredState,
	ResolutionContext.CheckGlobalState,
	ResolutionContext.CheckCanAddRewards,
	ResolutionContext.CheckRequiredMoney,
	ResolutionContext.CheckSpecialConditions,
}

local actionsOnSuccessfulResolution = {
	ResolutionContext.TriggerSpecialActions,
	ResolutionContext.RemoveRequiredItems,
	ResolutionContext.AddRewards,
	ResolutionContext.RemoveRequiredMoney,
	ResolutionContext.SpawnMonsters,
	ResolutionContext.AddOutfits,
	ResolutionContext.AddMounts,
	ResolutionContext.AddExperience,
	ResolutionContext.UpdatePlayerState,
	ResolutionContext.UpdateGlobalState,
	ResolutionContext.SetNextTopic,
	ResolutionContext.AddDialogData,
	ResolutionContext.TrySendTranslateSuccessMessage,
}

function ResolutionContext:ConditionsArePassable()
	for _, condition in pairs(resolutionConditions) do
		local status = condition(self)
		if status == CONDITION_STATUS.CONDITION_NOT_PASSED then
			return CONDITION_STATUS.AT_LEAST_ONE_CONDITION_NOT_PASSED
		end
	end
	return CONDITION_STATUS.ALL_CONDITIONS_PASSED
end

function ResolutionContext:ActionsOnSuccess()
	for _, action in pairs(actionsOnSuccessfulResolution) do
		action(self)
	end
end

function ResolutionContext:Resolve()
	self:AppendExtractedParams()
	local status = self:ConditionsArePassable()
	if status == CONDITION_STATUS.AT_LEAST_ONE_CONDITION_NOT_PASSED then
		if self.errorMessage then
			self:TrySendTranslateFailMessage()
			return FAIL_RESOLVE
		end
		return DISCARD_DIALOG
	end

	if status == CONDITION_STATUS.ALL_CONDITIONS_PASSED then
		self.lastDialogData = PlayerDialogDataRegistry():Get(self.player):Latest()
		self:ActionsOnSuccess()
		return SUCCESS_RESOLVE
	end
end

function InitializeResponses(player, config, npcHandler, npc, msg)
	player = Player(player)

	PlayerDialogDataRegistry():Register(player)
	local cid = player:getId()

	--ToDo: does it work? or should it be done with addEvent?
	npcHandler.topic[cid] = TOPIC_DEFAULT

	for _, specialMessageType in pairs(specialMessageTypes) do
		local dialogContext = DialogContext(player, msg, config, npcHandler, npc, specialMessageType)
		if not dialogContext:TryResolveDialog():IsResolved() then
			local message = player:Localizer(LOCALIZER_UNIVERSAL):Get(config[specialMessageType]) or player:Localizer(LOCALIZER_UNIVERSAL):Get(specialMessageType)
			npcHandler:setMessage(specialMessageType, message)
		end
	end
end

PlayerDialogData = {}
PlayerDialogDataRegistry = {}
PlayerDialogDataRegistry.__index = PlayerDialogDataRegistry
PlayerCustomDialogDataRegistry = {}
PlayerCustomDialogDataRegistry.__index = PlayerCustomDialogDataRegistry
local playerDialogDataRegistrySingleton = nil
local playerCustomnDialogDataRegistrySingleton = nil
setmetatable(PlayerDialogData, {
	__call = function(class, ...)
		return class:New(...)
	end,
})
function PlayerDialogData:New()
	local newObj = {}
	setmetatable(newObj, PlayerDialogData)
	newObj.data = {}
	self.__index = self
	return newObj
end
setmetatable(PlayerDialogDataRegistry, {
	__call = function(class, ...)
		return class:New(...)
	end,
})
function PlayerDialogDataRegistry:New()
	if playerDialogDataRegistrySingleton then
		return playerDialogDataRegistrySingleton
	end
	playerDialogDataRegistrySingleton = {}
	setmetatable(playerDialogDataRegistrySingleton, PlayerDialogDataRegistry)
	self.__index = self
	playerDialogDataRegistrySingleton.registry = {}
	return playerDialogDataRegistrySingleton
end
setmetatable(PlayerCustomDialogDataRegistry, {
	__call = function(class, ...)
		return class:New(...)
	end,
})
function PlayerCustomDialogDataRegistry:New()
	if playerCustomnDialogDataRegistrySingleton then
		return playerCustomnDialogDataRegistrySingleton
	end
	playerCustomnDialogDataRegistrySingleton = {}
	setmetatable(playerCustomnDialogDataRegistrySingleton, PlayerCustomDialogDataRegistry)
	self.__index = self
	playerCustomnDialogDataRegistrySingleton.registry = {}
	return playerCustomnDialogDataRegistrySingleton
end

function PlayerDialogData:Add(data)
	table.insert(self.data, data)
	return self
end
function PlayerDialogData:Latest()
	return self.data[#self.data] or {}
end
function PlayerDialogData:ByIndex(index)
	return self.data[index] or {}
end

function PlayerDialogDataRegistry:Register(player)
	self.registry[player:getId()] = PlayerDialogData()
	return self.registry[player:getId()]
end
function PlayerDialogDataRegistry:Get(player)
	return self.registry[player:getId()]
end

function PlayerCustomDialogDataRegistry:Register(player)
	self.registry[player:getId()] = PlayerDialogData()
	return self.registry[player:getId()]
end

function PlayerCustomDialogDataRegistry:Get(player)
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
