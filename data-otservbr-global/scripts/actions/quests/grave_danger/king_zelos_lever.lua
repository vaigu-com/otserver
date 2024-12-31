local config = {
	bossName = "King Zelos",
	bossPosition = Position(33443, 31545, 13),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33485, 31546, 13), destination = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31547, 13), destination = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31548, 13), destination = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31545, 13), destination = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31544, 13), destination = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31546, 13), destination = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31547, 13), destination = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31548, 13), destination = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31545, 13), destination = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31544, 13), destination = Position(33443, 31554, 13), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33433, 31535, 13),
		to = Position(33453, 31555, 13),
	},
	exitTpDestination = Position(32172, 31918, 8),
}

local lever = EncounterLever(config)
lever:position({ x = 33484, y = 31546, z = 13 })
lever:register()
