local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Finished.Annihilator) ~= 1 then
		if item.itemid == 5113 then
			player:teleportTo(toPosition, true)
			item:transform(item.itemid + 1)
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zaliczyles juz ten quest.")
	end
	return true
end

action:aid(2214)
action:register()
