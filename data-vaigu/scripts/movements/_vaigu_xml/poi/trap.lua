local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local newPos = toPosition:Moved(0, 0, 1)
	player:teleportTo(newPos)
	newPos:sendMagicEffect(CONST_ME_FIREATTACK)
	return true
end

movement:type("stepin")
movement:aid(7799)
movement:register()
