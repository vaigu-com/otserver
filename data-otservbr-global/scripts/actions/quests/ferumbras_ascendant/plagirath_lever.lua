local config = {
	bossName = "Plagirath",
	bossPosition = Position(33172, 31501, 13),

	timeToDefeat = 30 * 60,
	entranceTiles = {
		{ pos = Position(33229, 31500, 13), destination = Position(33173, 31504, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33229, 31501, 13), destination = Position(33173, 31504, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33229, 31502, 13), destination = Position(33173, 31504, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33229, 31503, 13), destination = Position(33173, 31504, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33229, 31504, 13), destination = Position(33173, 31504, 13), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33159, 31488, 13),
		to = Position(33190, 31515, 13),
	},
	exitTpDestination = Position(33319, 32318, 13),
}

local lever = EncounterLever(config)
lever:uid(1022)
lever:register()
