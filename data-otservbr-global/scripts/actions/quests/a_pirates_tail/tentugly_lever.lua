local config = {
	bossName = "Tentugly's Head",
	bossPosition = Position(33722, 31182, 7),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33792, 31391, 6), destination = Position(33722, 31186, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33793, 31391, 6), destination = Position(33722, 31186, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33794, 31391, 6), destination = Position(33722, 31186, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33795, 31391, 6), destination = Position(33722, 31186, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33796, 31391, 6), destination = Position(33722, 31186, 7), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33705, 31176, 6),
		to = Position(33736, 31190, 7),
	},
	exitTpDestination = Position(33799, 31356, 7),
}

local lever = EncounterData(config)
lever:position(Position(33791, 31391, 6))
lever:register()
