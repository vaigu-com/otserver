local config = {
	bossName = "Grand Master Oberon",
	bossPosition = Position(33364, 31317, 9),
	entranceTiles = {
		{ pos = Position(33362, 31344, 9), destination = Position(33364, 31322, 9) },
		{ pos = Position(33363, 31344, 9), destination = Position(33364, 31322, 9) },
		{ pos = Position(33364, 31344, 9), destination = Position(33364, 31322, 9) },
		{ pos = Position(33365, 31344, 9), destination = Position(33364, 31322, 9) },
		{ pos = Position(33366, 31344, 9), destination = Position(33364, 31322, 9) },
	},
	zoneArea = {
		from = Position(33357, 31312, 9),
		to = Position(33371, 31324, 9),
	},
	exitTpDestination = Position(33364, 31341, 9),
}

local lever = EncounterLever(config)
lever:aid(57605)
lever:register()
