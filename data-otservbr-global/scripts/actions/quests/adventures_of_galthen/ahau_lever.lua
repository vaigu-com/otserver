local config = {
	bossName = "Ahau",
	bossPosition = Position(34008, 31696, 10),
	ejectAfterSeconds = 60,
	entranceTiles = {
		{ pos = Position(34037, 31714, 10), destination = Position(34008, 31703, 10) },
		{ pos = Position(34036, 31714, 10), destination = Position(34008, 31703, 10) },
		{ pos = Position(34035, 31714, 10), destination = Position(34008, 31703, 10) },
		{ pos = Position(34034, 31714, 10), destination = Position(34008, 31703, 10) },
		{ pos = Position(34033, 31714, 10), destination = Position(34008, 31703, 10) },
	},
	zoneArea = {
		from = Position(33999, 31692, 10),
		to = Position(34018, 31705, 10),
	},
	exitTpDestination = Position(34036, 31717, 10),
	exitTpPosition = Position(34002, 31706, 10),
}

local lever = EncounterLever(config)
lever:position(Position(34038, 31714, 10))
lever:register()
