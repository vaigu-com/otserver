BANJO_KROLA_SZCZUROW:Script(function(storageToRequiredState)
local startupStatic = {
	{ pos = { 5839, 792, 0 }, id = 2000, aid = Storage.PerIustitiaAdAstra.JanuszTile },
	{
		position = Position(7508, 292, 7),
		id = 7176,
		aid = Storage.DziadekMrozMammooth,
		onLook = function(context)
			context.player:removeMoneyBank(50)
		end,
	},
	{
		pos = { 5650, 1165, 13 },
		id = 16182,
		actionid = Storage.PerIustitiaAdAstra.Rewards.Converter,
		rewards = {
			PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.converter,
		},
		requiredState = {
			[Storage.PerIustitiaAdAstra.Questline] = 4,
		},
	},
	{
		position = Position(7611, 1065, 6),
		id = 853,
		actionid = Storage.PerIustitiaAdAstra.Rewards.EngineBlueprint,
		rewards = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.engineBlueprint },
		requiredState = {
			[Storage.PerIustitiaAdAstra.Questline] = 5,
		},
	},
	{
		position = Position(7957, 1517, 4),
		id = 2438,
		actionid = Storage.PerIustitiaAdAstra.Rewards.Map1,
		rewards = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.map1 },
		requiredState = {
			[Storage.PerIustitiaAdAstra.Questline] = 5,
		},
	},
	{
		position = Position(7321, 1269, 5),
		id = 6367,
		actionid = Storage.PerIustitiaAdAstra.Rewards.Map2,
		rewards = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.map2 },
		requiredState = {
			[Storage.PerIustitiaAdAstra.Questline] = 5,
		},
	},
	{
		position = Position(7302, 1086, 7),
		id = 2435,
		actionid = Storage.PerIustitiaAdAstra.Rewards.Map3,
		rewards = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.map3 },
		requiredState = {
			[Storage.PerIustitiaAdAstra.Questline] = 5,
		},
	},
	{ position = DEEPLING_TEMPLE_ANCHOR, id = 8279, aid = Storage.PerIustitiaAdAstra.DeeplingTile },
}

