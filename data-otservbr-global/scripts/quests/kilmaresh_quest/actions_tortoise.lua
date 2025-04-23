local tortoise = Action()

function tortoise.onUse(player, item, frompos, item2, topos)
	if player:getStorageValue(Storage.Quest.U12_20.KilmareshQuest.Thirteen.Presente) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Tortoise.")
<<<<<<< HEAD
		player:AddCustomItem({id = 31445, count = 1})
=======
		player:addItem(31445, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
		player:setStorageValue(Storage.Quest.U12_20.KilmareshQuest.Thirteen.Presente, 2)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The tortoise nest empty.")
	end

	return true
end

tortoise:uid(57528)
tortoise:register()
