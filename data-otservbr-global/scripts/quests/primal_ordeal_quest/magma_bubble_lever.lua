local config = {
	bossName = "Magma Bubble",
	encounterName = "Magma Bubble",
	requiredLevel = 500,
	entranceTiles = {
		{ pos = Position(33669, 32926, 15), destination = Position(33655, 32917, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33669, 32927, 15), destination = Position(33655, 32917, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33669, 32928, 15), destination = Position(33655, 32917, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33669, 32929, 15), destination = Position(33655, 32917, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33669, 32930, 15), destination = Position(33655, 32917, 15), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(33630, 32887, 15),
		to = Position(33672, 32921, 15),
	},
	exitTpDestination = Position(33659, 32897, 14),
}

local lever = EncounterLever(config)
lever:position(Position(33669, 32925, 15))
lever:register()

local zone = lever:getZone()
zone:addArea(Position(33633, 32915, 15), Position(33649, 32928, 15))
