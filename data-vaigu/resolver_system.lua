NO_TEXT = "NO_TEXT"

NO_REQUIREMENT_FAIL_TEXT = "NO_REQUIREMENT_FAIL_TEXT"

---@class ResolutionContext
---@field requirements table
---@field actionsOnSuccess table
---@field player Player
---@field cid integer?
---@field npc Npc?
---@field specialMessageType string?
---@field localizer integer
---@field npcHandler NpcHandler?
---@field topic integer?
---@field extractedParams table
---@field patternFields table
ResolutionContext = {}
ResolutionContext.__index = ResolutionContext
setmetatable(ResolutionContext, {
	__call = function(class, ...)
		return class:New(...)
	end,
})

local goesToRequirements = {
	requiredTopic = true,
	requiredItems = true,
	requiredState = true,
	requiredGlobalState = true,
	requiredMoney = true,
	specialRequirements = true,
}
local goesToActions = {
	specialActionsOnSuccess = true,
	removeRequiredItems = true,
	rewards = true,
	spawnMonstersOnSuccess = true,
	outfitRewards = true,
	mountRewards = true,
	expReward = true,
	wildcardReward = true,
	nextState = true,
	nextGlobalState = true,
	nextTopic = true,
	preserveTopic = true,
	addDialogData = true,
	text = true,
	interactOnGreet = true,
}

function ResolutionContext:Append(tab)
	self:ParseRequirementsActionsOther(tab)
	return self
end

---@return ResolutionContext
function ResolutionContext.FromDialogContext(context, data)
	local newObj = {}
	setmetatable(newObj, ResolutionContext)
	newObj:ParseRequirementsActionsOther(context)
	newObj:ParseRequirementsActionsOther(data)
	newObj.__index = newObj
	return newObj
end

---@return ResolutionContext
function ResolutionContext.FromAnyTable(context)
	local newObj = {}
	setmetatable(newObj, ResolutionContext)
	newObj:ParseRequirementsActionsOther(context)
	newObj.__index = newObj
	return newObj
end

---@param activeEscort ActiveEscort
---@param player Player
---@return ResolutionContext
function ResolutionContext.FromActiveEscort(activeEscort, player)
	local newObj = {}
	setmetatable(newObj, ResolutionContext)
	newObj:ParseRequirementsActionsOther(activeEscort)
	newObj:ParseRequirementsActionsOther(activeEscort:GetEscortData())
	newObj.localizer = activeEscort:GetLocalizer()
	newObj.player = player
	newObj.__index = ResolutionContext
	return newObj
end

function ResolutionContext:GetGreetContext()
	return self.greetContext
end
function ResolutionContext:GetActions()
	return self.actionsOnSuccess
end

---@private
function ResolutionContext:ParseRequirementsActionsOther(tab)
	self.requirements = self.requirements or {}
	self.actionsOnSuccess = self.actionsOnSuccess or self.requirements or {}
	for key, value in pairs(tab) do
		if goesToRequirements[key] then
			self.requirements[key] = value
		elseif goesToActions[key] then
			self.actionsOnSuccess[key] = value
		else
			self[key] = value
		end
	end

	for key, value in pairs(self.patternFields or {}) do
		self[key] = value
	end

	self.localizer = self.localizer or tab.localizer
end

function ResolutionContext:New()
	local newObj = {}
	newObj.__index = ResolutionContext
	setmetatable(newObj, ResolutionContext)
	return newObj
end

function ResolutionContext.FromActiveEncounter(activeEncounter, player)
	local newObj = {}
	setmetatable(newObj, ResolutionContext)
	newObj:ParseRequirementsActionsOther(activeEncounter)
	newObj.localizer = activeEncounter.localizer
	newObj.player = player
	newObj.__index = ResolutionContext
	return newObj
end

---@param itemData table
---@return ResolutionContext
function ResolutionContext.FromCustomItemState(itemData)
	local newObj = {}
	setmetatable(newObj, ResolutionContext)
	newObj.localizer = itemData.localizer
	newObj.__index = ResolutionContext
	newObj:ParseRequirementsActionsOther(itemData)
	return newObj
end

