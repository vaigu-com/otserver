local config = {
	bossName = "Mazzinor",
	bossPosition = Position(32725, 32719, 10),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(32721, 32773, 10), destination = Position(32726, 32726, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32722, 32773, 10), destination = Position(32726, 32726, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32723, 32773, 10), destination = Position(32726, 32726, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32724, 32773, 10), destination = Position(32726, 32726, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32725, 32773, 10), destination = Position(32726, 32726, 10), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(32716, 32713, 10),
		to = Position(32732, 32728, 10),
	},
	exitTpDestination = Position(32616, 32531, 13),
}

local lever = BossLever(config)
lever:position({ x = 32720, y = 32773, z = 10 })
lever:register()
