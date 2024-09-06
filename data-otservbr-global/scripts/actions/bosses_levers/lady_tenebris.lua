local config = {
	bossName = "Lady Tenebris",
	bossPosition = Position(32912, 31599, 14),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(32902, 31623, 14), destination = Position(32911, 31603, 14) },
		{ pos = Position(32902, 31624, 14), destination = Position(32911, 31603, 14) },
		{ pos = Position(32902, 31625, 14), destination = Position(32911, 31603, 14) },
		{ pos = Position(32902, 31626, 14), destination = Position(32911, 31603, 14) },
		{ pos = Position(32902, 31627, 14), destination = Position(32911, 31603, 14) },
	},
	monsters = {
		{ name = "shadow tentacle", pos = Position(32910, 31599, 14) },
		{ name = "shadow tentacle", pos = Position(32912, 31597, 14) },
		{ name = "shadow tentacle", pos = Position(32914, 31599, 14) },
	},
	zoneArea = {
		from = Position(32899, 31587, 14),
		to = Position(32923, 31612, 14),
	},
	exitTpDestination = Position(32902, 31629, 14),
}

local lever = BossLever(config)
lever:position(Position(32902, 31622, 14))
lever:register()