---@param player Player
function ResolutionContext:SetPlayer(player)
	self.player = player
	return self
end

---@param creature Creature
function ResolutionContext:SetTargetCreature(creature)
	self.targetCreature = creature
	return self
end

---@param item Item
function ResolutionContext:SetTargetItem(item)
	self.targetItem = item
	return self
end

--#region Requirements
function ResolutionContext:CheckTopic()
	local requirements = self.requirements
	if not requirements.requiredTopic then
		return REQUIREMENT_STATUS.REQUIREMENT_PASSED
	end

	local topic = self.npcHandler.topic[self.cid]
	local min, max = ParseTopicMinMax(requirements)
	if topic < min or topic > max then
		return REQUIREMENT_STATUS.REQUIREMENT_NOT_PASSED
	end
	return REQUIREMENT_STATUS.REQUIREMENT_PASSED
end

function ResolutionContext:CheckRequiredItems()
	local requirements = self.requirements
	if not requirements.requiredItems then
		return REQUIREMENT_STATUS.REQUIREMENT_PASSED
	end

	if not self.player:HasItems(requirements.requiredItems) then
		self.errorMessage = self.textNoRequiredItems
		return REQUIREMENT_STATUS.REQUIREMENT_NOT_PASSED
	end
	return REQUIREMENT_STATUS.REQUIREMENT_PASSED
end

function ResolutionContext:CheckRequiredState()
	local requirements = self.requirements
	if not requirements.requiredState then
		return REQUIREMENT_STATUS.REQUIREMENT_PASSED
	end

	local errorMessage, canProceed = self.player:ErrorMessageIfHasIncorrectStorageValues(requirements.requiredState)
	if not canProceed then
		self.errorMessage = errorMessage or self.textNoRequiredState
		return REQUIREMENT_STATUS.REQUIREMENT_NOT_PASSED
	end

	return REQUIREMENT_STATUS.REQUIREMENT_PASSED
end

function ResolutionContext:CheckGlobalState()
	local requirements = self.requirements
	if not requirements.requiredGlobalState then
		return REQUIREMENT_STATUS.REQUIREMENT_PASSED
	end

	for key, value in pairs(requirements.requiredGlobalState) do
		if Game.getStorageValueByKey(key) ~= value then
			self.errorMessage = self.textNoRequiredGlobalState
			return REQUIREMENT_STATUS.REQUIREMENT_NOT_PASSED
		end
	end
	return REQUIREMENT_STATUS.REQUIREMENT_PASSED
end

function ResolutionContext:CheckCanAddRewards()
	local actions = self.actionsOnSuccess
	if not actions.rewards then
		return REQUIREMENT_STATUS.REQUIREMENT_PASSED
	end

	local result, errorMessage = self.player:CanAddItems(actions.rewards)
	if result ~= true then
		self.player:sendTextMessage(MESSAGE_FAILURE, errorMessage) -- DO NOT TRANSLATE
		self.errorMessage = NOT_ENOUGH_CAP_OR_SLOTS
		return REQUIREMENT_STATUS.REQUIREMENT_NOT_PASSED
	end
	return REQUIREMENT_STATUS.REQUIREMENT_PASSED
end

function ResolutionContext:CheckRequiredMoney()
	local requirements = self.requirements
	if not requirements.requiredMoney then
		return REQUIREMENT_STATUS.REQUIREMENT_PASSED
	end

	local balance = Bank.balance(self.player)
	local playerMoney = self.player:getMoney()
	local totalPlayerMoney = balance + playerMoney
	if totalPlayerMoney < requirements.requiredMoney then
		self.errorMessage = self.textNoRequiredMoney
		return REQUIREMENT_STATUS.REQUIREMENT_NOT_PASSED
	end
	return REQUIREMENT_STATUS.REQUIREMENT_PASSED
end

