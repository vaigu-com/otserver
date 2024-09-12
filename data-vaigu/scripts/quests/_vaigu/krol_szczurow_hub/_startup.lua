local startupLeversToHub = {
	{ pos = { 5563, 1577, 8 }, id = 2773, aid = Storage.KrolSzczurowHub.Portals.Ryan },
	{ pos = { 5971, 1482, 7 }, id = 2773, aid = Storage.KrolSzczurowHub.Portals.SweatyCyclops },
	{ pos = { 6657, 1242, 6 }, id = 1931, aid = Storage.KrolSzczurowHub.Portals.Djinns },
	{ pos = { 6692, 485, 7 }, id = 2773, aid = Storage.KrolSzczurowHub.Portals.NorthKongo },
	{ pos = { 6279, 988, 7 }, id = 2773, aid = Storage.KrolSzczurowHub.Portals.Werebadgers },
	{ pos = { 6138, 845, 7 }, id = 2773, aid = Storage.KrolSzczurowHub.Portals.VampireCity },
	{ pos = { 6678, 993, 7 }, id = 2773, aid = Storage.KrolSzczurowHub.Portals.Asuras },
	{ pos = { 6917, 1319, 5 }, id = 2773, aid = Storage.KrolSzczurowHub.Portals.HurghadaEast },
}
local startupPortalsToOut = {
	{ pos = { -3, 3, 0 }, id = 7804, aid = Storage.KrolSzczurowHub.Portals.Ryan },
	{ pos = { -4, -2, 0 }, id = 7804, aid = Storage.KrolSzczurowHub.Portals.SweatyCyclops },
	{ pos = { 0, -4, 0 }, id = 7804, aid = Storage.KrolSzczurowHub.Portals.Djinns },
	{ pos = { 4, -1, 0 }, id = 7804, aid = Storage.KrolSzczurowHub.Portals.NorthKongo },
	{ pos = { 4, 2, 0 }, id = 7804, aid = Storage.KrolSzczurowHub.Portals.Werebadgers },
	{ pos = { -5, 8, -1 }, id = 7804, aid = Storage.KrolSzczurowHub.Portals.VampireCity },
	{ pos = { 2, 11, -1 }, id = 7804, aid = Storage.KrolSzczurowHub.Portals.Asuras },
	{ position = { -3, -7, -2 }, id = 7804, aid = Storage.KrolSzczurowHub.Portals.HurghadaEast },
}

local artifactsStartup = {
	{
		--dont add pos!
		id = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.lit, -- dont change
		aid = Storage.TeatrTaniejSensacji.PlusShapePuzzle.Book, -- dont change
		requiredState = { [Storage.TeatrTaniejSensacji.Questline] = 9 },
		nextState = {
			[Storage.KrolSzczurowHub.Items.LibrumVortex] = 1,
			[Storage.TeatrTaniejSensacji.Questline] = 10,
			[Storage.TeatrTaniejSensacji.Mission04] = 3,
		},
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.librumvortex },
	},
	{
		pos = PETRUS_CIEMIEZCA_ANCHOR:Moved(-3, 2, 1),
		id = 2471,
		aid = Storage.KrolSzczurowHub.Items.Ytong,
		uid = 1000,
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.ytong },
		requiredState = { [Storage.BezpieczenstwoIHigienaPracy.Questline] = 13 },
		nextState = {
			[Storage.BezpieczenstwoIHigienaPracy.Questline] = 14,
			[Storage.BezpieczenstwoIHigienaPracy.Mission06] = 3,
		},
	},
	{
		pos = { 6783, 817, 4 },
		id = 3064,
		uid = 1000,
		aid = Storage.KrolSzczurowHub.Items.Bottomless,
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.bottomless },
		requiredState = { [Storage.TrzejSramaciISmok.Questline] = 17 },
		nextState = { [Storage.TrzejSramaciISmok.Questline] = 18, [Storage.TrzejSramaciISmok.Mission07] = 2 },
	},
	{
		pos = HUGO_BEACH_PLANET_ANCHOR:Moved(67, -150, 0),
		id = 3503,
		uid = 1000,
		aid = Storage.KrolSzczurowHub.Items.Antigone,
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.antigone },
		requiredState = { [Storage.PerIustitiaAdAstra.Questline] = 27 },
		nextState = { [Storage.PerIustitiaAdAstra.Questline] = 28, [Storage.PerIustitiaAdAstra.Mission06] = 4, [Storage.Finished.AdAstra] = 1 },
	},
	{ --trick parcel
		pos = HUGO_BEACH_PLANET_ANCHOR:Moved(67, -150, 0),
		id = 3504,
		aid = 0,
		uid = 0,
	},
	{
		pos = JANUSZEX_ANCHOR:Moved(-16, -103, 4),
		id = 11809,
		actionid = Storage.KrolSzczurowHub.Items.Cultivator,
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.cultivator },
	},
}

local npcs = { { name = "gm romek", pos = { 0, 0, 0 } } }

local desertQuestInit = GlobalEvent("krolSzczurowHubInit")
function desertQuestInit.onStartup()
	LoadStartupItems(startupLeversToHub)
	LoadStartupItems(startupPortalsToOut, KROL_SZCZUROW_HUB_ANCHOR)
	LoadStartupItems(artifactsStartup)

	LoadStartupNpc(npcs, KROL_SZCZUROW_HUB_ANCHOR)
end
desertQuestInit:register()
