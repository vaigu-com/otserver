local config = {
	bossName = "The Time Guardian",
	bossPosition = Position(32977, 31662, 14),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33010, 31660, 14), destination = Position(32977, 31667, 14) },
		{ pos = Position(33010, 31661, 14), destination = Position(32977, 31667, 14) },
		{ pos = Position(33010, 31662, 14), destination = Position(32977, 31667, 14) },
		{ pos = Position(33010, 31663, 14), destination = Position(32977, 31667, 14) },
		{ pos = Position(33010, 31664, 14), destination = Position(32977, 31667, 14) },
	},
	monsters = {
		{ name = "The Freezing Time Guardian", pos = Position(32975, 31664, 13) },
		{ name = "The Blazing Time Guardian", pos = Position(32980, 31664, 13) },
	},
	zoneArea = {
		from = Position(32967, 31654, 14),
		to = Position(32989, 31677, 14),
	},
	exitTpDestination = Position(32870, 32724, 14),
}

local lever = EncounterData(config)
lever:position(Position(33010, 31659, 14))
lever:register()
