local config = {
	bossName = "Ragiaz",
	bossPosition = Position(33481, 32334, 13),

	timeToDefeat = 30 * 60,
	entranceTiles = {
		{ pos = Position(33456, 32356, 13), destination = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33457, 32356, 13), destination = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33458, 32356, 13), destination = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33459, 32356, 13), destination = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33460, 32356, 13), destination = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
	},
	monsters = {
		{ name = "Death Dragon", pos = Position(33476, 32331, 13) },
		{ name = "Death Dragon", pos = Position(33476, 32340, 13) },
		{ name = "Death Dragon", pos = Position(33487, 32340, 13) },
		{ name = "Death Dragon", pos = Position(33488, 32331, 13) },
	},
	zoneArea = {
		from = Position(33468, 32319, 13),
		to = Position(33495, 32347, 13),
	},
	exitTpDestination = Position(33319, 32318, 13),
}

local lever = EncounterLever(config)
lever:uid(1023)
lever:register()
