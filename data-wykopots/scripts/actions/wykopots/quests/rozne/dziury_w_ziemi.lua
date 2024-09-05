local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local licznik = getGlobalStorageValue(GlobalStorage.FlamingOrchid)
	if licznik < 5 and licznik > 0 then
		if item.uid == 11190 and licznik <= 2 and licznik >= 1 then
			toPosition.x = 6600
			toPosition.y = 1013
			toPosition.z = 6
			setGlobalStorageValue(GlobalStorage.FlamingOrchid, 2)
		elseif item.uid == 11191 and licznik <= 3 and licznik >= 2 then
			toPosition.x = 6611
			toPosition.y = 1005
			toPosition.z = 6
			setGlobalStorageValue(GlobalStorage.FlamingOrchid, 3)
		elseif item.uid == 11192 and licznik <= 4 and licznik >= 3 then
			toPosition.x = 6631
			toPosition.y = 1003
			toPosition.z = 6
			setGlobalStorageValue(GlobalStorage.FlamingOrchid, 4)
		elseif item.uid == 11193 and licznik >= 4 and licznik <= 5 then
			toPosition.x = 6641
			toPosition.y = 1009
			toPosition.z = 6
			setGlobalStorageValue(GlobalStorage.FlamingOrchid, 5)
		end
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(toPosition, false)
		toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		addEvent(setGlobalStorageValue, 6000 * 1000, GlobalStorage.FlamingOrchid, 0)
	else
		doCreatureSay(player, "Malo brakowalo, a wpadlbym do dziury!", TALKTYPE_ORANGE_1)
	end
	return true
end
action:aid(2490)
action:register()
