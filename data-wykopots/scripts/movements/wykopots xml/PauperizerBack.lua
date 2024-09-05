local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local destination = Position(6438, 916, 4)
	local destination2 = Position(6443, 914, 1)
	if player:getStorageValue(Storage.PauperizerKill) == 1 then
		player:teleportTo(destination) --{x = 6438, y = 916, z = 4}
		destination:sendMagicEffect(CONST_ME_PURPLEENERGY)
	else
		player:teleportTo(destination2)
		destination2:sendMagicEffect(CONST_ME_PURPLEENERGY)
	end
	return true
end

movement:type("stepin")
movement:aid(2251)
movement:register()
