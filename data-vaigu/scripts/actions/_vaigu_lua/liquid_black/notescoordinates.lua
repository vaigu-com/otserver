local notescoordinates = Action()

function notescoordinates.onUse(player, item, frompos, item2, topos)
	if player:getStorageValueByKey(Storage.LiquidBlack.Visitor) == -1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found notes and coordinates.")
		player:addItem(14176, 1)
		player:setStorageValueByKey(Storage.LiquidBlack.Visitor, 2)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Empty.")
	end

	return true
end

notescoordinates:uid(57743)
notescoordinates:register()

