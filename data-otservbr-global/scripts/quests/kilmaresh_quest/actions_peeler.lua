local peeler = Action()

function peeler.onUse(player, item, frompos, item2, topos)
	if player:getStorageValue(Storage.Quest.U12_20.KilmareshQuest.Set.Ritual) == 2 then
<<<<<<< HEAD
<<<<<<< HEAD
		player:AddCustomItem({id = 31328, count = 1})
=======
		player:addItem(31328, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
=======
		player:addItem(31328, 1)
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
		player:setStorageValue(Storage.Quest.U12_20.KilmareshQuest.Set.Ritual, 3)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a bark peeler.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Empty.")
	end

	return true
end

peeler:uid(57518)
peeler:register()
