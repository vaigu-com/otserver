SPECIAL_CONDITIONS_UNIVERSAL = {
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
		if SPECIAL_CONDITIONS_UNIVERSAL.hasMoney(context) then
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

SPECIAL_CONDITIONS_IMBUING = {
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
		local bundleData = PlayerCustomDialogDataRegistry:Get(context.player).bundleData
		local level = bundleData.levelName
		if level ~= IMBUING_LEVELS.powerful then
			return true
		end
		return context.player:getStorageValue(Storage.powerfulImbue) >= 1
	end,
	hasEnoughTaskPoints = function(context)
		local bundleData = PlayerCustomDialogDataRegistry:Get(context.player).bundleData
		local requiredTaskPoints = bundleData.taskPointsCost
		local playerTaskPoints = context.player:getStorageValue(Storage.taskPoints)
		local playerHasPoints = playerTaskPoints >= requiredTaskPoints
		if not playerHasPoints then
			PlayerCustomDialogDataRegistry:Get(context.player).requiredTaskPoints = requiredTaskPoints
		end
		return playerHasPoints
	end,
	hasEnoughMoney = function(context)
		local bundleData = PlayerCustomDialogDataRegistry:Get(context.player).bundleData
		local requiredMoney = bundleData.moneyCost
		local playerMoney = context.player:GetTotalMoney()
		return playerMoney >= requiredMoney
	end,
	hasEnoughCapSlots = function(context)
		local bundleData = PlayerCustomDialogDataRegistry:Get(context.player).bundleData
		return context.player:CanAddItems(bundleData.items)
	end,
}

SPECIAL_CONDITIONS_WILDCARD = {
	hasMoneyForWildcards = function(context)
		local player = context.player
		local orderedCards = PlayerCustomDialogDataRegistry:Get(context.player).orderedCards
		local requiredMoney = player:GetWildcardPrice() * orderedCards
		local playerMoney = player:GetTotalMoney()
		return playerMoney >= requiredMoney
	end,
}

SPECIAL_CONDITIONS_TASKS = {
	canTakeAnotherTask = function(context)
		local player = context.player
		return player:CanTakeAnotherTask()
	end,
	hasAnyOngoingTask = function(context)
		local player = context.player
		return player:HasAnyOngoingTask()
	end,
	hasDoneAnyTask = function(context)
		local player = context.player
		return player:DoneAnyTask()
	end,
}

SPECIAL_CONDITIONS_DAILY_TASK = {
    hasAnyOngoingDailyTask = function(context)
        local player = context.player
        return player:HasAnyOngoingDailyTask()
    end
}