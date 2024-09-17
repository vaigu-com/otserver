local config = {
	bossName = "Lokathmor",
	bossPosition = Position(32751, 32689, 10),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(32721, 32749, 10), destination = Position(32751, 32685, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32722, 32749, 10), destination = Position(32751, 32685, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32723, 32749, 10), destination = Position(32751, 32685, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32724, 32749, 10), destination = Position(32751, 32685, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32725, 32749, 10), destination = Position(32751, 32685, 10), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(32742, 32681, 10),
		to = Position(32758, 32696, 10),
	},
	exitTpDestination = Position(32466, 32654, 12),
}

local lever = EncounterLever(config)
lever:position({ x = 32720, y = 32749, z = 10 })
lever:register()
