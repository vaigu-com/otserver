local config = {
	bossName = "The Dread Maiden",
	bossPosition = Position(33712, 31503, 14),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33739, 31506, 14), destination = Position(33712, 31509, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33740, 31506, 14), destination = Position(33712, 31509, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33741, 31506, 14), destination = Position(33712, 31509, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33742, 31506, 14), destination = Position(33712, 31509, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33743, 31506, 14), destination = Position(33712, 31509, 14), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33703, 31494, 14),
		to = Position(33721, 31512, 14),
	},
	exitTpDestination = Position(33557, 31524, 10),
}

local lever = EncounterLever(config)
lever:position({ x = 33738, y = 31506, z = 14 })
lever:register()
