BANJO_KROLA_SZCZUROW:Script(function(missionState)

local function resetSpawnLocks()
	for _, spawnLock in pairs(Storage.SafetyAndOccupationalHygiene.Spawns) do
		Game.setStorageValue(spawnLock, 0)
	end
end

local bhpInit = GlobalEvent("bezpieczenstwoIHigienaPracyInit")
function bhpInit.onStartup()
	LoadStartupItems(startupItemsPetrus, PETRUS_CIEMIEZCA_ANCHOR)
	LoadStartupItems(startupItemsMagicians, MIRKO_MAGICIANS_ANCHOR)
	LoadStartupItems(startupItemsStatic)
	resetSpawnLocks()
end
bhpInit:register()
end)
