local config = {
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
function changeGold.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local coinId = item:getId()
	local coinConfig = config[coinId]
	local allStacks = player:GetAllItems(coinId)
	table.insert(allStacks, item)
	local fullStack = get100Stack(allStacks)
	if coinConfig.changeTo and fullStack then
		fullStack:remove()
		player:addItem(coinConfig.changeTo, 1)
		return true
	elseif coinConfig.changeBack and not fullStack then
		item:remove(1)
		player:addItem(coinConfig.changeBack, 100)
		return true
	end
	return false
end
print("CHANGE GOLD REGISTER")
changeGold:id(3031, 3035, 3043)
changeGold:register()
