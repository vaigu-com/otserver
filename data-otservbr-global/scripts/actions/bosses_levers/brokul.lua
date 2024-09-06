local config = {
	bossName = "Brokul",
	bossPosition = Position(33483, 31434, 15),
	requiredLevel = 150,
	entranceTiles = {
		{ pos = Position(33522, 31465, 15), destination = Position(33483, 31445, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33520, 31465, 15), destination = Position(33483, 31445, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33521, 31465, 15), destination = Position(33483, 31445, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33523, 31465, 15), destination = Position(33483, 31445, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33524, 31465, 15), destination = Position(33483, 31445, 15), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33469, 31430, 15),
		to = Position(33497, 31453, 15),
	},
	exitTpDestination = Position(33522, 31468, 15),
}

local lever = BossLever(config)
lever:aid(34000)
lever:register()
