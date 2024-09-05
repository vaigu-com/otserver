local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not isInRange(toPosition, Position(6198, 980, 11), Position(6260, 1042, 11)) then --{x = 6198, y = 980, z = 11}{x = 6260, y = 1042, z = 11}
		return false
	end

	if isInArray({ 844, 845 }, item.itemid) then
		toPosition.y = toPosition.y + (item.itemid == 844 and 1 or -1)
		local machineItem = Tile(toPosition):getItemById(item.itemid == 844 and 845 or 844)
		if machineItem then
			machineItem:transform(machineItem.itemid + 4)
		end
		item:transform(item.itemid + 4)
		player:say("OFF", TALKTYPE_MONSTER_SAY)
	else
		toPosition.y = toPosition.y + (item.itemid == 844 and 1 or -1)
		local machineItem = Tile(toPosition):getItemById(item.itemid == 844 and 845 or 844)
		if machineItem then
			machineItem:transform(machineItem.itemid - 4)
		end
		item:transform(item.itemid - 4)
		player:say("ON", TALKTYPE_MONSTER_SAY)
	end
	return true
end

action:id(844, 845, 848, 849)
action:register()
