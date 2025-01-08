local surface = Position(6777, 2548, 4)

local shortcut = MoveEvent()
function shortcut.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValueByKey(Storage.LiquidBlack.Visitor) >= 4 then
		player:setStorageValueByKey(Storage.LiquidBlack.Visitor, 5)
		player:setStorageValueByKey(Storage.Finished.LiquidBlack, MISSION_FINISHED)
		player:teleportTo(surface)
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

local fiehonja = Position(6711, 2512, 14)

local quickAccess = MoveEvent()
function quickAccess.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValueByKey(Storage.LiquidBlack.Visitor) >= 5 then
		player:teleportTo(fiehonja)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendCancelMessage("Nic tu po tobie...")
	end
	return true
end
quickAccess:aid(57747)
quickAccess:register()
