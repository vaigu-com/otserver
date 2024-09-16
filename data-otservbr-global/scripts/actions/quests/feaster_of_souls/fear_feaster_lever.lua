local config = {
	bossName = "The Fear Feaster",
	bossPosition = Position(33711, 31469, 14),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33734, 31471, 14), destination = Position(33711, 31474, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33735, 31471, 14), destination = Position(33711, 31474, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33736, 31471, 14), destination = Position(33711, 31474, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33737, 31471, 14), destination = Position(33711, 31474, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33738, 31471, 14), destination = Position(33711, 31474, 14), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33705, 31463, 14),
		to = Position(33719, 31477, 14),
	},
	exitTpDestination = Position(33609, 31499, 10),
}

local lever = EncounterLever(config)
lever:position({ x = 33733, y = 31471, z = 14 })
lever:register()
