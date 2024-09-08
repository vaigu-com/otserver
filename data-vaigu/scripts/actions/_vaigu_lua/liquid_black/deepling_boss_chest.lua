local rewards = {
	[25610] = {
		storage = Storage.DeeplingBosses.Jaul,
		bossName = "Jaul",
		items = {
			{ rand = true, itemId = { 14224, 14042, 14043 } }, -- trophy, warriors shield, guardian axe, necklace of the deep
			{ rand = true, itemId = { 13990, 14021 } },
			{ itemId = 3035, count = 30 }, -- platinum coin
		},
	},
	[25611] = {
		storage = Storage.DeeplingBosses.Tanjis,
		bossName = "Tanjis",
		items = {
			{ rand = true, itemId = { 14223, 14042, 13990 } }, -- trophy of tanjis, warriors shield, necklace, sight, pearl
			{ rand = true, itemId = { 14022, 3027 } }, -- trophy of tanjis, warriors shield, necklace, sight, pearl
			{ itemId = 3035, count = 30 }, -- platinum coin
		},
	},
	[25612] = {
		storage = Storage.DeeplingBosses.Obujos,
		bossName = "Obujos",
		items = {
			{ rand = true, itemId = { 14222, 13987 } }, -- trophy, deepling staff, axe, shell
			{ rand = true, itemId = { 14043, 14023 } }, -- trophy, deepling staff, axe, shell
			{ itemId = 3035, count = 30 }, -- platinum coin
			{ itemId = 281, count = 1 }, -- pearl
		},
	},
}

local deeplingRewards = Action()
function deeplingRewards.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.uid >= 25610 and item.uid <= 25612 then
		local reward = rewards[item.uid]
		if not reward then
			return false
		end

		if player:getStorageValue(reward.storage) ~= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, reward.bossName .. " defends his belongings and will not let you open his chest.")
			return true
		end

		local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
		if backpack and backpack:getEmptySlots(false) < 2 or player:getFreeCapacity() < 100 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Please make sure that you have at least 2 free inventory slots and that you can carry on additional 100 oz.")
			return true
		end

		for i = 1, #reward.items do
			local items = reward.items[i]
			if items.rand then
				if math.random(2) == 1 then
					player:addItem(items.itemId[math.random(#items.itemId)], 1)
				end
			else
				player:addItem(items.itemId, items.count or 1)
			end
		end

		player:setStorageValue(reward.storage, 0)
	end
	return true
end

deeplingRewards:uid(25610, 25611, 25612)
deeplingRewards:register()
