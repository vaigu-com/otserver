BANJO_KROLA_SZCZUROW:Script(function(storageToRequiredState)
local startupStatic = {
	{ position = Position(7541, 960, 13), id = 2598, aid = Storage.ProdigalSon.Train.SelectDestination },
	{ position = Position(7555, 960, 13), id = 2598, aid = Storage.ProdigalSon.Train.SelectDestination },
	{ position = Position(6465, 1123, 14), id = 2598, aid = Storage.ProdigalSon.Train.SelectDestination },
	{ position = Position(6451, 1123, 14), id = 2598, aid = Storage.ProdigalSon.Train.SelectDestination },
	{ position = Position(6437, 1123, 14), id = 2598, aid = Storage.ProdigalSon.Train.SelectDestination },

	{ position = Position(7637, 1126, 7), id = 436, aid = Storage.ProdigalSon.MainGateAccess },
	{ position = Position(7638, 1126, 7), id = 436, aid = Storage.ProdigalSon.MainGateAccess },
	{ position = Position(7620, 1067, 12), id = 7756, aid = Storage.ProdigalSon.MainGateAccess },
	{ position = Position(7654, 1073, 12), id = 429, aid = Storage.ProdigalSon.MainGateAccess },
	{ position = Position(7655, 1073, 12), id = 429, aid = Storage.ProdigalSon.MainGateAccess },
	{ position = Position(7656, 1073, 12), id = 429, aid = Storage.ProdigalSon.MainGateAccess },
	{ position = Position(7618, 950, 12), id = 352, aid = Storage.ProdigalSon.NorthMinesAccess },
	{ position = Position(7619, 950, 12), id = 429, aid = Storage.ProdigalSon.NorthMinesAccess },
	{ position = Position(7620, 950, 12), id = 429, aid = Storage.ProdigalSon.NorthMinesAccess },
	{ position = Position(7621, 950, 12), id = 352, aid = Storage.ProdigalSon.NorthMinesAccess },
	{ position = Position(6440, 1125, 14), id = 20712, aid = Storage.ProdigalSon.TileBeforeChesterCompartment },
}

local startupNpcTrain = {
	{ pos = { 0, 0, 0 }, name = "Train Guard" },
}

local startupJanuszex = {
	--hammer
	{ pos = { -90, -68, 2 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.lever2, aid = Storage.ProdigalSon.HammerMaking.Lever },
	{ pos = { -90, -69, 2 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.stoneTable, uid = 1000, aid = 0 },
	{ pos = { -90, -70, 2 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.paint, aid = Storage.ProdigalSon.HammerMaking.Paint },
	--calculator
	{ pos = { -77, 3, -1 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.stonePile, aid = Storage.ProdigalSon.CalculatorMaking.MetalPile },
	{ pos = { -75, 3, -1 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.stonePile, aid = Storage.ProdigalSon.CalculatorMaking.MetalPile },
	{ pos = { -77, 5, -1 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.woodPile, aid = Storage.ProdigalSon.CalculatorMaking.WoodPile },
	{ pos = { -76, 5, -1 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.woodPile, aid = Storage.ProdigalSon.CalculatorMaking.WoodPile },
	{ pos = { -75, 5, -1 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.woodPile, aid = Storage.ProdigalSon.CalculatorMaking.WoodPile },
	{ pos = { -74, 5, -1 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.woodPile, aid = Storage.ProdigalSon.CalculatorMaking.WoodPile },
	{ pos = { -75, 4, 1 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.westMachine, aid = Storage.ProdigalSon.CalculatorMaking.Lever },
	--pliers
	{ pos = { -98, -36, 1 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.stonePile, aid = Storage.ProdigalSon.PliersMaking.MetalPile },
	{ pos = { -97, -36, 1 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.stonePile, aid = Storage.ProdigalSon.PliersMaking.MetalPile },
	{ pos = { -99, -42, 1 }, id = SYN_MARNOTRAWNY_NORMAL_ITEMS.southMachine, aid = Storage.ProdigalSon.PliersMaking.Lever },
	--areczek leader
	{ pos = { -87, -52, -1 }, id = 710, aid = Storage.ProdigalSon.AreczekLeaderBed },
	{ pos = { -87, -51, -1 }, id = 711, aid = Storage.ProdigalSon.AreczekLeaderBed },
	--eristics
	{ pos = { -50, -5, 1 }, id = 2438, aid = Storage.ProdigalSon.EristicsBooks.One, rewards = { SYN_MARNOTRAWNY_KEY_ITEMS.bookOne } },
	{ pos = { -69, 17, 5 }, id = 27314, aid = Storage.ProdigalSon.EristicsBooks.Two, rewards = { SYN_MARNOTRAWNY_KEY_ITEMS.bookTwo } },
	{ pos = { -47, 166, 4 }, id = 2473, aid = Storage.ProdigalSon.EristicsBooks.Three, rewards = { SYN_MARNOTRAWNY_KEY_ITEMS.bookThree } },
	{ pos = { -61, 27, 2 }, id = 9125, aid = Storage.ProdigalSon.SewersLever },
	{ pos = { -61, 27, 5 }, id = 9125, aid = Storage.ProdigalSon.SewersLever },
	--necklace corpse
	{ pos = { -40, -270, 5 }, id = 4169, aid = Storage.ProdigalSon.DiamondNecklace, rewards = { SYN_MARNOTRAWNY_KEY_ITEMS.diamondNecklace } },
	--fredi
	{ pos = { 104, -150, 4 }, id = 5468, aid = Storage.ProdigalSon.FrediBeer, nextState = { [Storage.ProdigalSon.FrediBeer] = -1 }, requiredState = { [Storage.ProdigalSon.Questline] = { min = 20, max = 20 } }, rewards = { SYN_MARNOTRAWNY_KEY_ITEMS.frediBeer } },
	--blackboards
	{ pos = { -174, 5, 5 }, id = 2602, aid = Storage.ProdigalSon.Blackboard, desc = "BLACKBOARD_DESC" },
	{ pos = { -174, 5, 5 }, id = 1717, actionid = 0 }, --waterfall
	{ pos = { -193, 1, 3 }, id = 2773, aid = Storage.ProdigalSon.BlackBoardLever1 },
	{ pos = { -182, 1, 3 }, id = 2773, aid = Storage.ProdigalSon.BlackBoardLever2 },
}

local startupNpcJanuszex = {
	{ pos = { -46, -5, 1 }, name = "Henry the Foreman" },
	{ pos = { 16, 25, 1 }, name = "Conference Dorothy" },
	{ pos = { 22, 20, 1 }, name = "Conference Dwight" },
	{ pos = { 31, 19, 1 }, name = "Conference Triss" },
	{ pos = { 108, -148, 5 }, name = "Fredi kamionka" },
	{ pos = { 63, 14, 1 }, name = "Access-O-Bot" },
}

local desertQuestInit = GlobalEvent("synMarnotrawnyInit")
function desertQuestInit.onStartup()
	LoadStartupItems(startupStatic)
	LoadStartupItems(startupJanuszex, JANUSZEX_ANCHOR)

	LoadStartupNpcs(startupNpcTrain, JANUSZEX_MOVING_TRAIN_ANCHOR)
	LoadStartupNpcs(startupNpcJanuszex, JANUSZEX_ANCHOR)
end
desertQuestInit:register()
end)
