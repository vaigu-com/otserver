local rewards = {
	[3148] = {
		storage = Storage.BigfootBurden.Warzone1Reward,
		storaget = 724877,
		bossName = "Deathstrike",
		items = {
			{ rand = true, itemId = { 16102, 16233, 16234, 16235 } },
			{ itemId = 16108, count = 750 },
			{ itemId = 16102 },
			{ itemId = 3043, count = 3 },
			{ itemId = 16121, count = 7 },
			{ itemId = 16129, count = 2 },
		},
		achievement = { "Final Strike", "Death on Strike" },
	},
	[3149] = {
		storage = Storage.BigfootBurden.Warzone2Reward,
		storaget = 724878,
		bossName = "Gnomevil",
		items = {
			{ rand = true, itemId = { 16237, 16238, 16239 } },
			{ itemId = 16113, count = 750 },
			{ itemId = 16102 },
			{ itemId = 3043, count = 4 },
			{ itemId = 16119, count = 10 },
			{ itemId = 16129, count = 2 },
		},
		miniatureHouse = true,
		achievement = { "Gnomebane's Bane", "Fall of the Fallen" },
	},
	[3150] = {
		storage = Storage.BigfootBurden.Warzone3Reward,
		storaget = 724879,
		bossName = "Abyssador",
		items = {
			{ rand = true, itemId = { 16229, 16230, 16231 } },
			{ itemId = 16114 },
			{ itemId = 16102 },
			{ itemId = 3043, count = 5 },
			{ itemId = 16120, count = 12 },
			{ itemId = 16129, count = 2 },
		},
		achievement = { "Death from Below", "Diplomatic Immunity" },
	},
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.uid == 3147 then
		if player:getStorageValue(Storage.BigfootBurden.WarzoneStatus) == 4 then
			player:setStorageValue(Storage.BigfootBurden.WarzoneStatus, 5)
			player:addItem(3020, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Znalazles troche zlotych owocow.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Skrzynia jest pusta.")
		end
	elseif item.uid > 3147 and item.uid < 3151 then
		local reward = rewards[item.uid]
		if not reward then
			return true
		end

		if player:getStorageValue(reward.storage) ~= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, reward.bossName .. " czuwa nad swoim skarbem i nie pozwoli ci go wykrasc.")
			return true
		end

		if player:getStorageValue(reward.storaget) >= os.time() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Musisz odczekac 20 godzin aby znow odebrac nagrode.")
			return true
		end

		local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
		if backpack and backpack:getEmptySlots(true) < 1 or player:getFreeCapacity() < 100 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Upewnij sie ze masz wolne miejsce i uniesiesz conajmniej 100 oz.")
			return true
		end

		local cont = Container(player:addItem(2864):getUniqueId())

		for i = 1, #reward.items do
			local items = reward.items[i]
			if items.rand then
				if math.random(10) == 1 then
					cont:addItem(items.itemId[math.random(#items.itemId)], 1)
				end
			else
				cont:addItem(items.itemId, items.count or 1)
			end
		end

		if reward.miniatureHouse then
			if math.random(25) == 1 then
				cont:addItem(15276, 1)
			end
		end

		player:setStorageValue(reward.storaget, os.time() + 20 * 3600)
		player:setStorageValue(reward.storage, -1)
		--player:addAchievement(reward.achievement[1])
		player:addAchievementProgress(reward.achievement[2], 50)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
	end
	return true
end

action:uid(3147, 3148, 3149, 3150)
action:register()