function ResolutionContext:CheckSpecialRequirements()
	local requirements = self.requirements
	if not requirements.specialRequirements then
		return REQUIREMENT_STATUS.REQUIREMENT_PASSED
	end

	for _, context in pairs(requirements.specialRequirements) do
		local requirementContext = MergedTable(context, self)
		local requirement = requirementContext.requirement
		local outcome, errorMessage = requirement(requirementContext)
		if outcome ~= requirementContext.requiredOutcome then
			if outcome ~= NO_REQUIREMENT_FAIL_TEXT then
				self.errorMessage = errorMessage or requirementContext.textFailedRequirement
			end
			self.npcHandler.topic[self.cid] = requirementContext.nextTopic or TOPIC_DEFAULT
			return REQUIREMENT_STATUS.REQUIREMENT_NOT_PASSED
		end
	end
	return REQUIREMENT_STATUS.REQUIREMENT_PASSED
end
--#endregion Requirements

--#region Actions on success
function ResolutionContext:TriggerSpecialActions()
	local actions = self.actionsOnSuccess
	if not actions.specialActionsOnSuccess then
		return
	end

	for _, context in pairs(actions.specialActionsOnSuccess) do
		local action = context.action
		local actionContext = MergedTable(context, self)
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
		self.player:RemoveItems(requirements.requiredItems)
	end
end

function ResolutionContext:AddRewards()
	local actions = self.actionsOnSuccess
	if not actions.rewards then
		return
	end

	self.player:AddItemsAnnounce(actions.rewards)
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

	for _, monsterData in pairs(actions.spawnMonstersOnSuccess) do
		for _ = 1, monsterData.count or 1 do
			Game.createMonster(monsterData.name, self.player:getPosition())
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

function ResolutionContext:AddWildcard()
	local actions = self.actionsOnSuccess
	if not actions.wildcardReward then
		return
	end

	self.player:addPreyCards(actions.wildcardReward)
end

function ResolutionContext:UpdatePlayerState()
	local actions = self.actionsOnSuccess
	if not actions.nextState then
		return
	end

	self.player:NextState(actions.nextState)
end

function ResolutionContext:UpdateGlobalState()
	local actions = self.actionsOnSuccess
	if not actions.nextGlobalState then
		return
	end

	UpdateStorages(actions.nextGlobalState)
end

function ResolutionContext:SetNextTopic()
	local actions = self.actionsOnSuccess
	if actions.preserveTopic == true then
		return
	end
	if not self.npcHandler then
		return
	end

	self.npcHandler.topic[self.cid] = actions.nextTopic or 0
	addEvent(function()
		self.npcHandler.topic[self.cid] = actions.nextTopic or 0
	end, 5)
end

function ResolutionContext:AppendLastDialogToRegistry()
	local actions = self.actionsOnSuccess
	if actions.addDialogData ~= false then
		PlayerDialogDataRegistry:Get(self.player):Add(self)
	end
end

function ResolutionContext:TrySendTranslateSuccessMessage()
	if not self.actionsOnSuccess.text or self.actionsOnSuccess.text == NO_TEXT then
		return
	end

	local translatedMessage = self.player:Localizer(self.localizer):Context(self):Get(self.actionsOnSuccess.text)
	if not translatedMessage then
		logger.error(T('Translation of ":text:" is missing for language :lang:', { text = self.actionsOnSuccess.text, lang = self.player:getLanguage() }))
		return
	end

	if not self.npcHandler then
		self.player:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
		return
	end

	if self.specialMessageType then
		self.npcHandler:setMessage(self.specialMessageType, translatedMessage)
	else
		self.npcHandler:say(translatedMessage, self.npc, self.player)
	end
end

function ResolutionContext:SetGreetContext()
	self.greetContext = GreetCallbackContext()
	if self.actionsOnSuccess.messageOnGreet ~= nil then
		self.greetContext:MessageOnGreet(self.actionsOnSuccess.messageOnGreet)
	end

	if self.actionsOnSuccess.interactOnGreet ~= nil then
		self.greetContext:InteractOnGreet(self.actionsOnSuccess.interactOnGreet)
	end
end

