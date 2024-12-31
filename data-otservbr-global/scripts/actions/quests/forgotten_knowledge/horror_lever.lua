local eggPos = Position(32269, 31084, 14)
local config = {
	boss = {
		name = "Melting Frozen Horror",
		createFunction = function()
			Tile(eggPos):getTopCreature():setHealth(1)
			return Game.createMonster("solid frozen horror", Position(32269, 31091, 14), true, true)
		end,
	},
	timeToDefeat = 15 * 60, -- In seconds
	requiredLevel = 250,
	entranceTiles = {
		{ pos = Position(32302, 31088, 14), destination = Position(32271, 31097, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32302, 31089, 14), destination = Position(32271, 31097, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32302, 31090, 14), destination = Position(32271, 31097, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32302, 31091, 14), destination = Position(32271, 31097, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32302, 31092, 14), destination = Position(32271, 31097, 14), effect = CONST_ME_TELEPORT },
	},
	monsters = {
		{ name = "icicle", pos = Position(32266, 31084, 14) },
		{ name = "icicle", pos = Position(32272, 31084, 14) },
		{ name = "dragon egg", pos = eggPos },
		{ name = "melting frozen horror", pos = Position(32267, 31071, 14) },
	},
	zoneArea = {
		from = Position(32257, 31080, 14),
		to = Position(32280, 31102, 14),
	},
	exitTpDestination = Position(32271, 31097, 14),
}

local lever = EncounterLever(config)
lever:position(Position(32302, 31087, 14))
lever:register()
