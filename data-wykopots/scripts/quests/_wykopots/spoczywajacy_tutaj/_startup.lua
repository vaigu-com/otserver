local startupItemsStatic = {
	{ pos = { 5939, 1779, 7 }, id = 2477, aid = Storage.SpoczywajacyTutaj.Coffin },
	{ pos = { 5938, 1779, 7 }, id = 2476, aid = Storage.SpoczywajacyTutaj.Coffin },
	{ pos = { 5939, 1779, 7 }, id = 3522, aid = 0 },
	{ pos = { 5938, 1779, 7 }, id = 3526, aid = 0 },

	{ pos = { 6712, 1408, 13 }, id = 3204, aid = Storage.SpoczywajacyTutaj.Corpse },
}

local function resetSpawnLocks()
	for _, spawnLock in pairs(Storage.BezpieczenstwoIHigienaPracy.Spawns) do
		Game.setStorageValue(spawnLock, 0)
	end
end

local bhpInit = GlobalEvent("spoczywajacyTutajInit")
function bhpInit.onStartup()
	LoadStartupItems(startupItemsStatic)
	resetSpawnLocks()
end
bhpInit:register()
