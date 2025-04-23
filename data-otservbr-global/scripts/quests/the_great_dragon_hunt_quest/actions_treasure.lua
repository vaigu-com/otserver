local items = {
	{ description = "a platinum coins", items = { { id = ITEM_PLATINUM_COIN, count = 5 } } },
	{
		description = "some gems",
		items = {
			{ id = 3029, count = 1 },
			{ id = 3032, count = 1 },
			{ id = 3030, count = 1 },
		},
	},
	{ description = "a life ring", items = { { id = 3089, count = 1 } } },
	{ description = "a red gem", items = { { id = 3039, count = 1 } } },
	{ description = "a mana potion", items = { { id = 237, count = 10 } } },
	{ description = "a health potion", items = { { id = 236, count = 8 } } },
}

local adventurersTreasure = Action()

function adventurersTreasure.onUse(player, item, fromPosition, target, toPosition, isHotkey)
<<<<<<< HEAD
<<<<<<< HEAD
	if player:getStorageValue(Storage.Quest.U10_80.TheGreatDragonHunt.DragonCounter) >= 50 then
=======
<<<<<<<< HEAD:data-vaigu/scripts/quests/adventurers_guild/actions_treasure.lua
	if player:getStorageValueByKey(Storage.AdventurersGuild.GreatDragonHunt.DragonCounter) >= 50 then
========
	if player:getStorageValue(Storage.Quest.U10_80.TheGreatDragonHunt.DragonCounter) >= 50 then
>>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a:data-otservbr-global/scripts/quests/the_great_dragon_hunt_quest/actions_treasure.lua
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
		local treasure = items[math.random(#items)]
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is impossible to take along all of the treasures here. But you pick out " .. treasure.description)
		for _, item in ipairs(treasure.items) do
			player:AddCustomItem({id = item.id, count = item.count})
		end

<<<<<<< HEAD
		player:setStorageValue(Storage.Quest.U10_80.TheGreatDragonHunt.DragonCounter, 0)
=======
<<<<<<<< HEAD:data-vaigu/scripts/quests/adventurers_guild/actions_treasure.lua
		-- reset dragon counter
		player:setStorageValueByKey(Storage.AdventurersGuild.GreatDragonHunt.DragonCounter, 0)
========
		player:setStorageValue(Storage.Quest.U10_80.TheGreatDragonHunt.DragonCounter, 0)
>>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a:data-otservbr-global/scripts/quests/the_great_dragon_hunt_quest/actions_treasure.lua
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
=======
	if player:getStorageValue(Storage.Quest.U10_80.TheGreatDragonHunt.DragonCounter) >= 50 then
		local treasure = items[math.random(#items)]
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is impossible to take along all of the treasures here. But you pick out " .. treasure.description)
		for _, item in ipairs(treasure.items) do
			player:addItem(item.id, item.count)
		end

		player:setStorageValue(Storage.Quest.U10_80.TheGreatDragonHunt.DragonCounter, 0)
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32

		local times = player:getStorageValue(Storage.Quest.U10_80.TheGreatDragonHunt.Achievement)
		if times < 0 then
			times = 0
		end
		times = times + 1
		player:setStorageValue(Storage.Quest.U10_80.TheGreatDragonHunt.Achievement, times)

<<<<<<< HEAD
<<<<<<< HEAD
		if times == 10 then
			player:addAchievement("Hoard of the Dragon")
=======
<<<<<<<< HEAD:data-vaigu/scripts/quests/adventurers_guild/actions_treasure.lua
		local times = player:getStorageValueByKey(achievement.actionStorage)
		if times < 10 then
			player:setStorageValueByKey(achievement.actionStorage, times + 1)
		end

		if times + 1 == 10 then
			player:addAchievement(achievement.id)
========
		if times == 10 then
			player:addAchievement("Hoard of the Dragon")
>>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a:data-otservbr-global/scripts/quests/the_great_dragon_hunt_quest/actions_treasure.lua
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
=======
		if times == 10 then
			player:addAchievement("Hoard of the Dragon")
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You try to pick a treasure, but you hear further dragons approaching. You should kill some more before picking out something.")
	end

	return true
end

adventurersTreasure:aid(50808)
<<<<<<< HEAD
adventurersTreasure:register()
=======
adventurersTreasure:register()
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