local startupShipEntrances = {
	{
		position = DEEPLING_TEMPLE_ANCHOR:Moved(0, -1, 0),
		id = 8282,
		actionid = Storage.PerIustitiaAdAstra.ShipControl.Enter,
	},
	{ position = FUEL_SHOP_ANCHOR:Moved(-2, 0, 0), id = 8282, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
	{ position = GANYMEDE_ANCHOR:Moved(3, 2, 0), id = 8282, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
	{
		position = HUGO_TAR_PLANET_ANCHOR:Moved(-27, -62, -2),
		id = 8282,
		actionid = Storage.PerIustitiaAdAstra.ShipControl.Enter,
	},

	{ position = HUGO_BEACH_PLANET_ANCHOR:Moved(0, -39, -5), id = 15469, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
	{ position = HUGO_BEACH_PLANET_ANCHOR:Moved(-4, -35, -5), id = 15469, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
	{ position = HUGO_BEACH_PLANET_ANCHOR:Moved(4, -35, -5), id = 15469, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
	{ position = HUGO_BEACH_PLANET_ANCHOR:Moved(0, -30, -5), id = 15469, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
}

local startupGanymede = {
	{
		pos = { 6, 92, 0 },
		id = 11810,
		actionid = Storage.PerIustitiaAdAstra.Rewards.SwagierCrate,
		rewards = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.swagierCrate },
		requiredState = { [Storage.PerIustitiaAdAstra.Questline] = 8 },
		nextState = { [Storage.PerIustitiaAdAstra.Questline] = 9, [Storage.PerIustitiaAdAstra.Mission03] = 4 },
	},
}

local startupHugoTarPlanet = {
	{
		pos = { -39, -17, -2 },
		id = 17355,
		actionid = Storage.PerIustitiaAdAstra.Rewards.OfficerId,
		rewards = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.officerId },
		requiredState = { [Storage.PerIustitiaAdAstra.Questline] = 11 },
		nextState = { [Storage.PerIustitiaAdAstra.Questline] = 12, [Storage.PerIustitiaAdAstra.Mission05] = 3 },
	},
}

local startupItemsHugoBeachPlanet = {
	{
		pos = { 20, -84, -6 },
		id = 2482,
		actionid = Storage.PerIustitiaAdAstra.Rewards.HugoRecipe,
		rewards = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.hugoRecipe },
		requiredState = { [Storage.PerIustitiaAdAstra.Questline] = 18 },
		nextState = { [Storage.PerIustitiaAdAstra.Questline] = 19, [Storage.PerIustitiaAdAstra.Mission05] = 4 },
	},
	{ pos = { 16, -78, 2 }, id = 2472, aid = Storage.PerIustitiaAdAstra.MysteriousChest },
	{
		pos = { 17, -68, -5 },
		id = 30304,
		actionid = Storage.PerIustitiaAdAstra.Rewards.LecinaHammer,
		rewards = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.lecinaHammer },
	},
	{ pos = { -10, -133, 6 }, id = 20787, aid = Storage.PerIustitiaAdAstra.HammerUse },
	{ pos = { 60, 81, 0 }, id = 7804, aid = Storage.PerIustitiaAdAstra.RukcaAccess },
}

local startupFuelShop = {
	{ pos = { -2, 0, 0 }, id = 8282, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
}

local startupKuznia = {}

local startupShip = {
	-- actual ship
	{ pos = { 17, 6, -1 }, id = 8282, aid = Storage.PerIustitiaAdAstra.ShipControl.Exit },
	{ pos = { 23, 8, -1 }, id = 20788, aid = Storage.PerIustitiaAdAstra.ShipControl.StartTravelWheel },
	{
		pos = { 20, 6, -1 },
		id = 752,
		actionid = Storage.PerIustitiaAdAstra.ShipControl.ChangeNextDestination,
	},
	{
		pos = { 21, 6, -1 },
		id = 753,
		actionid = Storage.PerIustitiaAdAstra.ShipControl.ChangeNextDestination,
	},
	{
		pos = { 21, 6, -1 },
		id = 752,
		actionid = Storage.PerIustitiaAdAstra.ShipControl.ChangeNextDestination,
	},
	{
		pos = { 22, 6, -1 },
		id = 753,
		actionid = Storage.PerIustitiaAdAstra.ShipControl.ChangeNextDestination,
	},
	{ pos = { 12, 5, -2 }, id = 21125, aid = Storage.PerIustitiaAdAstra.ShipControl.FuelRefillLever },
	{ pos = { 16, 10, -1 }, id = 19389, aid = Storage.PerIustitiaAdAstra.ShipControl.RodMelter },
}

local startupRukca = {
	{ pos = { -31, -1, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
	{ pos = { -30, 0, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
	{ pos = { -32, 1, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
	{ pos = { -29, 1, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
	{ pos = { -30, 2, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
	{ pos = { -32, 3, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
	{ pos = { -31, 3, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
}

local npcsKuznia = { { name = "Qasim", pos = { 0, -12, 0 } } }
local npcHugoTarPlanet = { { pos = { 0, -2, -6 }, name = "Klaus Schwab" }, { pos = { -46, -15, 1 }, name = "Rubelstein" } }
local npcsFuelShop = { { pos = { -7, -25, 0 }, name = "Swagger" } }
local npcHugoBeachPlanet = { { pos = { 13, 28, 0 }, name = "Hugo BoSS" } }
local monstersHugoTarPlanet = {
	{ pos = { -7, 0, 0 }, name = "Hugo House Guard" },
	{ pos = { 0, -1, 0 }, name = "Hugo House Guard" },
	{ pos = { 6, 0, 0 }, name = "Hugo House Guard" },
	{ pos = { -1, -3, -1 }, name = "Hugo House Guard" },
	{ pos = { 6, 0, -1 }, name = "Hugo House Guard" },
	{ pos = { 1, 3, -1 }, name = "Hugo House Guard" },
	{ pos = { -4, -1, -2 }, name = "Hugo House Guard" },
	{ pos = { 3, 1, -4 }, name = "Hugo House Guard" },
	{ pos = { -4, 1, -4 }, name = "Hugo House Guard" },
	{ pos = { -5, 3, 0 }, name = "Hugo House Guard" },
	{ pos = { 1, 4, 0 }, name = "Hugo House Guard" },
	{ pos = { -8, 0, -2 }, name = "Hugo House Guard" },
}
local monstersKuznia = { { name = "ali baba door", pos = { 6, 19, -1 } } }

local function loadFuelShopDoorFloor()
	local topLeft = FUEL_SHOP_ANCHOR:Moved(-2, -20, 0)
	local downRight = FUEL_SHOP_ANCHOR:Moved(1, -18, 0)
	IterateBetweenPositions(topLeft, downRight, function(context)
		local pos = context.pos
		local tile = Tile(pos)
		if not tile then
			return
		end
		local item = tile:getGround()
		if not item then
			return
		end
		item:setActionId(Storage.PerIustitiaAdAstra.CpnDoor)
	end)
end

local function loadMovingStarTiles()
	local topLeft = STARSHIP_ANCHOR:Moved(0, -78, 0)
	local downRight = STARSHIP_ANCHOR:Moved(0, 17, 0)
	IterateBetweenPositions(topLeft, downRight, function(context)
		local pos = context.pos
		local tile = Tile(pos)
		if not tile then
			return
		end
		local ground = Game.createItem(470, 1, pos)
		ground:setActionId(Storage.PerIustitiaAdAstra.MovingStarTile)
	end)
end

local desertQuestInit = GlobalEvent("perIustitiaAdAstraInit")
function desertQuestInit.onStartup()
	LoadStartupItems(startupStatic)
	LoadStartupItems(startupShipEntrances)
	LoadStartupItems(startupKuznia, USHAYAAN_FORGE_ANCHOR)
	LoadStartupItems(startupShip, STARSHIP_ANCHOR)
	LoadStartupItems(startupFuelShop, FUEL_SHOP_ANCHOR)
	LoadStartupItems(startupGanymede, GANYMEDE_ANCHOR)
	LoadStartupItems(startupHugoTarPlanet, HUGO_TAR_PLANET_ANCHOR)
	LoadStartupItems(startupItemsHugoBeachPlanet, HUGO_BEACH_PLANET_ANCHOR)
	LoadStartupItems(startupRukca, RUKCA_ANCHOR)

	LoadStartupNpcs(npcsKuznia, USHAYAAN_FORGE_ANCHOR)
	LoadStartupNpcs(npcsFuelShop, FUEL_SHOP_ANCHOR)
	LoadStartupNpcs(npcHugoTarPlanet, HUGO_TAR_PLANET_ANCHOR)
	LoadStartupNpcs(npcHugoBeachPlanet, HUGO_BEACH_PLANET_ANCHOR)

	LoadStartupMonsters(monstersKuznia, USHAYAAN_FORGE_ANCHOR)
	LoadStartupMonsters(monstersHugoTarPlanet, HUGO_TAR_PLANET_ANCHOR)

	loadMovingStarTiles()
	loadFuelShopDoorFloor()
end
desertQuestInit:register()
end)
