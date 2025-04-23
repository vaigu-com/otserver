local dangerousDepthChest = Action()

function dangerousDepthChest.onUse(player, item)
	if player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Scouts.GnomishChest) == 1 then
<<<<<<< HEAD
<<<<<<< HEAD
		player:AddCustomItem({id = 27498, count = 1})
=======
		player:addItem(27498, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
=======
		player:addItem(27498, 1)
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found gnomish pesticides.")
		player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Scouts.GnomishChest, 2)
	elseif player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Scouts.GnomishChest) == 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
	end
	return true
end

dangerousDepthChest:uid(57234)
dangerousDepthChest:register()
