local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local destination = Position(7107, 1657, 13)
	if player:getStorageValue(Storage.Ferumbras.EssencesBringed) >= 1 and player:getLevel() >= 150 then
		player:teleportTo(destination) --{x = 7107, y = 1657, z = 13}
		destination:sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition) --{x = 6730, y = 1281, z = 8}
		player:sendCancelMessage("Musisz oddac 30 demonic essence Mazariusowi, lub nie posiadasz odpowiedniego poziomu.")
	end
	return true
end
movement:type("stepin")
movement:aid(45790)
movement:register()
