MAX_LVL_TO_GET_FREE_BLESS = 35

SPECIAL_REQUIREMENTS_UNIVERSAL = {
	isSorcerer = function(context)
		local player = context.player
		if not player then
			return
		end
		return player:isSorcerer()
	end,
	isDruid = function(context)
		local player = context.player
		if not player then
			return
		end
		return player:isDruid()
	end,
	isKnight = function(context)
		local player = context.player
		if not player then
			return
		end
		return player:isKnight()
	end,
	isPaladin = function(context)
		local player = context.player
		if not player then
			return
		end
		return player:isPaladin()
	end,
	isMage = function(context)
		local player = context.player
		if not player then
			return
		end
		return player:isMage()
	end,
	canStartEscort = function(context)
		if context.escort:IsOngoing() then
			return false, "You cannot start this escort yet."
		end
		return true
	end,
	playerHasLevel = function(context)
		local player = context.player
		local playerLevel = player:getLevel()
		local minLevel = context.minLevel or 0
		local maxLevel = context.maxLevel or 9999
		return playerLevel >= minLevel and playerLevel <= maxLevel
	end,
	canAffordBless = function(context)
		local player = context.player
		local level = player:getLevel()
		if level <= MAX_LVL_TO_GET_FREE_BLESS then
			return true
		end

		local price = player:getFiveBlessingsCost()
		context.price = price
		if SPECIAL_REQUIREMENTS_UNIVERSAL.hasMoney(context) then
			return true
		end
		return false
	end,
	hasMoney = function(context)
		local requiredMoney = context.price or context.money or context.requiredMoney
		return context.player:canRemoveMoney(requiredMoney), "You dont have enough money."
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
	hasMount = function(context)
		return context.player:hasMount(context.mountId)
	end,
	hasBlessings = function(context)
		return context.player:hasBlessing(context.count or 1)
	end,
	isPromoted = function(context)
		return context.player:isPromoted()
	end,
	hasMarriedStatus = function(context)
		return getPlayerMarriageStatus(context.player:getGuid()) == MARRIED_STATUS
	end,
	hasProposedStatus = function(context)
		return getPlayerMarriageStatus(context.player:getGuid()) == PROPOSED_STATUS
	end,
}

SPECIAL_REQUIREMENTS_IMBUING = {
	saidImbuingName = function(context)
		local bundleData = GetImbuingBundleByName(context.msg)
		if type(bundleData) == "table" then
			PlayerCustomDialogDataRegistry:Get(context.player).bundleData = bundleData
			return true
		end
		return false
	end,
	saidImbuingLevel = function(context)
		local bundleData = PlayerCustomDialogDataRegistry:Get(context.player).bundleData
		local bundleLevelData = bundleData[context.msg]
		if type(bundleLevelData) == "table" then
			PlayerCustomDialogDataRegistry:Get(context.player).bundleLevelData = bundleLevelData
			return true
		end
		return false
	end,
	canPurchaseThisImbuingLevel = function(context)
		local bundleData = PlayerCustomDialogDataRegistry:Get(context.player).bundleLevelData
		local level = bundleData.levelName
		if level ~= IMBUING_LEVELS.powerful then
			return true
		end
		return context.player:getStorageValueByKey(Storage.powerfulImbue) >= 1
	end,
	hasEnoughTaskPoints = function(context)
		local bundleLevelData = PlayerCustomDialogDataRegistry:Get(context.player).bundleLevelData
		local requiredTaskPoints = bundleLevelData.taskPointsCost
		local playerTaskPoints = context.player:getStorageValueByKey(Storage.Tasks.TaskPoints)
		local playerHasPoints = playerTaskPoints >= requiredTaskPoints
		if not playerHasPoints then
			PlayerCustomDialogDataRegistry:Get(context.player).requiredTaskPoints = requiredTaskPoints
		end
		return playerHasPoints
	end,
	hasEnoughMoney = function(context)
		local bundleData = PlayerCustomDialogDataRegistry:Get(context.player).bundleLevelData
		local requiredMoney = bundleData.moneyCost
		local playerMoney = context.player:GetTotalMoney()
		return playerMoney >= requiredMoney
	end,
	hasEnoughCapSlots = function(context)
		local bundleData = PlayerCustomDialogDataRegistry:Get(context.player).bundleLevelData
		return context.player:CanAddItems(bundleData.items)
	end,
}

