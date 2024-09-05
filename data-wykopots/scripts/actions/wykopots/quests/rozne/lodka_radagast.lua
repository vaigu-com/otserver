local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isPlayerPzLocked(player) then
		doCreatureSay(player, "Nie mozesz tedy uciec!", TALKTYPE_ORANGE_1)
		return false
	end

	if player:getStorageValue(Storage.SciezkaDruida.SezonNaJelenie) >= 3 then
		if item.uid == 11044 then
			toPosition.x = 6123
			toPosition.y = 1781
			toPosition.z = 7
		elseif item.uid == 11045 then
			toPosition.x = 6108
			toPosition.y = 1687
			toPosition.z = 7
		end
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(toPosition, false)
		toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	else
		doCreatureSay(player, "Nie mozesz nia plywac!", TALKTYPE_ORANGE_1)
	end
	return true
end
action:aid(11044)
action:register()
