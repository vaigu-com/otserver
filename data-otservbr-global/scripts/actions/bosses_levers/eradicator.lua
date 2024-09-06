local config = {
	bossName = "Eradicator",
	bossPosition = Position(32309, 31283, 14),
	entranceTiles = {
		{ pos = Position(32334, 31284, 14), destination = Position(32309, 31290, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32334, 31285, 14), destination = Position(32309, 31290, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32334, 31286, 14), destination = Position(32309, 31290, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32334, 31287, 14), destination = Position(32309, 31290, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32334, 31288, 14), destination = Position(32309, 31290, 14), effect = CONST_ME_TELEPORT },
	},
	zoneArea = {
		from = Position(32297, 31272, 14),
		to = Position(32321, 31296, 14),
	},
	monsters = {
		{ name = "Spark of Destruction", pos = Position(32304, 31282, 14) },
		{ name = "Spark of Destruction", pos = Position(32305, 31287, 14) },
		{ name = "Spark of Destruction", pos = Position(32312, 31287, 14) },
		{ name = "Spark of Destruction", pos = Position(32314, 31282, 14) },
	},
	onUseExtra = function()
		Game.setStorageValue(GlobalStorage.HeartOfDestruction.EradicatorReleaseT, -1)
		Game.setStorageValue(GlobalStorage.HeartOfDestruction.EradicatorWeak, -1)

		eradicatorEvent = addEvent(function()
			Game.setStorageValue(GlobalStorage.HeartOfDestruction.EradicatorReleaseT, 1)
		end, 74000)

		local tile = Tile(Position(32318, 31284, 14))
		if tile then
			local vortex = tile:getItemById(23482)
			if vortex then
				vortex:transform(23483)
				vortex:setActionId(14348)
			end
		end
	end,
	exitTpDestination = Position(32218, 31375, 11),
}

local lever = BossLever(config)
lever:aid(14330)
lever:register()
