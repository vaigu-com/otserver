local config = {
	bossName = "The Monster",
	encounterName = "The Monster",
	requiredLevel = 250,

	entranceTiles = {
		{ pos = { x = 33812, y = 32584, z = 12 }, destination = { x = 33831, y = 32591, z = 12 }, effect = CONST_ME_TELEPORT },
		{ pos = { x = 33811, y = 32584, z = 12 }, destination = { x = 33831, y = 32591, z = 12 }, effect = CONST_ME_TELEPORT },
		{ pos = { x = 33810, y = 32584, z = 12 }, destination = { x = 33831, y = 32591, z = 12 }, effect = CONST_ME_TELEPORT },
		{ pos = { x = 33809, y = 32584, z = 12 }, destination = { x = 33831, y = 32591, z = 12 }, effect = CONST_ME_TELEPORT },
		{ pos = { x = 33808, y = 32584, z = 12 }, destination = { x = 33831, y = 32591, z = 12 }, effect = CONST_ME_TELEPORT },
	},
	requiredPlayers = 5,
	zoneArea = {
		from = { x = 33828, y = 32584, z = 12 },
		to = { x = 33846, y = 32598, z = 12 },
	},
	exitTpPosition = { x = 33829, y = 32591, z = 12 },
	exitTpDestination = { x = 33810, y = 32587, z = 12 },
}

local encounterData = EncounterData(config)
encounterData:position({ x = 33813, y = 32584, z = 12 })
encounterData:register()

-- Entrance to lever room
SimpleTeleport({ x = 33792, y = 32581, z = 12 }, { x = 33806, y = 32584, z = 12 })
-- Exit from lever room
SimpleTeleport({ x = 33804, y = 32584, z = 12 }, { x = 33792, y = 32579, z = 12 })
