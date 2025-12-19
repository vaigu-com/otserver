Storage.KroazurRoomEnterTeleport = {}

local room = {
	bossName = "Kroazur",
	bossSpawnPosition = Position(6641, 1072, 11),
	roomCenterPos = Position(6642, 1077, 11),
	playerSpawnPosition = Position(6641, 1083, 11),
	exitPos = Position(6652, 1091, 11),
	rangeX = 11,
	rangeY = 11,
	timeToDefeatMinutes = 10,
}

local kroazurRoom = MoveEvent()

function kroazurRoom.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	if not player:canFightBoss(room.bossName) then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("You have to wait to challenge this enemy again!", TALKTYPE_MONSTER_SAY)
		return true
	end

	if roomIsOccupied(room.bossSpawnPosition, false, room.rangeX, room.rangeY) then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("Someone is fighting against the boss! You need wait awhile.", TALKTYPE_MONSTER_SAY)
		return true
	end

	clearRoom(room.bossSpawnPosition, room.rangeX, room.rangeY)
	local monster = Game.createMonster(room.bossName, room.bossSpawnPosition, true, true)
	if not monster then
		return true
	end

	position:sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(room.playerSpawnPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:say("You have ten minutes to kill and loot this boss, else you will lose that chance and will be kicked out.", TALKTYPE_MONSTER_SAY)
	addEvent(clearBossRoom, 60 * room.timeToDefeatMinutes * 1000, player.uid, room.roomCenterPos, false, room.rangeX, room.rangeY, room.exitPos)
	player:setBossCooldown(room.bossName, os.timeToDefeatMinutes() + 4 * 3600)
	return true
end

kroazurRoom:type("stepin")
kroazurRoom:key(Storage.KroazurRoomEnterTeleport)
kroazurRoom:register()
