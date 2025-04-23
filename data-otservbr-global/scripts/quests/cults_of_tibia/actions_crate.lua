local cultsOfTibiaCrate = Action()
function cultsOfTibiaCrate.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local posCrate = Position(33300, 32277, 12)
	-- Document
	if item:getPosition() == posCrate then
		if player:getStorageValue(Storage.Quest.U11_40.CultsOfTibia.MotA.Mission) == 7 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Perfect! You took a wonderful loupe from this crate.")
<<<<<<< HEAD
			player:AddCustomItem({id = 25306, count = 1})
=======
			player:addItem(25306, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
			player:setStorageValue(Storage.Quest.U11_40.CultsOfTibia.MotA.Mission, 8)
		elseif player:getStorageValue(Storage.Quest.U11_40.CultsOfTibia.MotA.Mission) > 7 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already took the magnifier.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This crate belongs to Angelo. You should talk to him before taking something out.")
		end
	end
	return true
end

cultsOfTibiaCrate:aid(5523)
cultsOfTibiaCrate:register()
