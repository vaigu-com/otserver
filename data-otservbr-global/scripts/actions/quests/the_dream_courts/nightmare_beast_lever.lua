local config = {
	bossName = "The Nightmare Beast",
	bossPosition = Position(32208, 32046, 15),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(32212, 32070, 15), destination = Position(32208, 32052, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32210, 32070, 15), destination = Position(32208, 32052, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32211, 32070, 15), destination = Position(32208, 32052, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32213, 32070, 15), destination = Position(32208, 32052, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32214, 32070, 15), destination = Position(32208, 32052, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32210, 32071, 15), destination = Position(32208, 32052, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32211, 32071, 15), destination = Position(32208, 32052, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32212, 32071, 15), destination = Position(32208, 32052, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32213, 32071, 15), destination = Position(32208, 32052, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32214, 32071, 15), destination = Position(32208, 32052, 15), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(32195, 32035, 15),
		to = Position(32220, 32055, 15),
	},
	exitTpDestination = Position(32211, 32084, 15),
}

local lever = EncounterLever(config)
lever:position({ x = 32212, y = 32069, z = 15 })
lever:register()
