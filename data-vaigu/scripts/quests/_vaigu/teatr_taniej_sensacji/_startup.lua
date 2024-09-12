local startupItemsStatic = {
	{ pos = { 6516, 1840, 6 }, id = 4401, aid = Storage.TeatrTaniejSensacji.Spawns.PaniPitca },

	{ pos = { 5888, 1896, 6 }, id = 5654, aid = Storage.TeatrTaniejSensacji.BrazilMap },
	{ pos = { 5889, 1896, 6 }, id = 5655, aid = Storage.TeatrTaniejSensacji.BrazilMap },

	{ pos = { 6184, 1019, 7 }, id = 1020, aid = Storage.TeatrTaniejSensacji.Spawns.JuerdoTitsgo },
	{
		pos = { 6812, 1414, 7 },
		id = 2472,
		aid = Storage.TeatrTaniejSensacji.Rewards.Cheese,
		uid = 1000,
		rewards = { TEATR_TANIEJ_SENSACJI_KEY_ITEMS.cheese },
		requiredState = { [Storage.TeatrTaniejSensacji.Questline] = 1 },
	},
}

local startupItemsLibrumVortex = {
	{ pos = { 7, -3, 0 }, id = 850, aid = Storage.TeatrTaniejSensacji.PlusShapePuzzle.MachineNorth },
	{ pos = { 2, 10, 0 }, id = 850, aid = Storage.TeatrTaniejSensacji.PlusShapePuzzle.MachineCenter },
	{ pos = { -10, 13, 0 }, id = 850, aid = Storage.TeatrTaniejSensacji.PlusShapePuzzle.MachineWest },

	{ pos = { -3, -12, 0 }, id = 28888, aid = Storage.TeatrTaniejSensacji.PlusShapePuzzle.Book },

	{ pos = { -3, -11, 0 }, id = 470, aid = Storage.TeatrTaniejSensacji.PlusShapePuzzle.Book },

	{ pos = { -5, -1, -2 }, id = 6260, aid = Storage.TeatrTaniejSensacji.Mission04 },
}

local startupItemsHub = {
	{ pos = { -4, -2, -2 }, id = 16487, aid = Storage.TeatrTaniejSensacji.Spawns.Robercik },
}

local function resetSpawnLocks()
	for _, spawnLock in pairs(Storage.TeatrTaniejSensacji.Spawns) do
		Game.setStorageValue(spawnLock, 0)
	end
end

local function createPlusShapeTiles()
	local unlitIds = {}
	for _, value in pairs(TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.litToUnlit) do
		unlitIds[#unlitIds + 1] = value
	end
	for _, config in pairs(TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.aidToMachineConfig) do
		IterateBetweenPositions(config.topLeft, config.downRight, function(context)
			local pos = context.pos
			local itemId = unlitIds[math.random(1, #unlitIds)]
			local item = Game.createItem(itemId, 1, pos)
			item:setActionId(Storage.TeatrTaniejSensacji.PlusShapePuzzle.Tile)
		end)
	end
end

local desertQuestInit = GlobalEvent("teatrTaniejSensacjiInit")
function desertQuestInit.onStartup()
	LoadStartupItems(startupItemsStatic)
	LoadStartupItems(startupItemsLibrumVortex, LIBRUM_VORTEX_ANCHOR)
	LoadStartupItems(startupItemsHub, KROL_SZCZUROW_HUB_ANCHOR)

	createPlusShapeTiles()
	resetSpawnLocks()
end
desertQuestInit:register()
