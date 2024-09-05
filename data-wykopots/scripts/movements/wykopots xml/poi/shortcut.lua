local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.PitsOfInferno.OneThrone) <= 0 or player:getLevel() < 80 then
		player:teleportTo(fromPosition)
		toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	local destination = Position(6140, 1796, 13)
	player:teleportTo(destination)
	toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
movement:type("stepin")
movement:aid(2066)
movement:register()
