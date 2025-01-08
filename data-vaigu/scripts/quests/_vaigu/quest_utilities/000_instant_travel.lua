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

--Boat behind house, Island trolls archipelago
InstantTravel({ positions = { Position(7143, 944, 7), Position(7014, 906, 7) } }):Register()
--Hellfire spawn cave entrance, Mercury blob rocks
InstantTravel({ positions = { Position(7468, 1014, 7), Position(7645, 974, 7) } }):Register()
--Nomad city, Amazon camp, Swamp trolls shore
InstantTravel({ positions = { Position(7122, 1323, 7), Position(7181, 1272, 7), Position(7256, 1146, 8) } }):Register()
--Elf docks, Haunted treeling forest
InstantTravel({ positions = { Position(7619, 1569, 7), Position(7606, 1654, 7) } }):Register()
--Orc port, Orc fortress
InstantTravel({ positions = { Position(7804, 1381, 7), Position(7775, 1299, 7) } }):Register()
--Warlocks, Dark Magician ruins
InstantTravel({ positions = { Position(7633, 1613, 8), Position(7724, 1629, 8) } }):Register()
--Tarnished spirit rocks, Feverish citizen peninsula, Stone Golem mountain
InstantTravel({ positions = { Position(7578, 1268, 7), Position(7701, 1206, 7), Position(7682, 1178, 7) } }):Register()
--Orshaawa deep underground,
InstantTravel({ positions = { Position(7644, 1837, 12), Position(7659, 1635, 14) } }):Register()
--Ruined ship, hermit cave
InstantTravel({ positions = { Position(7426, 1463, 7), Position(7429, 1427, 7) } }):Register()
--Banshee caves, Grim reaper caves
InstantTravel({ positions = { Position(7440, 1362, 10), Position(7451, 1376, 11) } }):Register()
--Mirkotown hero cave, Chester train
InstantTravel({ positions = { Position(6074, 1284, 10), Position(5983, 1412, 10) } }):Register()
--Steppes village, Lizard village
InstantTravel({ positions = { Position(6233, 1034, 7), Position(6382, 914, 7) } }):Register()
--Chester caves 1
InstantTravel({ positions = { Position(6668, 1123, 8), Position(6560, 1082, 9) } }):Register()
--Chester caves 2
InstantTravel({ positions = { Position(6606, 1079, 12), Position(6649, 1108, 10) } }):Register()
--Wyvern cliffs, Killer bunny peninsula
InstantTravel({positions = { Position(6308, 1464, 7),Position(6259, 1396, 7)}}):Register()

local posToData = {}

local function initializeRoutes(routes)
	for _, route in pairs(routes) do
		for i = 1, #route.positions do
			local fromPos = route.positions[i]
			local toPos = route.positions[i + 1] or route.positions[1] -- Loop back to 1 if out of bounds

			local travelItem = fromPos:GetTopItem()
			if not travelItem then
				PrintPosition(fromPos)
			end
			travelItem:setActionId(Storage.InstantTravel)
			travelItem:setUniqueId(1000)

			posToData[fromPos:ToString()] = { toPos = toPos, requiredState = route.requiredState }
		end
	end
end

local instantTravelInit = GlobalEvent("instantTravelInit")
function instantTravelInit.onStartup()
	initializeRoutes(allRoutes)
end
instantTravelInit:register()

local function onTravelItemuse(player, fromPosition)
	if isPlayerPzLocked(player) then
		SendPlayerIsPzLocked(player)
		return false
	end

	local travelItemData = posToData[fromPosition:ToString()]
	local requiredStorages = travelItemData.requiredState
	if requiredStorages and not player:HasCorrectStorageValues(requiredStorages) then
		player:sendTextMessage(MESSAGE_FAILURE, "You cannot use this yet.")
		return false
	end

	local toPos = travelItemData.toPos:FindAnyUnoccupiedSpot() or travelItemData.toPos
	player:teleportTo(toPos)
	toPos:sendMagicEffect(CONST_ME_TELEPORT)
end

local travelItemUse = Action()
function travelItemUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	onTravelItemuse(player, fromPosition)
end
travelItemUse:key(Storage.InstantTravel)
travelItemUse:blockWalls()
travelItemUse:register()

local travelItemLook = Look()
function travelItemLook.onLook(player, item, fromPosition, target, toPosition)
	if fromPosition:EuclideanDistance(toPosition) > 1.5 then
		return false
	end
	onTravelItemuse(player, toPosition)
end
travelItemLook:key(Storage.InstantTravel)
travelItemLook:blockWalls()
travelItemLook:register()
