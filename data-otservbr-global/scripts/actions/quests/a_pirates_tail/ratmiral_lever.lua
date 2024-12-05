local config = {
	bossName = "Ratmiral Blackwhiskers",
	bossPosition = Position(33904, 31351, 14),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33893, 31388, 15), destination = Position(33904, 31356, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33894, 31388, 15), destination = Position(33904, 31356, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33895, 31388, 15), destination = Position(33904, 31356, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33896, 31388, 15), destination = Position(33904, 31356, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33897, 31388, 15), destination = Position(33904, 31356, 14), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33888, 31344, 14),
		to = Position(33920, 31376, 15),
	},
	exitTpDestination = Position(33891, 31197, 7),
}

local lever = EncounterData(config)
lever:position(Position(33892, 31388, 15))
lever:register()
