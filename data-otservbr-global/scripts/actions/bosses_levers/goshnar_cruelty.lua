local config = {
	bossName = "Goshnar's Cruelty",
	bossPosition = Position(33856, 31866, 7),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33854, 31854, 6), destination = Position(33856, 31872, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33855, 31854, 6), destination = Position(33856, 31872, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33856, 31854, 6), destination = Position(33856, 31872, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33857, 31854, 6), destination = Position(33856, 31872, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33858, 31854, 6), destination = Position(33856, 31872, 7), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33847, 31858, 7),
		to = Position(33864, 31874, 7),
	},
	exitTpDestination = Position(33621, 31427, 10),
}

local lever = BossLever(config)
lever:position({ x = 33853, y = 31854, z = 6 })
lever:register()
