local lyre = Action()

function lyre.onUse(player, item, frompos, item2, topos)
	if player:getStorageValue(Storage.Quest.U12_20.KilmareshQuest.Thirteen.Lyre) == 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found Lyre.")
<<<<<<< HEAD
		player:AddCustomItem({id = 31447, count = 1})
=======
		player:addItem(31447, 1)
<<<<<<< HEAD
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
=======
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
		player:setStorageValue(Storage.Quest.U12_20.KilmareshQuest.Thirteen.Lyre, 3)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The bag can not be opened.")
	end

	return true
end

lyre:uid(57529)
lyre:register()
