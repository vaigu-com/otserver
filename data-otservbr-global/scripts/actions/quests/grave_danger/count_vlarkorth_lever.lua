local config = {
	bossName = "Count Vlarkorth",
	bossPosition = Position(33456, 31434, 13),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33455, 31413, 13), destination = Position(33454, 31445, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33456, 31413, 13), destination = Position(33454, 31445, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33457, 31413, 13), destination = Position(33454, 31445, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33458, 31413, 13), destination = Position(33454, 31445, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33459, 31413, 13), destination = Position(33454, 31445, 13), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33448, 31428, 13),
		to = Position(33464, 31446, 13),
	},
	exitTpDestination = Position(33195, 31690, 8),
}

local lever = EncounterData(config)
lever:position({ x = 33454, y = 31413, z = 13 })
lever:register()
