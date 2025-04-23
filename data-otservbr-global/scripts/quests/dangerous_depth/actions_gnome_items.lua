local dangerousDepthItems = Action()

function dangerousDepthItems.onUse(player, item)
	if item.uid == 57235 then
		if player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.GnomeChartPaper) == 1 then
<<<<<<< HEAD
<<<<<<< HEAD
			player:AddCustomItem({id = 27308, count = 1})
=======
			player:addItem(27308, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
=======
			player:addItem(27308, 1)
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a gnome charts.")
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.GnomeChartPaper, 2)
		elseif player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.GnomeChartPaper) == 2 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can not use this item again.")
		end
	elseif item.uid == 57236 then
		if player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.GnomeChartChest) == 1 then
<<<<<<< HEAD
<<<<<<< HEAD
			player:AddCustomItem({id = 27307, count = 1})
=======
			player:addItem(27307, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
=======
			player:addItem(27307, 1)
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a gnome trignometre.")
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.GnomeChartChest, 2)
		elseif player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.GnomeChartChest) == 2 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
		end
	end

	return true
end

dangerousDepthItems:uid(57235, 57236)
dangerousDepthItems:register()
