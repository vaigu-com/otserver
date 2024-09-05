local config = {
	[24900] = {
		timer = Storage.KroazurTimer,
		range = 20,
		newPos = Position(6923, 1260, 9), --{x = 6923, y = 1260, z = 9}
		bossName = 'Kroazur',
		bossPos = Position(6930, 1263, 9) --{x = 6930, y = 1263, z = 9}
	}
}

local kroazurEntrance = MoveEvent()

function kroazurEntrance.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local teleport = config[item.actionid]
	if not teleport then
		return
	end

	if player:isPzLocked() then
		player:sendTextMessage(MESSAGE_FAILURE, "You can not enter here after attacking another player.")
        player:teleportTo(fromPosition, true)
		return true
	end
	
	if player:getStorageValue(teleport.timer) > os.time() then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say('You have to wait to challenge this enemy again!', TALKTYPE_MONSTER_SAY)
		return true
	end

	if roomIsOccupied(teleport.bossPos, teleport.range, teleport.range) then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say('Someone is fighting against the boss! You need wait awhile.', TALKTYPE_MONSTER_SAY)
		return true
	end
	clearRoom(teleport.bossPos, teleport.range, teleport.range, fromPosition)
	local monster = Game.createMonster(teleport.bossName, teleport.bossPos, true, true)
	if not monster then
		return true
	end

	position:sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(teleport.newPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:say(
		'You have ten minutes to kill and loot this boss. \z
		Otherwise you will lose that chance and will be kicked out.', TALKTYPE_MONSTER_SAY)
	addEvent(clearBossRoom, 60 * 10 * 1000, player.uid, monster.uid, teleport.bossPos, teleport.range, teleport.range, fromPosition)
	player:setStorageValue(teleport.timer, os.time() + 4 * 3600)
	return true
end

kroazurEntrance:type("stepin")
kroazurEntrance:aid(24900)
kroazurEntrance:register()