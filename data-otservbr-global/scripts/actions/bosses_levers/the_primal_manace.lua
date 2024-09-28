local config = {
	bossName = "The Primal Menace",
	bossPosition = Position(33558, 32759, 15),
	requiredLevel = 500,
	entranceTiles = {
		{ pos = Position(33548, 32752, 14), destination = Position(33565, 32758, 15) },
		{ pos = Position(33549, 32752, 14), destination = Position(33565, 32758, 15) },
		{ pos = Position(33550, 32752, 14), destination = Position(33565, 32758, 15) },
		{ pos = Position(33551, 32752, 14), destination = Position(33565, 32758, 15) },
		{ pos = Position(33552, 32752, 14), destination = Position(33565, 32758, 15) },
	},
	zoneArea = {
		from = Position(33547, 32749, 15),
		to = Position(33570, 32769, 15),
	},
	disableCooldown = true,
	exitTpDestination = Position(33520, 32871, 15),
}

local lever = BossLever(config)
lever:position(Position(33547, 32752, 14))
lever:register()
