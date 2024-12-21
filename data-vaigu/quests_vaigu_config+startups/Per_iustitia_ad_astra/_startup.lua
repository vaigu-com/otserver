BANJO_KROLA_SZCZUROW:Script(function(missionState)
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

	LoadStartupMonsters(monstersKuznia, USHAYAAN_FORGE_ANCHOR)
	LoadStartupMonsters(monstersHugoTarPlanet, HUGO_TAR_PLANET_ANCHOR)

	loadMovingStarTiles()
	loadFuelShopDoorFloor()
end
desertQuestInit:register()
end)
