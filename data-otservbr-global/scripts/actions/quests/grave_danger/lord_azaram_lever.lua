local config = {
	bossName = "Lord Azaram",
	bossPosition = Position(33424, 31473, 13),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33422, 31493, 13), destination = Position(33423, 31465, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33423, 31493, 13), destination = Position(33423, 31465, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33424, 31493, 13), destination = Position(33423, 31465, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33425, 31493, 13), destination = Position(33423, 31465, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33426, 31493, 13), destination = Position(33423, 31465, 13), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33416, 31463, 13),
		to = Position(33432, 31481, 13),
	},
	exitTpDestination = Position(32192, 31819, 8),
}

local lever = EncounterData(config)
lever:position({ x = 33421, y = 31493, z = 13 })
lever:register()
