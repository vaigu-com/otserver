local function hasTouchedOneThrone(player)
	if player:getStorageValueByKey(Storage.PitsOfInferno.OneThrone) <= 0 then
		return false
	end

	return true
end

local config = { position = Position(6517, 1685, 10), destination = { x = 33168, y = 31683, z = 15 } }

local entrance = MoveEvent()
function entrance.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if hasTouchedOneThrone(player) and player:getLevel() >= 100 and player:getStorageValueByKey(Storage.TheInquisition.Questline) >= 20 then
		local destination = Position(config.destination.x, config.destination.y, config.destination.z)
		player:teleportTo(destination)
		position:sendMagicEffect(CONST_ME_TELEPORT)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	player:teleportTo(fromPosition, true)
	position:sendMagicEffect(CONST_ME_TELEPORT)
	fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
entrance:type("stepin")
entrance:position(config.position)
entrance:register()
