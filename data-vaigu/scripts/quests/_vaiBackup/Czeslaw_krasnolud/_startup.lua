	:Script(function(storageToRequiredState)
local startupItemsStatic = {
	{ pos = { 7049, 826, 7 }, id = 5258, aid = Storage.ChesterTheDwarf.ChesterHouseStairs },

	{ pos = { 6660, 1139, 7 }, id = 231, aid = Storage.ChesterTheDwarf.CaveTile },
	{ pos = { 6661, 1139, 7 }, id = 231, aid = Storage.ChesterTheDwarf.CaveTile },
	{ pos = { 6662, 1139, 7 }, id = 231, aid = Storage.ChesterTheDwarf.CaveTile },

	{ pos = { 6438, 1125, 14 }, id = 9567, aid = Storage.ChesterTheDwarf.DoorToChesterCompartment },
}

local startupRewardsStatic = {}
local npcs = {
	{ name = "Chester the Dwarf", pos = { 7053, 827, 6 } },
	{ name = "Chester the Dwarf", pos = { 6428, 1125, 14 } },
}
local function resetSpawnLocks()
	for _, spawnLock in pairs(Storage.SafetyAndOccupationalHygiene.Spawns) do
		Game.setStorageValue(spawnLock, 0)
	end
end

local bhpInit = GlobalEvent("czeslawKrasnoludInit")
function bhpInit.onStartup()
	LoadStartupItems(startupItemsStatic)
	LoadStartupItems(startupRewardsStatic)
	LoadStartupNpcs(npcs)
	resetSpawnLocks()
end
bhpInit:register()
end)
