Storage.InstantTravel = {}

local allRoutes = {}

---@class InstantTravel
---@field positions Position[]
---@field storage integer?
InstantTravel = {}
InstantTravel.__index = InstantTravel
function InstantTravel:New(context)
	local newObj = {}
	newObj.positions = context.positions
	newObj.requiredState = context.requiredState
	setmetatable(newObj, self)
	return newObj
end
setmetatable(InstantTravel, {
	__call = function(class, ...)
		return class:New(...)
	end,
})

function InstantTravel:Register()
	table.insert(allRoutes, self)
end

local tileStates = {
	TILESTATE_FLOORCHANGE_NORTH = TILESTATE_FLOORCHANGE_NORTH,
	TILESTATE_FLOORCHANGE_SOUTH = TILESTATE_FLOORCHANGE_SOUTH,
	TILESTATE_FLOORCHANGE_EAST = TILESTATE_FLOORCHANGE_EAST,
	TILESTATE_FLOORCHANGE_WEST = TILESTATE_FLOORCHANGE_WEST,
}
local tilestateToDirection = {
	[TILESTATE_FLOORCHANGE_NORTH] = DIRECTION_NORTH,
	[TILESTATE_FLOORCHANGE_SOUTH] = DIRECTION_SOUTH,
	[TILESTATE_FLOORCHANGE_EAST] = DIRECTION_EAST,
	[TILESTATE_FLOORCHANGE_WEST] = DIRECTION_WEST,
}

local function getDirectionByPosTilestate(pos)
	local tile = Tile(pos)
	if not tile then
		logger.warn(T("[instantTravelInit] Cannot find tile at position :pos:", { pos = pos:ToString() }))
		return nil
	end

	for _, tileState in pairs(tileStates) do
		if tile:hasFlag(tileState) then
			return tilestateToDirection[tileState]
		end
	end
	return nil
end

local posToData = {}
local function initializeRoute(source, destination, requiredState)
	local sourceItem = source:GetTopItem()
	if not sourceItem then
		logger.warn(T("[instantTravelInit] Cannot find travel item at position :pos:", { pos = source:ToString() }))
		return false
	end

	local direction = DIRECTION_NONE
	local directionByDestination = getDirectionByPosTilestate(destination)
	local directionBySource = getDirectionByPosTilestate(source)

	if directionByDestination then
		direction = CalculateOppositeDirection(directionByDestination)
	elseif directionBySource then
		direction = directionBySource
	end

	sourceItem:setKey(Storage.InstantTravel)
	sourceItem:setUniqueId(1000)

	posToData[source:ToString()] = { toPos = destination, requiredState = requiredState, direction = direction }
end

local function initializeRoutes(routes)
	for _, route in pairs(routes) do
		for i = 1, #route.positions do
			local source = route.positions[i]
			local destination = route.positions[i + 1] or route.positions[1] -- Loop back to 1 if out of bounds
			initializeRoute(source, destination, route.requiredState)
		end
	end
end

