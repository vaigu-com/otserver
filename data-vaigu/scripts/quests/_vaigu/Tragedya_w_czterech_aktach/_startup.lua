BANJO_KROLA_SZCZUROW:Script(function(storageToRequiredState)
local startupStatic = {
	{ pos = { 5514, 1555, 7 }, id = 2000, aid = Storage.FourActTragedy.Portals.ToRetro },
	{ pos = { 5977, 1178, 6 }, id = 1949, aid = Storage.FourActTragedy.Portals.ToKolumb },

	{ pos = { 6966, 664, 13 }, id = 2943, aid = Storage.FourActTragedy.SlippersTorch },
	{
		pos = { 6962, 664, 14 },
		id = 1983,
		actionid = Storage.FourActTragedy.Rewards.SlippersChest,
		uid = 1000,
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.bribeslippers },
		requiredState = { [Storage.FourActTragedy.Questline] = 11 },
		nextState = { [Storage.FourActTragedy.Questline] = 12, [Storage.FourActTragedy.Mission04] = 2 },
		desc = "Rest is peace\n~Followers of The Frog Cult",
	},
	{ pos = { 6581, 557, 9 }, id = 5131, aid = Storage.FourActTragedy.SkurwiwijDoor },

	{ pos = { 6005, 1386, 12 }, id = 5131, aid = Storage.FourActTragedy.GrazhenaDoor },
}

local startUpCorpse = {
	{
		id = 31649,
		actionid = Storage.FourActTragedy.Rewards.TimmyBag,
		rewards = { TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS.timmyBag },
		requiredState = { [Storage.FourActTragedy.Questline] = 5 },
		nextState = { [Storage.FourActTragedy.Questline] = 6, [Storage.FourActTragedy.Mission02] = 3 },
	},
	{
		id = 18021,
		actionid = Storage.FourActTragedy.Rewards.GrazynaCore,
		rewards = { TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS.grazynaCore },
		requiredState = { [Storage.FourActTragedy.Questline] = 14 },
	},
}

local startupRetro = {
	{ pos = { -62, -8, 0 }, id = 2000, aid = Storage.FourActTragedy.Portals.ToPresent },
	{
		pos = { -8, -15, 6 },
		id = 11809,
		actionid = Storage.FourActTragedy.Rewards.Fanfare,
		uid = 1000,
		rewards = { TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS.fanfare },
	},
	{
		pos = { 61, 21, -1 },
		id = 4073,
		actionid = Storage.FourActTragedy.Rewards.Powder,
		uid = 1000,
		rewards = {
			TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS.timmyPowder,
		},
		requiredState = { [Storage.FourActTragedy.Questline] = 7 },
	},
	{ pos = { -29, -34, 6 }, id = 2773, aid = Storage.FourActTragedy.FanfareLever },

	{ pos = { -24, -23, 6 }, id = 7723, aid = Storage.FourActTragedy.WawelDragonAccess }, -- quest door
}

local npcs = { { name = "Grazhena", pos = { 5995, 1390, 12 } } }

local npcsKnurowo = { { name = "timmy", pos = { -47, 19, 0 } } }

local desertQuestInit = GlobalEvent("tragedyaWCzterechAktachInit")
function desertQuestInit.onStartup()
	LoadStartupItems(startupStatic)
	LoadStartupItems(startupRetro, RETRO_KNUROWO_ANCHOR)
	LoadStartupItems(startUpCorpse)
	LoadStartupNpcs(npcsKnurowo, RETRO_KNUROWO_ANCHOR)
	LoadStartupNpcs(npcs)
end
desertQuestInit:register()
end)
