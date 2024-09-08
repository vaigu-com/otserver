local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.OskareKXddd.Bilety) == 5 then
		if item.uid == 11042 then
			toPosition.x = 5639
			toPosition.y = 1423
			toPosition.z = 7
		elseif item.uid == 11043 then
			toPosition.x = 5749
			toPosition.y = 1377
			toPosition.z = 7
		end
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(toPosition, false)
		toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	else
		doCreatureSay(player, "To nie twoja lodka!", TALKTYPE_ORANGE_1)
	end
	return true
end

action:aid(11042)
action:register()
