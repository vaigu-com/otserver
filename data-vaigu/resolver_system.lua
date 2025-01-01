-- Requirements
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
		self.errorMessage = self.textNoRequiredItems
		return CONDITION_STATUS.CONDITION_NOT_PASSED
	end
	return CONDITION_STATUS.CONDITION_PASSED
end

function ResolutionContext:CheckRequiredState()
	local requirements = self.requirements
	if not requirements.requiredState then
		return CONDITION_STATUS.CONDITION_PASSED
	end

	local errorMessage, canProceed = self.player:ErrorMessageIfHasIncorrectStorageValues(requirements.requiredState)
	if not canProceed then
		self.errorMessage = errorMessage or self.textNoRequiredState
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
			self.errorMessage = self.textNoRequiredGlobalState
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

	local result, errorMessage = self.player:CanAddItems(actions.rewards, self.localizer)
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

-- Actions on success
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

	self.player:AddItems(actions.rewards, nil, self.localizer)
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

	self.player:NextState(actions.nextState)
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
	if not self.actionsOnSuccess.text then
		return
	end

	local translatedMessage = self.player:Localizer(self.localizer):Context(self):Get(self.actionsOnSuccess.text)
	if not translatedMessage then
		logger.error(T('Translation of ":text:" is missing for language :lang:', { text = self.actionsOnSuccess.text, lang = self.player:getLanguage() }))
		return
	end

	if self.specialMessageType then
		self.npcHandler:setMessage(self.specialMessageType, translatedMessage)
	else
		self.npcHandler:say(translatedMessage, self.npc, self.player)
	end
end

function ResolutionContext:TrySendTranslateFailMessage()
	if not self.errorMessage then
		return
	end

	local translatedMessage = self.player:Localizer(self.localizer):Context(self):Get(self.errorMessage)
	if not translatedMessage then
		logger.error(T('Translation of ":text:" is missing for language :lang:', { text = self.errorMessage, lang = self.player:GetLanguage() }))
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
	ResolutionContext.AppendLastDialogToRegistry,
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
		self.lastDialogData = PlayerDialogDataRegistry:Get(self.player):Latest()
		self:ActionsOnSuccess()
		return SUCCESS_RESOLVE
	end
end