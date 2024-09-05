local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.PitsOfInferno.OneThrone) <= 0 or player:getLevel() < 100 or player:getStorageValue(Storage.TheInquisition.Questline) < 20 then
		--if player:getLevel() < 100 or player:getStorageValue(Storage.TheInquisition.Questline) < 20 then -- test
		player:teleportTo(fromPosition)
		toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	local destination = Position(6774, 1779, 14)
	player:teleportTo(destination)
	toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

movement:type("stepin")
movement:uid(9014)
movement:register()
