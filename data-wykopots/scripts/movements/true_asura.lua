local enterPosition = { x = 6634, y = 975, z = 9 }

local trueAsuraEntry = MoveEvent()

function trueAsuraEntry.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.FlamingOrchidKilled) >= 1 then
		player:teleportTo(enterPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendCancelMessage("Intruz nie zostanie wpuszczony.")
	end
	return true
end

trueAsuraEntry:aid(2492)
trueAsuraEntry:register()

local backPosition = { x = 6616, y = 997, z = 3 }

local trueAsuraBack = MoveEvent()

function trueAsuraBack.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	player:teleportTo(backPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

trueAsuraBack:aid(2493)
trueAsuraBack:register()
