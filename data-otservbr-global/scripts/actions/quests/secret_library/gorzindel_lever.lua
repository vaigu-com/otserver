local config = {
	bossName = "Gorzindel",
	bossPosition = Position(32687, 32715, 10),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(32747, 32749, 10), destination = Position(32686, 32721, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32748, 32749, 10), destination = Position(32686, 32721, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32749, 32749, 10), destination = Position(32686, 32721, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32750, 32749, 10), destination = Position(32686, 32721, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32751, 32749, 10), destination = Position(32686, 32721, 10), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(32680, 32711, 10),
		to = Position(32695, 32726, 10),
	},
	exitTpDestination = Position(32660, 32734, 12),
}

local lever = EncounterLever(config)
lever:position({ x = 32746, y = 32749, z = 10 })
lever:register()
