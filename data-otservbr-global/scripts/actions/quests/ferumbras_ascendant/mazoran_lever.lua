local config = {
	bossName = "Mazoran",
	bossPosition = Position(33584, 32689, 14),

	timeToDefeat = 30 * 60,
	entranceTiles = {
		{ pos = Position(33593, 32644, 14), destination = Position(33585, 32693, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33593, 32645, 14), destination = Position(33585, 32693, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33593, 32646, 14), destination = Position(33585, 32693, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33593, 32647, 14), destination = Position(33585, 32693, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33593, 32648, 14), destination = Position(33585, 32693, 14), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33570, 32677, 14),
		to = Position(33597, 32700, 14),
	},
	exitTpDestination = Position(33319, 32318, 13),
}

local lever = EncounterLever(config)
lever:uid(1025)
lever:register()
