local config = {
	bossName = "Megasylvan Yselda",
	bossPosition = Position(32619, 32493, 12),
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(32578, 32500, 12), destination = Position(32619, 32498, 12) },
		{ pos = Position(32578, 32501, 12), destination = Position(32619, 32498, 12) },
		{ pos = Position(32578, 32502, 12), destination = Position(32619, 32498, 12) },
		{ pos = Position(32578, 32503, 12), destination = Position(32619, 32498, 12) },
		{ pos = Position(32578, 32504, 12), destination = Position(32619, 32498, 12) },
	},
	zoneArea = {
		from = Position(32601, 32486, 12),
		to = Position(32633, 32509, 12),
	},
	exitTpDestination = Position(32580, 32480, 12),
}

local lever = EncounterLever(config)
lever:position({ x = 32578, y = 32499, z = 12 })
lever:register()
