local data = {
	[ITEM_GOLD_COIN] = { upgrade = ITEM_PLATINUM_COIN },
	[ITEM_PLATINUM_COIN] = { downgrade = ITEM_GOLD_COIN, upgrade = ITEM_CRYSTAL_COIN },
	[ITEM_CRYSTAL_COIN] = { downgrade = ITEM_PLATINUM_COIN },
}

local function findFullPile(allCoinPiles)
	for _, item in pairs(allCoinPiles) do
		if item.type == 100 then
			return item
		end
	end
	return nil
end

local changeGold = Action()
function changeGold.onUse(player, usedCoinPile, fromPosition, target, toPosition, isHotkey)
	if player:getFreeBackpackSlots() < 1 then
		player:sendTextMessage(MESSAGE_FAILURE, string.format("You need at least one free slot in your inventory to do that."))
		return
	end

	local usedCoinId = usedCoinPile:getId()
	local usedCoinData = data[usedCoinId]
	local allCoinPiles = player:GetAllItems():FilterById(usedCoinId):Add(usedCoinPile):Get()
	local fullPile = findFullPile(allCoinPiles)
	if fullPile and usedCoinData.upgrade then
		fullPile:remove()
		player:AddCustomItem({id = usedCoinData.upgrade, count = 1})
		return true
	end
	if usedCoinData.downgrade then
		usedCoinPile:remove(1)
		player:AddCustomItem({id = usedCoinData.downgrade, count = 100})
		return true
	end
	return false
end
changeGold:id(ITEM_GOLD_COIN, ITEM_PLATINUM_COIN, ITEM_CRYSTAL_COIN)
local res = changeGold:register()