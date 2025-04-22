local config = {
<<<<<<< HEAD
	centerRoom = Position(33443, 31545, 13),
	newPosition = Position(33436, 31572, 13),
	exitPos = Position(32172, 31917, 8),
	x = 30,
	y = 30,
	summons = {
		{
			name = "Rewar The Bloody",
			pos = Position(33463, 31562, 13),
		},
		{
			name = "The Red Knight",
			pos = Position(33423, 31562, 13),
		},
		{
			name = "Magnor Mournbringer",
			pos = Position(33463, 31529, 13),
		},
		{
			name = "Nargol the Impaler",
			pos = Position(33423, 31529, 13),
		},
		{
			name = "King Zelos",
			pos = Position(33443, 31545, 13),
		},
	},
	timer = Storage.Quest.U12_20.GraveDanger.Bosses.KingZelos.Timer,
	room = Storage.Quest.U12_20.GraveDanger.Bosses.KingZelos.Room,
	fromPos = Position(33414, 31520, 13),
	toPos = Position(33474, 31574, 13),
}

local king_zelos = Action()

function king_zelos.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:doCheckBossRoom("King Zelos", config.fromPos, config.toPos) then
		player:sendCancelMessage("The room is already in use. Please wait.")
		return true
	end

	local spectators = Game.getSpectators(config.centerRoom, false, true, config.x, config.x, config.y, config.y)

	if player:getPosition() ~= Position(33485, 31546, 13) then
		player:sendCancelMessage("Sorry, not possible.")
		return true
	end

	if #spectators > 0 then
		player:say("The room is occupied by another team, please wait.", TALKTYPE_MONSTER_SAY, false, player)
		return true
	end

	for _, boss in pairs(config.summons) do
		Game.createMonster(boss.name, boss.pos, false, true)
	end

	for x = 33485, 33486 do
		for y = 31544, 31548 do
			local playerTile = Tile(Position(x, y, 13)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				playerTile:teleportTo(config.newPosition)
				playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				playerTile:setStorageValue(config.timer, os.time() + 20 * 3600)
				playerTile:setStorageValue(config.room, os.time() + 24 * 60)
				playerTile:say("You have 24 minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.", TALKTYPE_MONSTER_SAY, false, playerTile)
			end
		end
	end

	addEvent(clearForgotten, 24 * 60 * 1000, config.centerRoom, config.x, config.y, config.exitPos, config.room)

	return true
end

king_zelos:aid(14568)
king_zelos:register()
=======
	boss = {
		name = "King Zelos",
		position = Position(33443, 31545, 13),
	},
	requiredLevel = 250,
	playerPositions = {
		{ pos = Position(33485, 31546, 13), teleport = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31547, 13), teleport = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31548, 13), teleport = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31545, 13), teleport = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31544, 13), teleport = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31546, 13), teleport = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31547, 13), teleport = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31548, 13), teleport = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31545, 13), teleport = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31544, 13), teleport = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33433, 31535, 13),
		to = Position(33453, 31555, 13),
	},
	exit = Position(32172, 31918, 8),
}

local lever = BossLever(config)
lever:position(Position(33484, 31546, 13))
lever:register()
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
