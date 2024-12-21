local enterPosition = { x = 6848, y = 1043, z = 4 } --{x = 6848, y = 1043, z = 4}

local shortcut = MoveEvent()

function shortcut.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.LiquidBlack.Visitor) >= 4 then
		player:setStorageValue(Storage.LiquidBlack.Visitor, 5)
		player:setStorageValue(Storage.Finished.LiquidBlack, MISSION_FINISHED)
		player:teleportTo(enterPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendCancelMessage("Intruder will not be let it.")
	end
	return true
end

shortcut:aid(57746)
shortcut:register()
