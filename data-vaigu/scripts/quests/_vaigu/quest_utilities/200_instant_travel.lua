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

local posToData = {}
local function initializeRoutes(routes)
	for _, route in pairs(routes) do
		for i = 1, #route.positions do
			local fromPos = route.positions[i]
			local toPos = route.positions[i + 1] or route.positions[1] -- Loop back to 1 if out of bounds

			local travelItem = fromPos:GetTopItem()
			if travelItem then
				travelItem:setKey(Storage.InstantTravel)
				travelItem:setUniqueId(1000)

				posToData[fromPos:ToString()] = { toPos = toPos, requiredState = route.requiredState }
			else
				logger.warn(T("[instantTravelInit] Cannot find travel item at position :pos:", { pos = fromPos:ToString() }))
			end
		end
	end
end

local pseudoQuest = Quest(LOCALIZERS.NONE)
pseudoQuest
	:NoQuestlog()
	:Script(function()
		--Boat behind house, Island trolls archipelago
		InstantTravel({ positions = { Position(7143, 944, 7), Position(7014, 906, 7) } }):Register()
		--Hellfire spawn cave entrance, Mercury blob rocks
		InstantTravel({ positions = { Position(7468, 1014, 7), Position(7645, 974, 7) } }):Register()
		--Nomad city, Amazon camp, Swamp trolls shore
		InstantTravel({ positions = { Position(7122, 1323, 7), Position(7181, 1272, 7), Position(7256, 1146, 8) } }):Register()
		--Orc port, Orc fortress
		InstantTravel({ positions = { Position(7804, 1381, 7), Position(7775, 1299, 7) } }):Register()
		--Warlocks, Dark Magician ruins
		InstantTravel({ positions = { Position(7633, 1613, 8), Position(7724, 1629, 8) } }):Register()
		--Tarnished spirit rocks, Feverish citizen peninsula, Stone Golem mountain
		InstantTravel({ positions = { Position(7578, 1268, 7), Position(7701, 1206, 7), Position(7682, 1178, 7) } }):Register()
		--Orshaawa deep underground, Magicians dungeon southwest of Bydgoshch
		InstantTravel({ positions = { Position(7644, 1837, 12), Position(7659, 1635, 14) } }):Register()
		--Hidden Caribbean cave, Megadragon cliffs cave
		InstantTravel({ positions = { Position(7426, 1463, 7), Position(7429, 1427, 7) } }):Register()
		--Banshee caves, Grim reaper caves
		InstantTravel({ positions = { Position(7440, 1362, 10), Position(7451, 1376, 11) } }):Register()
		--Steppes village, Gertrude abode
		InstantTravel({ positions = { Position(6233, 1034, 7), Position(6382, 914, 7) } }):Register()
		--Chester caves 1
		InstantTravel({ positions = { Position(6668, 1123, 8), Position(6560, 1082, 9) } }):Register()
		--Chester caves 2
		InstantTravel({ positions = { Position(6606, 1079, 12), Position(6649, 1108, 10) } }):Register()
		--Magician rock Mirkotown, Outlaw camp east
		InstantTravel({ positions = { Position(6011, 1379, 7), Position(6017, 1424, 7) } }):Register()
		--Mirko hero cave, Drillworms
		InstantTravel({ positions = { Position(5983, 1412, 10), Position(6155, 1454, 8) } }):Register()
		--Drillworms, Hellspawns
		InstantTravel({ positions = { Position(6179, 1390, 8), Position(6074, 1284, 10) } }):Register()
		--Retro mirko blood pool, Retro south orc fortress
		InstantTravel({ positions = { Position(4705, 891, 7), Position(4897, 1243, 7) } }):Register()
		--Steppes cave, Carnisylvan
		InstantTravel({ positions = { Position(32529, 32489, 11), Position(6167, 992, 8) } }):Register()

		--Grappling hook north
		InstantTravel({ positions = { Position(6041, 1253, 5), Position(6032, 1254, 5) }, requiredState = { [Storage.GrapplingHook] = ACCESS_GRANTED } }):Register()
		--Grappling hook east
		InstantTravel({ positions = { Position(6081, 1268, 3), Position(6088, 1268, 3) }, requiredState = { [Storage.GrapplingHook] = ACCESS_GRANTED } }):Register()

		local instantTravelInit = GlobalEvent("instantTravelInit")
		function instantTravelInit.onStartup()
			initializeRoutes(allRoutes)
		end
		instantTravelInit:register()
	end)
	:Register()

local function onTravelItemuse(player, fromPosition)
	if isPlayerPzLocked(player) then
		SendPlayerIsPzLocked(player)
		return false
	end

	local travelItemData = posToData[fromPosition:ToString()]
	local requiredStorages = travelItemData.requiredState
	if requiredStorages and not player:HasRequiredStates(requiredStorages) then
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
		return DO_SHOW_ONLOOK
	end
	onTravelItemuse(player, toPosition)
	return DONT_SHOW_ONLOOK
end
travelItemLook:key(Storage.InstantTravel)
travelItemLook:blockWalls()
travelItemLook:register()
