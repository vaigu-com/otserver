local config = {
	bossName = "Anomaly",
	bossPosition = Position(32271, 31249, 14),
	entranceTiles = {
		{ pos = Position(32245, 31245, 14), destination = Position(32271, 31257, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32245, 31246, 14), destination = Position(32271, 31257, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32245, 31247, 14), destination = Position(32271, 31257, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32245, 31248, 14), destination = Position(32271, 31257, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32245, 31249, 14), destination = Position(32271, 31257, 14), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(32258, 31237, 14),
		to = Position(32284, 31262, 14),
	},
	monsters = {
		{ name = "Spark of Destruction", pos = Position(32267, 31253, 14) },
		{ name = "Spark of Destruction", pos = Position(32274, 31255, 14) },
		{ name = "Spark of Destruction", pos = Position(32274, 31249, 14) },
		{ name = "Spark of Destruction", pos = Position(32267, 31249, 14) },
	},
	onUseExtra = function()
		Game.setStorageValue(GlobalStorage.HeartOfDestruction.ChargedAnomaly, 0)
		local tile = Tile(Position(32261, 31250, 14))
		if tile then
			local vortex = tile:getItemById(23482)
			if vortex then
				vortex:transform(23483)
				vortex:setActionId(14324)
			end
		end
	end,
	exitTpDestination = Position(32182, 31250, 14),
}

local lever = EncounterLever(config)
lever:aid(14325)
lever:register()
