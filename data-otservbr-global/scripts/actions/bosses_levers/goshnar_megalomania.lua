local config = {
	bossName = "Goshnar's Megalomania",
	bossPosition = Position(33710, 31634, 14),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(33676, 31634, 14), destination = Position(33710, 31639, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33677, 31634, 14), destination = Position(33710, 31639, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33678, 31634, 14), destination = Position(33710, 31639, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33679, 31634, 14), destination = Position(33710, 31639, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33680, 31634, 14), destination = Position(33710, 31639, 14), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33701, 31626, 14),
		to = Position(33719, 31642, 14),
	},
	exitTpDestination = Position(33621, 31427, 10),
}

local lever = BossLever(config)
lever:position({ x = 33675, y = 31634, z = 14 })
lever:register()
