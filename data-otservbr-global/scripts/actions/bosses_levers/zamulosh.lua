local config = {
	bossName = "Zamulosh",
	bossPosition = Position(33643, 32756, 11),

	timeToDefeat = 30 * 60,
	entranceTiles = {
		{ pos = Position(33680, 32741, 11), destination = Position(33644, 32760, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(33680, 32742, 11), destination = Position(33644, 32760, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(33680, 32743, 11), destination = Position(33644, 32760, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(33680, 32744, 11), destination = Position(33644, 32760, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(33680, 32745, 11), destination = Position(33644, 32760, 11), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33632, 32747, 11),
		to = Position(33654, 32765, 11),
	},
	exitTpDestination = Position(33319, 32318, 13),
}

local zamuloshSummons = {
	Position(33642, 32756, 11),
	Position(33642, 32756, 11),
	Position(33642, 32756, 11),
	Position(33644, 32756, 11),
	Position(33644, 32756, 11),
	Position(33644, 32756, 11),
}

local lever = BossLever(config)
lever:uid(1026)
lever:register()
