BANJO_KROLA_SZCZUROW:Script(function(storageToRequiredState)
local startupItemsStatic = {
	{ pos = { 5642, 1755, 6 }, id = 596, aid = Storage.PathOfTheUndead.Circles },
	{ pos = { 6528, 1396, 5 }, id = 597, aid = Storage.PathOfTheUndead.Circles },
	{ pos = { 6951, 702, 7 }, id = 598, aid = Storage.PathOfTheUndead.Circles },
	{ pos = { 5960, 1466, 4 }, id = 599, aid = Storage.PathOfTheUndead.Circles }, --
	{ pos = { 5786, 804, 7 }, id = 924, aid = Storage.PathOfTheUndead.Circles },

	{ pos = { 6221, 1238, 7 }, id = 3698, aid = Storage.PathOfTheUndead.KonmuldBush },
}

local startUpItemsSciezka = {
	{ pos = { -6, 44, -3 }, id = 2773, aid = Storage.PathOfTheUndead.UpperLever },

	{ pos = { -7, 33, -1 }, id = 1660, aid = Storage.PathOfTheUndead.Mission03 }, -- quest door
	{ pos = { -22, 35, 1 }, id = 2472, aid = Storage.PathOfTheUndead.CursedChest },
	{ pos = { -11, 27, 1 }, id = 2472, aid = Storage.PathOfTheUndead.CursedChest },
	{ pos = { 3, 27, 1 }, id = 2472, aid = Storage.PathOfTheUndead.CursedChest },

	{ pos = { -17, 21, 1 }, id = 7575, aid = Storage.PathOfTheUndead.GuardianSkull },
	{ pos = { -11, 19, 1 }, id = 7568, aid = Storage.PathOfTheUndead.GuardianSkull },
	{ pos = { 5, 15, 1 }, id = 7574, aid = Storage.PathOfTheUndead.GuardianSkull },

	{ pos = { -9, 13, 1 }, id = 351, aid = Storage.PathOfTheUndead.GuardianGateTile },
	{ pos = { -8, 13, 1 }, id = 351, aid = Storage.PathOfTheUndead.GuardianGateTile },

	{ pos = { 2, -34, -2 }, id = 470, aid = Storage.PathOfTheUndead.RitualLocus },

	{ pos = { -64, -20, 0 }, id = 11440, aid = Storage.PathOfTheUndead.BossBook },

	{ pos = { 38, -21, -4 }, id = 5122, aid = Storage.PathOfTheUndead.SkipDoor },
}
local startupRewardsStatic = {}
local npcs = { { name = "gandalf", pos = { 5951, 1466, 4 } } }
local function resetSpawnLocks()
	for _, spawnLock in pairs(Storage.SafetyAndOccupationalHygiene.Spawns) do
		Game.setStorageValue(spawnLock, 0)
	end
end

local sciezkaInit = GlobalEvent("sciezkaNieumarlychInit")
function sciezkaInit.onStartup()
	LoadStartupItems(startupItemsStatic)
	LoadStartupItems(startupRewardsStatic)
	LoadStartupNpcs(npcs)
	LoadStartupItems(startUpItemsSciezka, SCIEZKA_NIEUMARLYCH_ANCHOR)
	resetSpawnLocks()
end
sciezkaInit:register()
end)
