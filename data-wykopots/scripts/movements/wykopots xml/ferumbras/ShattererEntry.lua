local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	if player:getStorageValue(Storage.Ferumbras.ShattererEntry) >= 1 then
		player:teleportTo(Position(7186, 1742, 15)) --{x = 7186, y = 1742, z = 15}
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition) --{x = 7185, y = 1800, z = 13}
		player:sendCancelMessage("Musisz pokonac The Shatterer aby uzyc teleportu.")
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end
movement:type("stepin")
movement:aid(51991)
movement:register()
