local config = {
	bossName = "Faceless Bane",
	bossPosition = Position(33617, 32561, 13),
	requiredLevel = 250,
	timeToDefeat = 15 * 60,
	entranceTiles = {
		{ pos = Position(33638, 32562, 13), destination = Position(33617, 32567, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33639, 32562, 13), destination = Position(33617, 32567, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33640, 32562, 13), destination = Position(33617, 32567, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33641, 32562, 13), destination = Position(33617, 32567, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33642, 32562, 13), destination = Position(33617, 32567, 13), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33607, 32553, 13),
		to = Position(33627, 32570, 13),
	},
	exitTpDestination = Position(33618, 32523, 15),
}

local lever = BossLever(config)
lever:uid(1039)
lever:register()
