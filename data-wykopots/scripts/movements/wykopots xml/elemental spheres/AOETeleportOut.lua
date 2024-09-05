local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(Position(6227, 1014, 10)) --{x = 6227, y = 1014, z = 10}
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	for i = 10005, 10008 do
		player:setStorageValue(i, -1)
	end
	return true
end

movement:type("stepin")
movement:aid(9029)
movement:register()
