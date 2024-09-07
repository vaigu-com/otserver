local data = {
	[ITEM_GOLD_COIN] = { changeTo = ITEM_PLATINUM_COIN },
	[ITEM_PLATINUM_COIN] = { changeBack = ITEM_GOLD_COIN, changeTo = ITEM_CRYSTAL_COIN },
	[ITEM_CRYSTAL_COIN] = { changeBack = ITEM_PLATINUM_COIN },
}

local function get100Stack(potentialsStacks)
	for _, item in pairs(potentialsStacks) do
		if item.type == 100 then
			return item
		end
	end
	return nil
end

local changeGold = Action()
function changeGold.onUse(player, coin, fromPosition, target, toPosition, isHotkey)
	local coinId = coin:getId()
	local coinData = data[coinId]
	local allStacks = player:GetAllItems():FilteredById(coinId):Get()
	-- local allStacks = player:GetAllItems():FilteredById(coinId):Add(coin):Get()
	local fullStack = get100Stack(allStacks)
	if coinData.changeTo and fullStack then
		fullStack:remove()
		player:addItem(coinData.changeTo, 1)
		return true
	end
	if coinData.changeBack and not fullStack then
		coin:remove(1)
		player:addItem(coinData.changeBack, 100)
		return true
	end
	return false
end
changeGold:id(ITEM_GOLD_COIN, ITEM_PLATINUM_COIN, ITEM_CRYSTAL_COIN)
changeGold:register()