function ResolutionContext:TrySendFailMessage()
	if not self.errorMessage then
		return
	end

	local translatedMessage = self.player:Localizer(self.localizer):Context(self):Get(self.errorMessage)
	if not translatedMessage then
		logger.error(T('Translation of ":text:" is missing for language :lang:', { text = self.errorMessage, lang = self.player:getLanguage() }))
		translatedMessage = self.errorMessage .. " //Missing translation"
	end

	if not self.npcHandler then
		self.player:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
		return
	end

	if self.specialMessageType then
		self.npcHandler:setMessage(self.specialMessageType, translatedMessage)
	else
		self.npcHandler:say(translatedMessage, self.npc, self.player)
	end
end

function ResolutionContext:AppendExtractedParams()
	for key, value in pairs(self.extractedParams or {}) do
		self[key] = value
	end
end
--#endregion Actions on success

local resolutionRequirements = {
	ResolutionContext.CheckTopic,
	ResolutionContext.CheckRequiredItems,
	ResolutionContext.CheckRequiredState,
	ResolutionContext.CheckGlobalState,
	ResolutionContext.CheckCanAddRewards,
	ResolutionContext.CheckRequiredMoney,
	ResolutionContext.CheckSpecialRequirements,
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
	ResolutionContext.AddWildcard,
	ResolutionContext.UpdatePlayerState,
	ResolutionContext.UpdateGlobalState,
	ResolutionContext.SetNextTopic,
	ResolutionContext.AppendLastDialogToRegistry,
	ResolutionContext.TrySendTranslateSuccessMessage,
	ResolutionContext.SetGreetContext,
}

function ResolutionContext:RequirementsPassabilityStatus()
	for _, requirement in pairs(resolutionRequirements) do
		local status = requirement(self)
		if status == REQUIREMENT_STATUS.REQUIREMENT_NOT_PASSED then
			return RESOLVER_STATUS.AT_LEAST_ONE_REQUIREMENT_NOT_PASSED
		end
	end
	return RESOLVER_STATUS.ALL_REQUIREMENTS_PASSED
end

function ResolutionContext:ActionsOnSuccess()
	for _, action in pairs(actionsOnSuccessfulResolution) do
		action(self)
	end
end

function ResolutionContext:Resolve()
	self:AppendExtractedParams()
	local status = self:RequirementsPassabilityStatus()
	if status == RESOLVER_STATUS.AT_LEAST_ONE_REQUIREMENT_NOT_PASSED then
		if self.errorMessage then
			self:TrySendFailMessage()
			return FAIL_RESOLVE
		end
		return DISCARD_DIALOG
	else
		self.lastDialogData = PlayerDialogDataRegistry:Get(self.player):Latest()
		self:ActionsOnSuccess()
		return SUCCESS_RESOLVE
	end
end

RewardsRegistry = {}
RewardsRegistry.__index = RewardsRegistry
RewardsRegistry.questRewardOutfitIds = {}
RewardsRegistry.registry = {
	outfitAddons = {},
}

function RewardsRegistry:ValidateOutfitsQuestRewardsVsGamestore()
	local gamestoreOutfitIds = {}
	for key, category in pairs(GameStore.Categories) do
		for key, offer in pairs(category.offers or {}) do
			for key, outfitId in pairs(offer.sexId or {}) do
				table.insert(gamestoreOutfitIds, outfitId)
			end
		end
	end
	for quest, questOufits in pairs(QuestRewards.OutfitsAddons) do
		for outfitNameAddon, outfitData in pairs(questOufits) do
			for key, sexOutfitData in pairs(outfitData) do
				local outfitId = sexOutfitData.outfitId
				if table.contains(gamestoreOutfitIds, outfitId) then
					local name = Game.getOutfitNameByLookType(outfitId)
					logger.warn(T("[RewardsRegistry:ValidateOutfitsQuestRewardsVsGamestore] Outfit :name:, id :id:, is obtainable in both quest and in store. Remove item from store to suppress this warning.", { name = name, id = outfitId }))
				end
			end
		end
	end
end

function RewardsRegistry:SerializeAll()
	local combinedStr = ""
	for category, categoryStrings in pairs(self.registry) do
		combinedStr = combinedStr .. category .. "\n"
		for _, str in pairs(categoryStrings) do
			combinedStr = combinedStr .. "\t" .. str
		end
	end
	SerializeToUtilFolder(combinedStr, "obtainable_rewards.lua")
end