local pseudoQuest = Quest(LOCALIZERS.NONE)
pseudoQuest
	:NoQuestlog()
	:Script(function()
		local baseRoutes = {
			--Boat behind house, Island trolls archipelago
			InstantTravel({ positions = { Position(7143, 944, 7), Position(7014, 906, 7) } }),
			--Hellfire spawn cave entrance, Mercury blob rocks
			InstantTravel({ positions = { Position(7468, 1014, 7), Position(7645, 974, 7) } }),
			--Nomad city, Amazon camp, Swamp trolls shore
			InstantTravel({ positions = { Position(7122, 1323, 7), Position(7181, 1272, 7), Position(7256, 1146, 8) } }),
			--Orc port, Orc fortress
			InstantTravel({ positions = { Position(7804, 1381, 7), Position(7775, 1299, 7) } }),
			--Warlocks, Dark Magician ruins
			InstantTravel({ positions = { Position(7633, 1613, 8), Position(7724, 1629, 8) } }),
			--Tarnished spirit rocks, Feverish citizen peninsula, Stone Golem mountain
			InstantTravel({ positions = { Position(7578, 1268, 7), Position(7701, 1206, 7), Position(7682, 1178, 7) } }),
			--Orshaawa deep underground, Magicians dungeon southwest of Bydgoshch
			InstantTravel({ positions = { Position(7644, 1837, 12), Position(7659, 1635, 14) } }),
			--Hidden Caribbean cave, Megadragon cliffs cave
			InstantTravel({ positions = { Position(7426, 1463, 7), Position(7429, 1427, 7) } }),
			--Banshee caves, Grim reaper caves
			InstantTravel({ positions = { Position(7440, 1362, 10), Position(7451, 1376, 11) } }),
			--Steppes village, Gertrude abode
			InstantTravel({ positions = { Position(6233, 1034, 7), Position(6382, 914, 7) } }),
			--Chester caves 1
			InstantTravel({ positions = { Position(6668, 1123, 8), Position(6560, 1082, 9) } }),
			--Chester caves 2
			InstantTravel({ positions = { Position(6606, 1079, 12), Position(6649, 1108, 10) } }),
			--Magician rock Mirkotown, Outlaw camp east
			InstantTravel({ positions = { Position(6011, 1379, 7), Position(6017, 1424, 7) } }),
			--Mirko hero cave, Drillworms
			InstantTravel({ positions = { Position(5983, 1412, 10), Position(6155, 1454, 8) } }),
			--Drillworms, Hellspawns
			InstantTravel({ positions = { Position(6179, 1390, 8), Position(6074, 1284, 10) } }),
			--Retro mirko blood pool, Retro south orc fortress
			InstantTravel({ positions = { Position(4705, 891, 7), Position(4897, 1243, 7) } }),
			--Flaming orchid room, True asura palace
			InstantTravel({ positions = { Position(6615, 996, 3), Position(6645, 922, 9) } }),
		}
		for _, route in pairs(baseRoutes) do
			route:Register()
		end

		local realRoutes = {
			--Steppes cave, Carnisylvan
			InstantTravel({ positions = { Position(6186, 994, 8), Position(32529, 32489, 11) } }),
			--Januszex, Claustrophobic inferno
			InstantTravel({ positions = { Position(7780, 749, 15), Position(34011, 31010, 9) } }),
			--Syberia mines, Warzone 7,8,9 hub
			InstantTravel({ positions = { Position(6313, 1882, 13), Position(32666, 31829, 10) } }),
			--Pirate island, Deepling
			InstantTravel({ positions = { Position(6779, 2562, 7), Position(33514, 31323, 8) } }),
			--Steppes, Otherworld
			InstantTravel({ positions = { Position(6101, 1007, 8), Position(32115, 31356, 13) } }),
			--Syberia, Otherworld
			InstantTravel({ positions = { Position(6433, 1757, 8), Position(32112, 31388, 11) } }),
			--Hurghada West, Otherworld
			InstantTravel({ positions = { Position(6448, 1408, 8), Position(32131, 31361, 12) } }),
			--Hurghada East, Otherworld
			InstantTravel({ positions = { Position(6858, 1290, 3), Position(32446, 32390, 10) } }),
			--Mirkotown far south, Otherworld
			InstantTravel({ positions = { Position(6043, 1950, 8), Position(32015, 31357, 11) } }),
			--Elf fortress strong, Summer court
			InstantTravel({ positions = { Position(6025, 1912, 7), Position(33672, 32227, 7) }, requiredState = { [Storage.Quest.U12_00.TheDreamCourts.CourtTeleportAccess] = ACCESS_GRANTED } }),
			--Syberia north golems hill, Winter court
			InstantTravel({ positions = { Position(6580, 1775, 3), Position(33675, 32147, 7) }, requiredState = { [Storage.Quest.U12_00.TheDreamCourts.CourtTeleportAccess] = ACCESS_GRANTED } }),
			--Bydgosch hut, Tormented Soul dungeon - fake normal stairs
			InstantTravel({ positions = { Position(7824, 1388, 7), Position(32688, 32235, 8) }, sendMagicEffect = false }),
			--Caribbean, Faceless Bane dungeon
			InstantTravel({ positions = { Position(32720, 32270, 8), Position(33618, 32546, 13) }, requiredState = { [Storage.Quest.U12_00.TheDreamCourts.HauntedHouse.FacelessBaneAccess] = ACCESS_GRANTED } }),
		}
		for _, route in pairs(realRoutes) do
			route:Register()
		end

		local grapplingRoutes = {
			--Grappling hook north
			InstantTravel({ positions = { Position(6041, 1253, 5), Position(6032, 1254, 5) }, requiredState = { [Storage.GrapplingHook] = ACCESS_GRANTED } }),
			--Grappling hook east
			InstantTravel({ positions = { Position(6081, 1268, 3), Position(6088, 1268, 3) }, requiredState = { [Storage.GrapplingHook] = ACCESS_GRANTED } }),
		}
		for _, route in pairs(grapplingRoutes) do
			route:Register()
		end

		local instantTravelInit = GlobalEvent("instantTravelInit")
		function instantTravelInit.onStartup()
			initializeRoutes(allRoutes)
		end
		instantTravelInit:register()
	end)
	:Register()

