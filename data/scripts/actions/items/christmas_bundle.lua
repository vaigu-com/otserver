local christmasbundleToPossibleReward = {
	[6506] = { { id = 6569, count = 15 }, { id = 3585, count = 5 }, { id = 3586, count = 10 }, { id = 3598, count = 20 }, { id = 3599, count = 10 }, { id = 6500, count = 1 }, { id = 6501, count = 1 }, { id = 6489, count = 1 }, { id = 6503, count = 1 }, { id = 6387, count = 1 } }, -- red bundle
	[6507] = { { id = 6569, count = 15 }, { id = 3585, count = 5 }, { id = 3586, count = 10 }, { id = 3598, count = 20 }, { id = 3599, count = 10 }, { id = 6500, count = 1 }, { id = 6501, count = 1 }, { id = 6489, count = 1 }, { id = 6505, count = 1 }, { id = 6387, count = 1 } }, -- blue bundle
	[6508] = { { id = 6569, count = 15 }, { id = 3585, count = 5 }, { id = 3586, count = 10 }, { id = 3598, count = 20 }, { id = 3599, count = 10 }, { id = 6500, count = 1 }, { id = 6501, count = 1 }, { id = 6489, count = 1 }, { id = 6502, count = 1 }, { id = 6387, count = 1 } }, -- green bundle
}

local christmasBundle = Action()

function christmasBundle.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local possibleRewards = christmasbundleToPossibleReward[item.itemid]
	if not possibleRewards then
		return true
	end

	local selectedRewards = {}
	while #selectedRewards < 7 do
		table.insert(selectedRewards, table.random(possibleRewards))
	end

	for _, reward in ipairs(selectedRewards) do
		print(reward, reward.id, reward.count)
		player:AddCustomItem(reward)
	end

	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
	item:remove(1)
	return true
end

for itemId in pairs(christmasbundleToPossibleReward) do
	christmasBundle:id(itemId)
end

christmasBundle:register()
