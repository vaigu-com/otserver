local config = {
	bossName = "Duke Krule",
	bossPosition = Position(33456, 31473, 13),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33455, 31493, 13), destination = Position(33455, 31464, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33456, 31493, 13), destination = Position(33455, 31464, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33457, 31493, 13), destination = Position(33455, 31464, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33458, 31493, 13), destination = Position(33455, 31464, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33459, 31493, 13), destination = Position(33455, 31464, 13), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33447, 31464, 13),
		to = Position(33464, 31481, 13),
	},
	exitTpDestination = Position(32347, 32167, 12),
}

local lever = EncounterLever(config)
lever:position({ x = 33454, y = 31493, z = 13 })
lever:register()
