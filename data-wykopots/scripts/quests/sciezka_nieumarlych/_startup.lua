local startupItemsStatic = {
	{ pos = { 5642, 1755, 6 }, id = 596, aid = Storage.SciezkaNieumarlych.Circles },
	{ pos = { 6528, 1396, 5 }, id = 597, aid = Storage.SciezkaNieumarlych.Circles },
	{ pos = { 6951, 702, 7 }, id = 598, aid = Storage.SciezkaNieumarlych.Circles },
	{ pos = { 5960, 1466, 4 }, id = 599, aid = Storage.SciezkaNieumarlych.Circles }, --
	{ pos = { 5786, 804, 7 }, id = 924, aid = Storage.SciezkaNieumarlych.Circles },

	{ pos = { 6221, 1238, 7 }, id = 3698, aid = Storage.SciezkaNieumarlych.KonmuldBush },
}

local startUpItemsSciezka = {
	{ pos = { -6, 44, -3 }, id = 2773, aid = Storage.SciezkaNieumarlych.UpperLever },

	{ pos = { -7, 33, -1 }, id = 1660, aid = Storage.SciezkaNieumarlych.Mission03 }, -- quest door
	{ pos = { -22, 35, 1 }, id = 2472, aid = Storage.SciezkaNieumarlych.CursedChest },
	{ pos = { -11, 27, 1 }, id = 2472, aid = Storage.SciezkaNieumarlych.CursedChest },
	{ pos = { 3, 27, 1 }, id = 2472, aid = Storage.SciezkaNieumarlych.CursedChest },

	{ pos = { -17, 21, 1 }, id = 7575, aid = Storage.SciezkaNieumarlych.GuardianSkull },
	{ pos = { -11, 19, 1 }, id = 7568, aid = Storage.SciezkaNieumarlych.GuardianSkull },
	{ pos = { 5, 15, 1 }, id = 7574, aid = Storage.SciezkaNieumarlych.GuardianSkull },

	{ pos = { -9, 13, 1 }, id = 351, aid = Storage.SciezkaNieumarlych.GuardianGateTile },
	{ pos = { -8, 13, 1 }, id = 351, aid = Storage.SciezkaNieumarlych.GuardianGateTile },

	{ pos = { 2, -34, -2 }, id = 470, aid = Storage.SciezkaNieumarlych.RitualLocus },

	{ pos = { -64, -20, 0 }, id = 11440, aid = Storage.SciezkaNieumarlych.BossBook },

	{ pos = { 38, -21, -4 }, id = 5122, aid = Storage.SciezkaNieumarlych.SkipDoor },
}
local startupRewardsStatic = {}
local npcs = { { name = "gandalf", pos = { 5951, 1466, 4 } } }
local function resetSpawnLocks()
	for _, spawnLock in pairs(Storage.BezpieczenstwoIHigienaPracy.Spawns) do
		Game.setStorageValue(spawnLock, 0)
	end
end

local sciezkaInit = GlobalEvent("sciezkaNieumarlychInit")
function sciezkaInit.onStartup()
	LoadStartupItems(startupItemsStatic)
	LoadStartupItems(startupRewardsStatic)
	LoadStartupNpc(npcs)
	LoadStartupItems(startUpItemsSciezka, SCIEZKA_NIEUMARLYCH_ANCHOR)
	resetSpawnLocks()
end
sciezkaInit:register()