local defaultSendMagicEffectBehavior = true
local function tryPerformInstantTravel(player, sourceItemPosition)
	if isPlayerPzLocked(player) then
		SendPlayerIsPzLocked(player)
		return false
	end

	local travelItemData = posToData[sourceItemPosition:ToString()]
	local requiredStorages = travelItemData.requiredState
	if requiredStorages and not player:HasRequiredStates(requiredStorages) then
		return false
	end

	local shouldSendMagicEffect = travelItemData.sendMagicEffect
	if shouldSendMagicEffect == nil then
		shouldSendMagicEffect = defaultSendMagicEffectBehavior
	end

	local toPos = travelItemData.toPos
	local selfTile = Tile(toPos)

	if selfTile and selfTile:isWalkable(false, false, false, false, false) then
		if travelItemData.direction ~= DIRECTION_NONE then
			player:teleportTo(toPos:MovedInDirection(travelItemData.direction, 1))
			player:setDirection(travelItemData.direction)
		else
			player:teleportTo(toPos, false)
		end
	else
		local anyWalkablePos = toPos:FindAnyUnoccupiedSpot()
		player:teleportTo(anyWalkablePos or toPos)
	end

	if shouldSendMagicEffect then
		toPos:sendMagicEffect(CONST_ME_TELEPORT)
	end

	return true
end

local travelItemUse = Action()
function travelItemUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not tryPerformInstantTravel(player, item:getPosition()) then
		player:sendTextMessage(MESSAGE_FAILURE, "You cannot use this yet.")
	end
end
travelItemUse:key(Storage.InstantTravel)
travelItemUse:blockWalls()
travelItemUse:register()

local travelItemLook = Look()
function travelItemLook.onLook(player, item, fromPosition, target, toPosition)
	if fromPosition:ChebyshevDistance(toPosition) > 1 then
		return DO_SHOW_ONLOOK
	end
	
	if not tryPerformInstantTravel(player, item:getPosition()) then
		return DONT_SHOW_ONLOOK
	end
end
travelItemLook:key(Storage.InstantTravel)
travelItemLook:blockWalls()
travelItemLook:register()

local travelItemStepIn = MoveEvent()
function travelItemStepIn.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if fromPosition:ChebyshevDistance(toPosition) > 1 then
		return true
	end

	if not tryPerformInstantTravel(player, item:getPosition()) then
		player:teleportTo(fromPosition)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:say("You don't have access to this teleport yet.", TALKTYPE_MONSTER_SAY)
	end
	return true
end
travelItemStepIn:type("stepin")
travelItemStepIn:key(Storage.InstantTravel)
travelItemStepIn:register()
