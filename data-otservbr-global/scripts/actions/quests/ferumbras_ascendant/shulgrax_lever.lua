local config = {
	bossName = "Shulgrax",
	bossPosition = Position(33485, 32786, 13),

	timeToDefeat = 30 * 60,
	entranceTiles = {
		{ pos = Position(33434, 32785, 13), destination = Position(33485, 32790, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33434, 32786, 13), destination = Position(33485, 32790, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33434, 32787, 13), destination = Position(33485, 32790, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33434, 32788, 13), destination = Position(33485, 32790, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33434, 32789, 13), destination = Position(33485, 32790, 13), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33474, 32775, 13),
		to = Position(33496, 32798, 13),
	},
	exitTpDestination = Position(33319, 32318, 13),
}

local lever = EncounterLever(config)
lever:uid(1028)
lever:register()
