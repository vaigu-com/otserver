local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local test = getGlobalStorageValue(GlobalStorage.FlamingOrchid)

	if test <= 0 then -- jak nie ma asury
		if item.itemid == 1674 then
			player:teleportTo(toPosition, true)
			item:transform(item.itemid + 1)
		end
	elseif test == 5 then
		if item.itemid == 1674 then
			player:teleportTo(toPosition, true)
			item:transform(item.itemid + 1)
		end
	else
		if player:getPosition() == Position(6614, 999, 3) or player:getPosition() == Position(6614, 998, 3) then
			if item.itemid == 1674 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Na drzwiach widzisz malowidlo z kolejno chowajacymi sie po palacu Lich, Destroyer, Fire Elemental i Vampire.")
		end
	end
	return true
end
action:aid(2491)
action:register()
