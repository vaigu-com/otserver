local portal = MoveEvent()

function portal.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()

	if not player then
		return false
	end

	local pos = Position(fromPosition)
	pos = pos:Moved(-24, 0, 0)
	if Tile(pos) and Tile(pos):getGround() then
		player:teleportTo(pos, true)
	else
		pos = pos:Moved(120, 0, 0)
		player:teleportTo(pos, true)
	end

	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_FAILURE, "You cannot use this portal.") -- trolleg
	return true
end
portal:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms)
portal:type("stepin")
portal:register()
