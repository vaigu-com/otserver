local config = {
	bossName = "Goshnar's Spite",
	bossPosition = Position(33743, 31632, 14),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33774, 31634, 14), destination = Position(33742, 31639, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33775, 31634, 14), destination = Position(33742, 31639, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33776, 31634, 14), destination = Position(33742, 31639, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33777, 31634, 14), destination = Position(33742, 31639, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33778, 31634, 14), destination = Position(33742, 31639, 14), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33734, 31624, 14),
		to = Position(33751, 31640, 14),
	},
	exitTpDestination = Position(33621, 31427, 10),
}

local lever = EncounterData(config)
lever:position({ x = 33773, y = 31634, z = 14 })
lever:register()
