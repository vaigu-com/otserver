local startupStatic = {
	{ pos = { 5514, 1555, 7 }, id = 2000, aid = Storage.TragedyaWCzterechAktach.Portals.ToRetro },
	{ pos = { 5977, 1178, 6 }, id = 1949, aid = Storage.TragedyaWCzterechAktach.Portals.ToKolumb },

	{ pos = { 6966, 664, 13 }, id = 2943, aid = Storage.TragedyaWCzterechAktach.SlippersTorch },
	{
		pos = { 6962, 664, 14 },
		id = 1983,
		actionid = Storage.TragedyaWCzterechAktach.Rewards.SlippersChest,
		uid = 1000,
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.bribeslippers },
		requiredState = { [Storage.TragedyaWCzterechAktach.Questline] = 11 },
		nextState = { [Storage.TragedyaWCzterechAktach.Questline] = 12, [Storage.TragedyaWCzterechAktach.Mission04] = 2 },
		desc = "Rest is peace\n~Followers of The Frog Cult",
	},
	{ pos = { 6581, 557, 9 }, id = 5131, aid = Storage.TragedyaWCzterechAktach.SkurwiwijDoor },

	{ pos = { 6005, 1386, 12 }, id = 5131, aid = Storage.TragedyaWCzterechAktach.GrazhenaDoor },
}

local startUpCorpse = {
	{
		id = 31649,
		actionid = Storage.TragedyaWCzterechAktach.Rewards.TimmyBag,
		rewards = { TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS["TIMMY_BAG"] },
		requiredState = { [Storage.TragedyaWCzterechAktach.Questline] = 5 },
		nextState = { [Storage.TragedyaWCzterechAktach.Questline] = 6, [Storage.TragedyaWCzterechAktach.Mission02] = 3 },
	},
	{
		id = 18021,
		actionid = Storage.TragedyaWCzterechAktach.Rewards.GrazynaCore,
		rewards = { TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS["GRAZYNA_CORE"] },
		requiredState = { [Storage.TragedyaWCzterechAktach.Questline] = 14 },
	},
}

local startupRetro = {
	{ pos = { -62, -8, 0 }, id = 2000, aid = Storage.TragedyaWCzterechAktach.Portals.ToPresent },
	{
		pos = { -8, -15, 6 },
		id = 11809,
		actionid = Storage.TragedyaWCzterechAktach.Rewards.Fanfare,
		uid = 1000,
		rewards = { TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS["FANFARE"] },
	},
	{
		pos = { 61, 21, -1 },
		id = 4073,
		actionid = Storage.TragedyaWCzterechAktach.Rewards.Powder,
		uid = 1000,
		rewards = {
			TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS["TIMMY_POWDER"],
		},
		requiredState = { [Storage.TragedyaWCzterechAktach.Questline] = 7 },
	},
	{ pos = { -29, -34, 6 }, id = 2773, aid = Storage.TragedyaWCzterechAktach.FanfareLever },

	{ pos = { -24, -23, 6 }, id = 7723, aid = Storage.TragedyaWCzterechAktach.WawelDragonAccess }, -- quest door
}

local npcs = { { name = "Grazhena", pos = { 5995, 1390, 12 } } }

local npcsKnurowo = { { name = "timmy", pos = { -47, 19, 0 } } }

local desertQuestInit = GlobalEvent("tragedyaWCzterechAktachInit")
function desertQuestInit.onStartup()
	LoadStartupItems(startupStatic)
	LoadStartupItems(startupRetro, RETRO_KNUROWO_ANCHOR)
	LoadStartupItems(startUpCorpse)
	LoadStartupNpc(npcsKnurowo, RETRO_KNUROWO_ANCHOR)
	LoadStartupNpc(npcs)
end
desertQuestInit:register()
