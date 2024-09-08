local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheApeCity.QuestProgress) > 16 then
		if item.itemid == 7721 then
			player:teleportTo(toPosition, true)
			item:transform(item.itemid + 1)
		elseif item.itemid == 7723 then
			player:teleportTo(toPosition, true)
			item:transform(item.itemid + 1)
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Drzwi ani drgna. Czyzby to byla jakas magia malp?")
	end
	return true
end
action:aid(2157)
action:register()
