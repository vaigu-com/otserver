BANJO_KROLA_SZCZUROW:Script(function(storageToRequiredState)
local startupLeversToHub = {
	{ pos = { 5563, 1577, 8 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.Ryan },
	{ pos = { 5971, 1482, 7 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.SweatyCyclops },
	{ pos = { 6657, 1242, 6 }, id = 1931, aid = Storage.KingOfRatsHQ.Portals.Djinns },
	{ pos = { 6692, 485, 7 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.NorthKongo },
	{ pos = { 6279, 988, 7 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.Werebadgers },
	{ pos = { 6138, 845, 7 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.VampireCity },
	{ pos = { 6678, 993, 7 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.Asuras },
	{ pos = { 6917, 1319, 5 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.HurghadaEast },
}
local startupPortalsToOut = {
	{ pos = { -3, 3, 0 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.Ryan },
	{ pos = { -4, -2, 0 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.SweatyCyclops },
	{ pos = { 0, -4, 0 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.Djinns },
	{ pos = { 4, -1, 0 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.NorthKongo },
	{ pos = { 4, 2, 0 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.Werebadgers },
	{ pos = { -5, 8, -1 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.VampireCity },
	{ pos = { 2, 11, -1 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.Asuras },
	{ position = { -3, -7, -2 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.HurghadaEast },
}

local artifactsStartup = {
	{
		--dont add pos!
		id = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.lit, -- dont change
		aid = Storage.TheaterOfCheapThrills.PlusShapePuzzle.Book, -- dont change
		requiredState = { [Storage.TheaterOfCheapThrills.Questline] = 9 },
		nextState = {
			[Storage.KingOfRatsHQ.Items.LibrumVortex] = 1,
			[Storage.TheaterOfCheapThrills.Questline] = 10,
			[Storage.TheaterOfCheapThrills.Mission04] = 3,
		},
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.librumvortex },
	},
	{
		pos = PETRUS_CIEMIEZCA_ANCHOR:Moved(-3, 2, 1),
		id = 2471,
		aid = Storage.KingOfRatsHQ.Items.Ytong,
		uid = 1000,
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.ytong },
		requiredState = { [Storage.SafetyAndOccupationalHygiene.Questline] = 14 },
		nextState = {
			[Storage.SafetyAndOccupationalHygiene.Questline] = 15,
			[Storage.SafetyAndOccupationalHygiene.Mission06] = 3,
		},
	},
	{
		pos = { 6696, 825, 4 },
		id = 3064,
		uid = 1000,
		aid = Storage.KingOfRatsHQ.Items.Bottomless,
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.bottomless },
		requiredState = { [Storage.ThreeSramatiansAndTheDragon.Questline] = 17 },
		nextState = {
			[Storage.ThreeSramatiansAndTheDragon.Questline] = 18,
			[Storage.ThreeSramatiansAndTheDragon.Mission07] = 2,
		},
	},
	{
		pos = HUGO_BEACH_PLANET_ANCHOR:Moved(67, -150, 0),
		id = 3503,
		uid = 1000,
		aid = Storage.KingOfRatsHQ.Items.Antigone,
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.antigone },
		requiredState = { [Storage.PerIustitiaAdAstra.Questline] = 27 },
		nextState = {
			[Storage.PerIustitiaAdAstra.Questline] = 28,
			[Storage.PerIustitiaAdAstra.Mission06] = 4,
			[Storage.Finished.PerIustitiaAdAstra] = 1,
		},
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
		actionid = Storage.KingOfRatsHQ.Items.Cultivator,
		rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.cultivator },
	},
}

local npcs = { { name = "gm romek", pos = { 0, 0, 0 } } }

local desertQuestInit = GlobalEvent("krolSzczurowHubInit")
function desertQuestInit.onStartup()
	LoadStartupItems(startupLeversToHub)
	LoadStartupItems(startupPortalsToOut, KROL_SZCZUROW_HUB_ANCHOR)
	LoadStartupItems(artifactsStartup)

	LoadStartupNpcs(npcs, KROL_SZCZUROW_HUB_ANCHOR)
end
desertQuestInit:register()
end)
