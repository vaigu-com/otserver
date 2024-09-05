-- quest system
PROMOTION_PRICE = 15000
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
GREET = "LOCALIZER_GREET"
FAREWELL = "LOCALIZER_FAREWELL"
WALKAWAY = "LOCALIZER_WALKAWAY"

QUEST_NOT_STARTED = -1

CAN_RESOLVE = "CAN_RESOLVE"
SUCCESS_RESOLVE = "SUCCESS_RESOLVE"
DISCARD_DIALOGUE = "DISCARD_DIALOGUE"
CONVERSATION_RESOLVED = "CONVERSATION_RESOLVED"
CONVERSATION_UNRESOLVED = "CONVERSATION_UNRESOLVED"

local defaultMaxState = 99999

local specialMessageTypes = { MESSAGE_GREET, MESSAGE_FAREWELL, MESSAGE_WALKAWAY }
local specialMessageTypeToMessage = {
	[MESSAGE_GREET] = "LOCALIZER_GREET",
	[MESSAGE_FAREWELL] = "LOCALIZER_FAREWELL",
	[MESSAGE_WALKAWAY] = "LOCALIZER_WALKAWAY",
}
GENERAL_SPECIAL_ACTIONS = {
	clearConditions = function(context)
		local player = context.player
		local conditions = context.conditions or ALL_CONDITIONS
		for _, condition in pairs(conditions) do
			player:removeCondition(condition)
		end
	end,
	endDialogue = function(context)
		local player = context.player
		local npcHandler = context.npcHandler
		local npc = context.npc
		if not (player and npcHandler) then
			return
		end
		addEvent(function()
			npcHandler:removeInteraction(npc, player)
		end, 10)
	end,
	doDamageNotLethal = function(context)
		local target = context.target or context.monster or context.player
		local minDmg = context.minDMG or context.dmg or context.damage
		local maxDmg = context.maxDMG or context.dmg or context.damage
		if maxDmg >= target:getHealth() then
			return
		end
		local damageType = context.damageType or COMBAT_ENERGYDAMAGE
		local magicEffect = context.magicEffect or context.me or CONST_ME_NONE
		doTargetCombatHealth(0, target, damageType, -minDmg, -maxDmg, magicEffect)
	end,
	npcSay = function(context)
		local talkType = context.talkType or context.npc
		local player = context.player
		local aid = context.questlineAid
		local text = context.text
		local npc = context.npc
		local npcHandler = context.npcHandler

		local translatedMessage = player:Localizer(aid):Get(text)

		addEvent(function()
			npcHandler:say(translatedMessage, npc, player, nil, talkType)
		end, 50)
	end,
	teleportToTemple = function(context)
		local player = context.player
		player:teleportTo(player:getTown():getTemplePosition(), true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end,
	createMonstersAtPlayer = function(context)
		local player = context.player
		local monsters = context.monsters
		for _, monsterconfig in pairs(monsters) do
			SpawnMonstersAtPlayer(monsterconfig.name, player, monsterconfig.count or 1)
		end
	end,
	teleportPlayer = function(context)
		local player = context.player
		local toPos = context.pos or context.toPos or context.topos or context.destination
		player:teleportTo(toPos)
	end,
	grantBless = function(context)
		local player = context.player
		player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		local min, max = context.min, context.max
		for i = min, max do
			player:addBlessing(i, 1)
		end
	end,
	removeMoneyBank = function(context)
		local player = context.player
		local price = context.price
		player:removeMoneyBank(price)
	end,
	despawnEscortee = function(context)
		local escorteeName = context.escorteeName
		local despawnAfterSeconds = context.despawnAfterSeconds

		addEvent(function()
			local creature = Creature(EscortRegistry():GetState(escorteeName).escortee)
			if not creature then
				return
			end
			creature:remove()
		end, despawnAfterSeconds * 1000)
	end,
}

SPECIAL_CONDITIONS_GENERAL = {
	playerHasLevel = function(context)
		local player = context.player
		local playerLevel = player:getLevel()
		local minLevel = context.minLevel or 0
		local maxLevel = context.maxLevel or 9999
		return playerLevel >= minLevel and playerLevel <= maxLevel
	end,
	canBuyBless = function(context)
		local player = context.player
		local price = getBlessingsCost(player:getlevel()) * 5
		context.price = price
		if SPECIAL_CONDITIONS_GENERAL.hasMoney(context) then
			return true
		end
		return false
	end,
	hasMoney = function(context)
		local player = context.player
		local itemPrice = context.price
		local balance = Bank.balance(player)
		local playerMoney = player:getMoney()
		return (balance + playerMoney) > itemPrice, "You dont have enough money."
	end,
	playerIsPzLocked = function(context)
		local player = context.player
		return player:isPzLocked()
	end,
	SAID_NUMBER = function(context)
		local msg = context.msg
		return tonumber(msg:lower()) ~= nil
	end,
	saidPositiveInteger = function(context)
		local msg = context.msg
		local number = tonumber(msg:lower())
		if not number then
			return false
		end
		if number % 1 ~= 0 then
			return false
		end
		return number > 0
	end,
}

local FIRST_AVAILABLE_STORAGE = 8100
NEXT_STORAGE = NEXT_STORAGE or FIRST_AVAILABLE_STORAGE
function NextStorage()
	NEXT_STORAGE = NEXT_STORAGE + 1
	return NEXT_STORAGE
end

function GrantPlayerExpByAid(player, actionId)
	local expValue = CustomItemRegistry():getState(actionId).expReward
	if not expValue then
		return
	end
	AddExperienceWithAnnouncement(player, expValue)
end

function TryExecuteSpecialActionsOnFail(actionId, player, rewardChest)
	local actions = CustomItemRegistry():getState(actionId).specialActionsOnFail
	if not actions then
		return
	end

	for action, context in pairs(actions) do
		context.player = player
		context.item = rewardChest
		action(context)
	end
end

function TryExecuteSpecialActionsSuccess(actionId, player, rewardChest)
	local actions = CustomItemRegistry():getState(actionId).specialActionsOnSuccess
	if not actions then
		return
	end

	for action, context in pairs(actions) do
		context.player = player
		context.item = rewardChest
		action(context)
	end
end

function SendChestIsEmpty(player, itemId)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The " .. ItemType(itemId):getName() .. " is empty.")
end

local function playerCanOpenChest(player, actionId)
	local requiredState = CustomItemRegistry():getState(actionId).requiredState
	if requiredState and (not player:HasCorrectStorageValues(requiredState)) then
		return false
	end
	if player:getStorageValue(actionId) ~= -1 then
		return false
	end
	return true
end

local function playerIsUsingRewardChest(itemId, actionId)
	local requiredId = CustomItemRegistry():getState(actionId).id
	if requiredId then
		return itemId == requiredId
	end
	return true
end

function ChestQuestTryAddItems(player, rewardChest)
	local actionId = rewardChest:getActionId()
	if not actionId then
		return false
	end

	local itemId = rewardChest:getId()
	if not playerIsUsingRewardChest(itemId, actionId) then
		return false
	end

	local rewards = CustomItemRegistry():getState(actionId).rewards
	if not playerCanOpenChest(player, actionId) then
		if rewardChest:isContainer() then
			SendChestIsEmpty(player, itemId)
		end
		TryExecuteSpecialActionsOnFail(actionId, player, rewardChest)
		return false
	end

	if rewards then
		if not player:TryAddItems(rewards) then
			return
		end
	end

	TryExecuteSpecialActionsSuccess(actionId, player, rewardChest)
	GrantPlayerExpByAid(player, actionId)
	player:setStorageValue(actionId, 1)
	local updateStorages = CustomItemRegistry():getState(actionId).nextState
	if updateStorages then
		player:UpdateStorages(updateStorages)
	end

	return true
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

	if type(requiredState) == "number" then
		min = requiredState
		max = defaultMaxState
		neq = nil
	elseif type(requiredState) == "table" then
		min = requiredState.min or QUEST_NOT_STARTED
		max = requiredState.max or defaultMaxState
		neq = requiredState.neq
	end

	return min, max, neq
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
	for _, var in pairs(outfitsAndAddons) do
		local addon = var.addon
		local outfit = var.outfitId

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

---@class ConversationContext
---@field player Player player object
---@field cid number player id
---@field msg string player message
---@field npcConversationData table conversation and dialogues
---@field npcHandler table
---@field npc userdata npc object
---@field specialMessageType string
---@field questlineAid number
---@field dialogues table
---@field dialogue table
---@alias Player table
ConversationContext = {}
ConversationContext.__index = ConversationContext

setmetatable(ConversationContext, {
	__call = function(class, player, msg, npcConversationData, npcHandler, npc, specialMessageType)
		local instance = setmetatable({}, class)
		instance.player = player
		instance.cid = player:getId()
		instance.msg = msg
		if specialMessageType then
			instance.msg = specialMessageTypeToMessage[specialMessageType]
		end
		instance.npcConversationData = npcConversationData
		instance.npcHandler = npcHandler
		instance.npc = npc
		instance.specialMessageType = specialMessageType
		instance.dialogue = nil
		instance.resolvedStatus = CONVERSATION_UNRESOLVED
		return instance
	end,
})

function ConversationContext:ParseTranslatedText(dialogue)
	local text = Evaluate(dialogue.text, self)
	if not text then
		return nil
	end
	local translatedMessage = self.player:Localizer(self.questlineAid):Context(self):Get(text)
	return translatedMessage
end

function ConversationContext:SendIncomprehensibleError()
	local player = self.player
	local npc = self.npc
	local npcHandler = self.npcHandler
	local npcConversationData = self.npcConversationData
	local errorMessageIdentifier = npcConversationData["INCOMPREHENSIBLE"] or "INCOMPREHENSIBLE"
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

function ConversationContext:PlayerSaidRequiredWord()
	local msg = self.msg
	local keyword = self.keyword
	if type(keyword) ~= "table" then
		return keyword == msg
	end
	return table.contains(keyword, self.msg)
end

-- refer to quest_system_doc.lua for guidelines
function TryResolveConversation(player, msg, npcConversationData, npcHandler, npc, messageType)
	player = Player(player)
	local conversationContext = ConversationContext(player, msg, npcConversationData, npcHandler, npc, messageType)
	return conversationContext:TryResolveConversation():IsResolved()
end

function ConversationContext:ResolveUniversalQuest()
	local universalKeywordToDialogue = self.npcConversationData[LOCALIZER_UNIVERSAL]
	if not universalKeywordToDialogue then
		return
	end
	self.questlineAid = nil
	self.keywordToDialogue = universalKeywordToDialogue
	self:ResolveQuestState()
	if self:IsResolved() then
		return
	end
end

function ConversationContext:ResolveQuests()
	for questlineAid, stateToKeywords in pairs(self.npcConversationData) do
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

function ConversationContext:ResolveQuestsAnyMsg()
	self.msg = ANY_MESSAGE
	self:ResolveQuests()
end

function ConversationContext:SetDefaultGreetFarewellWalkaway()
	if not self.specialMessageType then
		return
	end
	local translatedMessage = self.player:Localizer(LOCALIZER_UNIVERSAL):Context(self):Get(self.msg)
	self.npcHandler:setMessage(self.specialMessageType, translatedMessage)
	self.resolvedStatus = CONVERSATION_RESOLVED
end

local conversationResolvers = {
	ConversationContext.ResolveQuests,
	ConversationContext.SetDefaultGreetFarewellWalkaway,
	ConversationContext.ResolveQuestsAnyMsg,
}

function ConversationContext:TryResolveConversation()
	if not self.msg then
		return self
	end

	for _, resolver in pairs(conversationResolvers) do
		resolver(self)
		if self:IsResolved() then
			return self
		end
	end
	self:SendIncomprehensibleError()
	return self
end

function ConversationContext:ResolveQuest()
	local state = self.player:getStorageValue(self.questlineAid)
	self.state = state
	for requiredState, keywordToDialogue in pairs(self.stateToKeywords) do
		local canProceed = hasRequiredQuestlineState(state, requiredState)
		if not canProceed then
			goto continue
		end
		self.keywordToDialogue = keywordToDialogue
		self:ResolveQuestState()
		if self:IsResolved() then
			return
		end
		::continue::
	end
end

function ConversationContext:ResolveQuestState()
	if not self.keywordToDialogue then
		return
	end

	for keyword, dialogue in pairs(self.keywordToDialogue) do
		self.keyword = keyword
		if not self:PlayerSaidRequiredWord() then
			goto continue
		end
		self.dialogue = dialogue
		self:ResolveQuestStateDialogue()
		if self:IsResolved() then
			return
		end
		::continue::
	end
end

function ConversationContext:IsResolved()
	return self.resolvedStatus == CONVERSATION_RESOLVED
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

-- Dialogue requirements
function ConversationContext:CheckTopic()
	local dialogue = self.dialogue
	if not dialogue.requiredTopic then
		return CAN_RESOLVE
	end

	local topic = self.npcHandler.topic[self.cid]

	local min, max = ParseTopicMinMax(dialogue)
	if topic < min or topic > max then
		return DISCARD_DIALOGUE
	end
	return CAN_RESOLVE
end

function ConversationContext:CheckRequiredItems()
	local dialogue = self.dialogue
	if not dialogue.requiredItems then
		return CAN_RESOLVE
	end
	if not self.player:HasItems(dialogue.requiredItems) then
		if dialogue.textNoRequiredItems then
			return dialogue.textNoRequiredItems
		end
		return DISCARD_DIALOGUE
	end
	return CAN_RESOLVE
end

function ConversationContext:CheckRequiredState()
	local dialogue = self.dialogue
	if not dialogue.requiredState then
		return CAN_RESOLVE
	end
	if not self.player:HasCorrectStorageValues(dialogue.requiredState) then
		if dialogue.textNoRequiredState then
			return dialogue.textNoRequiredState
		end
		return DISCARD_DIALOGUE
	end
	return CAN_RESOLVE
end

function ConversationContext:CheckGlobalState()
	local dialogue = self.dialogue
	if not dialogue.requiredGlobalState then
		return CAN_RESOLVE
	end
	for key, value in pairs(dialogue.requiredGlobalState) do
		if Game.getStorageValue(key) == value then
			goto continue
		end
		local errorMessage = dialogue.textNoRequiredGlobalState or DISCARD_DIALOGUE
		if errorMessage then
			return DISCARD_DIALOGUE
		end
		::continue::
	end
	return CAN_RESOLVE
end

function ConversationContext:CheckCanAddRewards()
	local dialogue = self.dialogue
	if not dialogue.rewards then
		return CAN_RESOLVE
	end
	local result, errorMessage = self.player:CanAddItems(dialogue.rewards, self.questlineAid)
	if result ~= true then
		self.player:sendTextMessage(MESSAGE_FAILURE, errorMessage) -- DO NOT TRANSLATE
		return NOT_ENOUGH_CAP_OR_SLOTS
	end
	return CAN_RESOLVE
end

function ConversationContext:CheckSpecialConditions()
	local dialogue = self.dialogue
	if not dialogue.specialConditions then
		return CAN_RESOLVE
	end
	for condition, conditionContext in pairs(dialogue.specialConditions) do
		local specialConditionContext = MergedTable(conditionContext, self) --38f
		local outcome, errorMessage = condition(specialConditionContext)
		if outcome == specialConditionContext.requiredOutcome then
			goto continue
		end

		local textToTranslate = errorMessage or specialConditionContext.textOnFailedCondition
		if textToTranslate then
			return textToTranslate
		end

		do
			return DISCARD_DIALOGUE
		end

		::continue::
	end
	return CAN_RESOLVE
end

function ConversationContext:CheckRequiredMoney()
	local dialogue = self.dialogue
	if not dialogue.requiredMoney then
		return CAN_RESOLVE
	end
	local balance = Bank.balance(self.player)
	local playerMoney = self.player:getMoney()
	local totalPlayerMoney = balance + playerMoney
	if totalPlayerMoney < dialogue.requiredMoney then
		if dialogue.textNoRequiredMoney then
			return dialogue.textNoRequiredMoney
		end
		return DISCARD_DIALOGUE
	end
	return CAN_RESOLVE
end

-- Dialogue actions (on success)
function ConversationContext:TriggerSpecialActions()
	local dialogue = self.dialogue
	if not dialogue.specialActionsOnSuccess then
		return
	end
	for action, specialActionContext in pairs(dialogue.specialActionsOnSuccess) do
		specialActionContext = table.merged(specialActionContext, self)
		action(specialActionContext)
	end
end

function ConversationContext:RemoveRequiredItems()
	local dialogue = self.dialogue

	if not dialogue.requiredItems then
		return
	end
	if dialogue.removeRequiredItems ~= false then
		self.player:RemoveItems(dialogue.requiredItems)
	end
end

function ConversationContext:AddRewards()
	local dialogue = self.dialogue
	if not dialogue.rewards then
		return
	end
	self.player:AddItems(dialogue.rewards)
end

function ConversationContext:RemoveRequiredMoney()
	local dialogue = self.dialogue
	if not dialogue.requiredMoney then
		return
	end
	self.player:removeMoneyBank(dialogue.requiredMoney)
end

function ConversationContext:SpawnMonsters()
	local dialogue = self.dialogue
	if not dialogue.spawnMonstersOnSuccess then
		return
	end
	for monsterName, count in pairs(dialogue.spawnMonstersOnSuccess) do
		for _ = 1, count do
			Game.createMonster(monsterName, self.player:getPosition())
		end
	end
end

function ConversationContext:AddOutfits()
	local dialogue = self.dialogue
	if not dialogue.outfitRewards then
		return
	end
	self.player:AddOutfitsAndAddons(dialogue.outfitRewards)
end

function ConversationContext:AddMounts()
	local dialogue = self.dialogue
	if not dialogue.mountRewards then
		return
	end
	self.player:AddMounts(dialogue.mountRewards)
end

function ConversationContext:AddExperience()
	local dialogue = self.dialogue
	if not dialogue.expReward then
		return
	end
	AddExperienceWithAnnouncement(self.player, dialogue.expReward)
end

function ConversationContext:UpdatePlayerState()
	local dialogue = self.dialogue
	if not dialogue.nextState then
		return
	end
	self.player:UpdateStorages(dialogue.nextState)
end

function ConversationContext:UpdateGlobalState()
	local dialogue = self.dialogue
	if not dialogue.nextGlobalState then
		return
	end
	UpdateGlobalStorages(dialogue.nextGlobalState)
end

function ConversationContext:SetNextTopic()
	local dialogue = self.dialogue
	if not dialogue.nextTopic then
		return
	end
	self.npcHandler.topic[self.cid] = dialogue.nextTopic
	addEvent(function()
		self.npcHandler.topic[self.cid] = dialogue.nextTopic
	end, 5)
end

local dialogueConditions = {
	ConversationContext.CheckTopic,
	ConversationContext.CheckRequiredItems,
	ConversationContext.CheckRequiredState,
	ConversationContext.CheckGlobalState,
	ConversationContext.CheckCanAddRewards,
	ConversationContext.CheckSpecialConditions,
	ConversationContext.CheckRequiredMoney,
}

function ConversationContext:ErrorMessageIfCannotResolve()
	if not (self.player and self.npcHandler and self.keyword and self.dialogue) then
		return DISCARD_DIALOGUE
	end

	for _, condition in pairs(dialogueConditions) do
		local errorMessage = condition(self)
		if errorMessage == DISCARD_DIALOGUE then
			return DISCARD_DIALOGUE
		end
		if errorMessage ~= CAN_RESOLVE then
			return errorMessage
		end
	end
	return SUCCESS_RESOLVE
end

function ConversationContext:SetLastMessageData()
	local dialogue = self.dialogue
	if dialogue.setLastMessageData ~= false then
		self.player:SetLastMessageData(self)
	end
end

local actionsOnSuccessfulDialogue = {
	ConversationContext.TriggerSpecialActions,
	ConversationContext.RemoveRequiredItems,
	ConversationContext.AddRewards,
	ConversationContext.RemoveRequiredMoney,
	ConversationContext.SpawnMonsters,
	ConversationContext.AddOutfits,
	ConversationContext.AddMounts,
	ConversationContext.AddExperience,
	ConversationContext.UpdatePlayerState,
	ConversationContext.UpdateGlobalState,
	ConversationContext.SetNextTopic,
	ConversationContext.SetLastMessageData,
}

function ConversationContext:ActionsOnSuccess()
	for _, action in pairs(actionsOnSuccessfulDialogue) do
		action(self)
	end
end

function ConversationContext:TrySendTranslatedMessage(message)
	--ToDo: is it even possible?
	if not message then
		return
	end

	local translatedMessage = self.player:Localizer(self.questlineAid):Context(self):Get(message)
	if not translatedMessage then
		return
	end

	if self.specialMessageType then
		self.npcHandler:setMessage(self.specialMessageType, translatedMessage)
	else
		self.npcHandler:say(translatedMessage, self.npc, self.player)
	end
end

function ConversationContext:ResolveQuestStateDialogue()
	local errorMessage = self:ErrorMessageIfCannotResolve()
	if errorMessage == DISCARD_DIALOGUE then
		return
	end

	self.resolvedStatus = CONVERSATION_RESOLVED

	if errorMessage == SUCCESS_RESOLVE then
		self:ActionsOnSuccess()
		self:TrySendTranslatedMessage(Evaluate(self.dialogue.text, self))
		return
	end

	self:TrySendTranslatedMessage(errorMessage)
end

function InitializeResponses(player, config, npcHandler, npc, msg)
	player = Player(player)
	player:SetCustomConversationData(nil)
	local cid = player:getId()

	--ToDo: does it work? or should it be done with addEvent?
	npcHandler.topic[cid] = 0

	for _, specialMessageType in pairs(specialMessageTypes) do
		local conversationContext = ConversationContext(player, msg, config, npcHandler, npc, specialMessageType)
		if not conversationContext:TryResolveConversation():IsResolved() then
			local message = player:Localizer(LOCALIZER_UNIVERSAL):Get(config[specialMessageType]) or player:Localizer(LOCALIZER_UNIVERSAL):Get(specialMessageType)
			npcHandler:setMessage(specialMessageType, message)
		end
	end
end

local playerIdToLastMessageData = {}
local playerIdToCustomConversationData = {}
function Player:SetLastMessageData(data)
	playerIdToLastMessageData[self:getId()] = data
end

function Player:GetLastMessageData()
	return playerIdToLastMessageData[self:getId()]
end

function Player:SetCustomConversationData(data)
	playerIdToCustomConversationData[self:getId()] = data
end

function Player:GetCustomConversationData()
	return playerIdToCustomConversationData[self:getId()]
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
