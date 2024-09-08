local enterPosition = { x = 6848, y = 1043, z = 4 } --{x = 6848, y = 1043, z = 4}

local shortcut = MoveEvent()

function shortcut.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.LiquidBlackQuest.Visitor) >= 4 then
		player:setStorageValue(Storage.LiquidBlackQuest.Visitor, 5)
		player:setStorageValue(Storage.Finished.LiquidBlack, 1)
		player:teleportTo(enterPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendCancelMessage("Intruz nie zostanie wpuszczony.")
	end
	return true
end

shortcut:aid(57746)
shortcut:register()
