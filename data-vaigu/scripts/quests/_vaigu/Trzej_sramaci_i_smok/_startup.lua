local startupItemsStatic = {
	{ pos = { 5950, 1415, 10 }, id = 1020, aid = Storage.TheThreeSramatiansAndTheDragon.GoldblumTrap },

	{ pos = { 6147, 1310, 4 }, id = 1997, aid = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.Hive },
	{ pos = { 6199, 1025, 7 }, id = 1997, aid = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.Lagoon },
	{ pos = { 6206, 919, 9 }, id = 1997, aid = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.Souleater },
	{ pos = { 6756, 1169, 6 }, id = 1997, aid = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.WaterWell },
	{ pos = { 6569, 605, 6 }, id = 1997, aid = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.Hairycles },
	{ pos = { 6710, 651, 12 }, id = 1997, aid = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.Hellspawns },

	{ pos = { 5951, 1113, 7 }, id = 1997, aid = Storage.TheThreeSramatiansAndTheDragon.AbandonedFireplace },

	{ pos = { 6157, 842, 6 }, id = 4406, aid = Storage.TheThreeSramatiansAndTheDragon.VampireCityTrap },

	{ pos = { 6793, 560, 11 }, id = 4396, aid = Storage.TheThreeSramatiansAndTheDragon.RatOfKingsTile },
}

local startupRewardsStatic = {
	{
		pos = { 6180, 1265, 7 },
		id = 2484,
		aid = Storage.TheThreeSramatiansAndTheDragon.Rewards.Rum,
		rewards = { TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rum },
		uid = 1000,
		requiredState = { [Storage.TheThreeSramatiansAndTheDragon.Questline] = 5 },
		nextState = { [Storage.TheThreeSramatiansAndTheDragon.Questline] = 6, [Storage.TheThreeSramatiansAndTheDragon.Mission03] = 4 },
		specialActionsOnSuccess = {
			{
				action = SPECIAL_ACTIONS_UNIVERSAL.createMonstersAtPlayer,
				monsters = { { name = "Pirate Corsair", count = 2 } },
			},
		},
	},
	{
		pos = { 6707, 1068, 9 },
		id = 7805,
		uid = 1000,
		aid = Storage.TheThreeSramatiansAndTheDragon.Rewards.DeepCrystal,
		rewards = { TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.deepCrystal },
		requiredState = { [Storage.TheThreeSramatiansAndTheDragon.Questline] = 15 },
	},
	{
		pos = { 6814, 600, 12 },
		id = 11809,
		aid = Storage.TheThreeSramatiansAndTheDragon.Rewards.rune1,
		uid = 1000,
		requiredState = { [Storage.TheThreeSramatiansAndTheDragon.Rewards.rune1] = -1, [Storage.TheThreeSramatiansAndTheDragon.Questline] = 21 },
		nextState = { [Storage.TheThreeSramatiansAndTheDragon.Rewards.rune1] = 1 },
		specialActionsOnSuccess = {
			{
				action = SPECIAL_ACTIONS_UNIVERSAL.createMonstersAtPlayer,
				monsters = { { name = "Jan Kockodan", count = 1 } },
			},
		},
		rewards = {
			TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune1,
		},
	},
	{
		pos = { 6775, 623, 12 },
		id = 11809,
		aid = Storage.TheThreeSramatiansAndTheDragon.Rewards.rune2,
		uid = 1000,
		requiredState = { [Storage.TheThreeSramatiansAndTheDragon.Rewards.rune2] = -1, [Storage.TheThreeSramatiansAndTheDragon.Questline] = 21 },
		nextState = { [Storage.TheThreeSramatiansAndTheDragon.Rewards.rune2] = 1 },
		specialActionsOnSuccess = {
			{
				action = SPECIAL_ACTIONS_UNIVERSAL.createMonstersAtPlayer,
				monsters = { { name = "Enchanted Hellspawn", count = 2 } },
			},
		},
		rewards = {
			TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune2,
		},
	},
	{
		pos = { 6809, 634, 13 },
		id = 11809,
		aid = Storage.TheThreeSramatiansAndTheDragon.Rewards.rune3,
		uid = 1000,
		requiredState = { [Storage.TheThreeSramatiansAndTheDragon.Rewards.rune3] = -1, [Storage.TheThreeSramatiansAndTheDragon.Questline] = 21 },
		nextState = { [Storage.TheThreeSramatiansAndTheDragon.Rewards.rune3] = 1 },
		specialActionsOnSuccess = {
			{
				action = SPECIAL_ACTIONS_UNIVERSAL.createMonstersAtPlayer,
				monsters = { { name = "Runic Hellspawn", count = 2 } },
			},
		},
		rewards = {
			TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune3,
		},
	},
}

local npcs = {
	{ name = "goldblum", pos = { 5954, 1417, 11 } },
	{ name = "boboeater", pos = { 6211, 918, 9 } },
	{ name = "polychek", pos = { 6620, 1085, 5 } },
}
local function resetSpawnLocks()
	for _, spawnLock in pairs(Storage.SafetyAndOccupationalHygiene.Spawns) do
		Game.setStorageValue(spawnLock, 0)
	end
end

local bhpInit = GlobalEvent("trzejSramaciISmokInit")
function bhpInit.onStartup()
	LoadStartupItems(startupItemsStatic)
	LoadStartupItems(startupRewardsStatic)
	LoadStartupNpc(npcs)
	resetSpawnLocks()
end
bhpInit:register()