SPECIAL_REQUIREMENTS_WILDCARD = {
	hasMoneyForWildcards = function(context)
		local player = context.player
		local orderedCards = PlayerCustomDialogDataRegistry:Get(context.player).orderedCards
		local requiredMoney = player:GetWildcardPrice() * orderedCards
		local playerMoney = player:GetTotalMoney()
		return playerMoney >= requiredMoney
	end,
}

SPECIAL_REQUIREMENTS_DAILY_TASK = {}

local function parseMoneyWithdraw(context)
	local declaredMoneyAnyType = context.amount or PlayerDialogDataRegistry:Get(context.player):Latest().amount or PlayerDialogDataRegistry:Get(context.player):Previous().amount
	if type(declaredMoneyAnyType) == "string" and declaredMoneyAnyType == "all" then
		return Bank.balance(context.player)
	end

	local declaredMoneyNumber = tonumber(declaredMoneyAnyType)
	if declaredMoneyNumber == nil then
		return nil
	end
	if declaredMoneyNumber <= 0 then
		return nil
	end

	return declaredMoneyNumber
end

local function parseMoneyDeposit(context)
	local declaredMoneyAnyType = context.amount or PlayerDialogDataRegistry:Get(context.player):Latest().amount or PlayerDialogDataRegistry:Get(context.player):Previous().amount
	if type(declaredMoneyAnyType) == "string" and declaredMoneyAnyType == "all" then
		return context.player:getMoney()
	end

	local declaredMoneyNumber = tonumber(declaredMoneyAnyType)
	if declaredMoneyNumber == nil then
		return nil
	end
	if declaredMoneyNumber <= 0 then
		return nil
	end

	return declaredMoneyNumber
end

SPECIAL_REQUIREMENTS_BANK = {
	declaredMoneyIsParsable = function(context)
		local declaredMoneyAnyType = context.amount or PlayerDialogDataRegistry:Get(context.player):Latest().amount or PlayerDialogDataRegistry:Get(context.player):Previous().amount
		if type(declaredMoneyAnyType) == "string" and declaredMoneyAnyType == "all" then
			return true
		end

		local declaredMoneyNumber = tonumber(declaredMoneyAnyType)
		if declaredMoneyNumber == nil then
			return false
		end
		if declaredMoneyNumber <= 0 then
			return false
		end

		return true
	end,
	hasMoneyininventory = function(context)
		local depositedMoney = parseMoneyDeposit(context)
		if not depositedMoney then
			return false
		end
		local moneyInInventory = context.player:getMoney()
		return moneyInInventory >= depositedMoney
	end,
	hasMoneyinbank = function(context)
		local withdrawnMoney = parseMoneyWithdraw(context)
		if not withdrawnMoney or withdrawnMoney <= 0 then
			return false
		end

		return Bank.balance(context.player) >= withdrawnMoney
	end,
	canCarryWithdrawnMoney = function(context)
		local amount = PlayerCustomDialogDataRegistry:Get(context.player).amount
		local crystalCoins = math.floor(amount / 10000)
		amount = amount % 10000
		local platinumCoins = math.floor(amount / 100)
		amount = amount % 100
		local goldCoins = math.floor(amount / 1)
		local crystalPiles = math.floor((crystalCoins + 99) / 100)
		local platinumPiles = math.floor((platinumCoins + 99) / 100)
		local goldPiles = math.floor((goldCoins + 99) / 100)
		local pilesCount = crystalPiles + platinumPiles + goldPiles

		local player = context.player
		local hasCap, noCapMessage = player:ErrorIfHasNotEnoughCapacity(getMoneyWeight(amount))
		if not hasCap then
			player:sendTextMessage(MESSAGE_FAILURE, noCapMessage)
			return false
		end

		local hasSlots, noSlotsMessage = player:ErrorIfHasNotEnoughSlots(pilesCount)
		if not hasSlots then
			player:sendTextMessage(MESSAGE_FAILURE, noSlotsMessage)
			return false
		end

		return true
	end,
	extractRecipientName = function(context)
		local name = context.recipient
		if not name then
			return nil
		end
		if context.recipientNameSegment2 then
			name = name .. " " .. context.recipientNameSegment2
		end
		if context.recipientNameSegment3 then
			name = name .. " " .. context.recipientNameSegment3
		end

		return name
	end,
	recipientIsnotself = function(context)
		return context.player:getName() ~= SPECIAL_REQUIREMENTS_BANK.extractRecipientName(context)
	end,
	recipientExists = function(context)
		local recipientName = SPECIAL_REQUIREMENTS_BANK.extractRecipientName(context)
		local recipient = Game.getOfflinePlayer(recipientName)
		if not recipient then
			return false
		end
		return type(Bank.balance(recipient)) == "number"
	end,
}
