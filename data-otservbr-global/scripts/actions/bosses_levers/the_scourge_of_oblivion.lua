local config = {
	bossName = "The Scourge of Oblivion",
	bossPosition = Position(32726, 32727, 11),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(32676, 32743, 11), destination = Position(32726, 32733, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(32676, 32744, 11), destination = Position(32726, 32733, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(32676, 32745, 11), destination = Position(32726, 32733, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(32676, 32741, 11), destination = Position(32726, 32733, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(32676, 32742, 11), destination = Position(32726, 32733, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(32678, 32741, 11), destination = Position(32726, 32733, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(32678, 32742, 11), destination = Position(32726, 32733, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(32678, 32743, 11), destination = Position(32726, 32733, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(32678, 32744, 11), destination = Position(32726, 32733, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(32678, 32745, 11), destination = Position(32726, 32733, 11), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(32712, 32723, 11),
		to = Position(32738, 32748, 11),
	},
	exitTpDestination = Position(32480, 32599, 15),
}

local lever = BossLever(config)
lever:position({ x = 32675, y = 32743, z = 11 })
lever:register()
