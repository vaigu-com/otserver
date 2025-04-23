local cagekey = Action()

function cagekey.onUse(player, item, frompos, item2, topos)
	if player:getStorageValue(Storage.Quest.U12_20.KilmareshQuest.Fourteen.Remains) == 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a wooden cage key.")
<<<<<<< HEAD
		player:AddCustomItem({id = 31379, count = 1}) -- Wooden Cage Key
=======
		player:addItem(31379, 1) -- Wooden Cage Key
<<<<<<< HEAD
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
=======
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
		player:setStorageValue(Storage.Quest.U12_20.KilmareshQuest.Fourteen.Remains, 3)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Empty.")
	end

	return true
end

cagekey:uid(57530)
cagekey:register()
