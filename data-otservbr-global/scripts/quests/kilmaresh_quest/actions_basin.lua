local basin = Action()

function basin.onUse(player, item, frompos, item2, topos)
	if player:getStorageValue(Storage.Quest.U12_20.KilmareshQuest.Tem.Bleeds) == 1 then
<<<<<<< HEAD
<<<<<<< HEAD
		player:AddCustomItem({id = 31431, count = 1})
=======
=======
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
		player:addItem(31431, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You find a golden symbol at the bottom of the blood-filled basin.")
		player:setStorageValue(Storage.Quest.U12_20.KilmareshQuest.Eleven.Basin, 1)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sorry")
	end
	return true
end

basin:uid(57527)
basin:register()
