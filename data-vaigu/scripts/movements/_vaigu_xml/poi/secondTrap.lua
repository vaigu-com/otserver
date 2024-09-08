local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(Position(6128, 1838, 12))
	player:getPosition():sendMagicEffect(CONST_ME_EXPLOSIONAREA)
	return true
end

movement:type("stepin")
movement:uid(3303)
movement:register()
