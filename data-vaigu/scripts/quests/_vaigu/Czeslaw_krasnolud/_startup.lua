local startupItemsStatic = {
	{ pos = { 7049, 826, 7 }, id = 5258, aid = Storage.CzeslawKrasnolud.CzeslawHouseStairs },

	{ pos = { 6660, 1139, 7 }, id = 231, aid = Storage.CzeslawKrasnolud.CaveTile },
	{ pos = { 6661, 1139, 7 }, id = 231, aid = Storage.CzeslawKrasnolud.CaveTile },
	{ pos = { 6662, 1139, 7 }, id = 231, aid = Storage.CzeslawKrasnolud.CaveTile },

	{ pos = { 6438, 1125, 14 }, id = 9567, aid = Storage.CzeslawKrasnolud.DoorToCzeslawCompartment },
}

local startupRewardsStatic = {}
local npcs = {
	{ name = "Chester the Dwarf", pos = { 7053, 827, 6 } },
	{ name = "Chester the Dwarf", pos = { 6428, 1125, 14 } },
}
local function resetSpawnLocks()
	for _, spawnLock in pairs(Storage.BezpieczenstwoIHigienaPracy.Spawns) do
		Game.setStorageValue(spawnLock, 0)
	end
end

local bhpInit = GlobalEvent("czeslawKrasnoludInit")
function bhpInit.onStartup()
	LoadStartupItems(startupItemsStatic)
	LoadStartupItems(startupRewardsStatic)
	LoadStartupNpc(npcs)
	resetSpawnLocks()
end
bhpInit:register()
