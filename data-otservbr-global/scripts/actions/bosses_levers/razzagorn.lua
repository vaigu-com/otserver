local config = {
	bossName = "Razzagorn",
	bossPosition = Position(33422, 32467, 14),

	timeToDefeat = 30 * 60,
	entranceTiles = {
		{ pos = Position(33386, 32455, 14), destination = Position(33419, 32467, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33387, 32455, 14), destination = Position(33419, 32467, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33388, 32455, 14), destination = Position(33419, 32467, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33389, 32455, 14), destination = Position(33419, 32467, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33390, 32455, 14), destination = Position(33419, 32467, 14), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33407, 32453, 14),
		to = Position(33439, 32481, 14),
	},
	exitTpDestination = Position(33319, 32318, 13),
}

local lever = BossLever(config)
lever:uid(1024)
lever:register()
