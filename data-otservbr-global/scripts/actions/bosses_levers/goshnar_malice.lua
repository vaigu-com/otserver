local config = {
	bossName = "Goshnar's Malice",
	bossPosition = Position(33710, 31599, 14),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33679, 31599, 14), destination = Position(33710, 31605, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33680, 31599, 14), destination = Position(33710, 31605, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33681, 31599, 14), destination = Position(33710, 31605, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33682, 31599, 14), destination = Position(33710, 31605, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33683, 31599, 14), destination = Position(33710, 31605, 14), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33699, 31590, 14),
		to = Position(33718, 31607, 14),
	},
	exitTpDestination = Position(33621, 31427, 10),
}

local lever = BossLever(config)
lever:position({ x = 33678, y = 31599, z = 14 })
lever:register()
