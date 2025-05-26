local rewards = {
	[3148] = {
		storage = Storage.BigfootsBurden.Warzone1Reward,
		bossName = "Deathstrike",
		rewards = {
			{ itemId = 16108, count = 750 },
			{ itemId = 16102 },
			{ itemId = 3043, count = 3 },
			{ itemId = 16121, count = 7 },
			{ itemId = 16129, count = 2 },
		},
		rewardsRandom = {
			16102,
			16233,
			16234,
			16235,
		},
		achievement = { "Final Strike", "Death on Strike" },
	},
	[3149] = {
		storage = Storage.BigfootsBurden.Warzone2Reward,
		bossName = "Gnomevil",
		rewards = {
			{ itemId = 16113, count = 750 },
			{ itemId = 16102 },
			{ itemId = 3043, count = 4 },
			{ itemId = 16119, count = 10 },
			{ itemId = 16129, count = 2 },
		},
		rewardsRandom = {
			16237,
			16238,
			16239,
		},
		miniatureHouse = true,
		achievement = { "Gnomebane's Bane", "Fall of the Fallen" },
	},
	[3150] = {
		storage = Storage.BigfootsBurden.Warzone3Reward,
		bossName = "Abyssador",
		rewards = {
			{ itemId = 16114 },
			{ itemId = 16102 },
			{ itemId = 3043, count = 5 },
			{ itemId = 16120, count = 12 },
			{ itemId = 16129, count = 2 },
		},
		rewardsRandom = {
			16229,
			16230,
			16231,
		},
		achievement = { "Death from Below", "Diplomatic Immunity" },
	},
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.uid == 3147 then
		if player:getStorageValueByKey(Storage.BigfootsBurden.WarzoneStatus) == 4 then
			player:setStorageValueByKey(Storage.BigfootsBurden.WarzoneStatus, 5)
			player:AddCustomItem({ id = 3020, count = 1 })
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Znalazles troche zlotych owocow.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Skrzynia jest pusta.")
		end
	elseif item.uid > 3147 and item.uid < 3151 then
		local boxData = rewards[item.uid]
		if not boxData then
			return true
		end

		if player:getStorageValueByKey(boxData.storage) ~= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, boxData.bossName .. " czuwa nad swoim skarbem i nie pozwoli ci go wykrasc.")
			return true
		end

		local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
		if backpack and backpack:getEmptySlots(true) < 1 or player:getFreeCapacity() < 100 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Upewnij sie ze masz wolne miejsce i uniesiesz conajmniej 100 oz.")
			return true
		end

		local rolledLoot = {}
		local possibleRewards = boxData.rewardsRandom
		local randomRewardsRoll = math.random(1, 100)
		if randomRewardsRoll <= 10 then
			local rewardId = table.random(possibleRewards)
			table.insert(rolledLoot, { id = rewardId, count = possibleRewards.count })
		end

		for _, reward in pairs(boxData.rewards) do
			table.insert(rolledLoot, { id = reward.itemId, count = reward.count })
		end

		if boxData.miniatureHouse then
			if math.random(25) == 1 then
				table.insert(rolledLoot, { id = 15276 })
			end
		end
		player:AddItems({ [2864] = rolledLoot })

		player:setStorageValueByKey(boxData.storage, -1)
		--player:addAchievement(reward.achievement[1])
		player:addAchievementProgress(boxData.achievement[2], 50)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
	end
	return true
end

action:uid(3147, 3148, 3149, 3150)
action:register()
