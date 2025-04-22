local gravediggerCaixa = Action()
function gravediggerCaixa.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U10_10.TheGravediggerOfDrefia.Mission67) == 1 and player:getStorageValue(Storage.Quest.U10_10.TheGravediggerOfDrefia.Mission68) < 1 then
		player:setStorageValue(Storage.Quest.U10_10.TheGravediggerOfDrefia.Mission68, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found an incantation fragment.")
<<<<<<< HEAD
		player:AddCustomItem({id = 18933, count = 1})
=======
		player:addItem(18933, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
	end
	return true
end

gravediggerCaixa:uid(4663)
gravediggerCaixa:register()
