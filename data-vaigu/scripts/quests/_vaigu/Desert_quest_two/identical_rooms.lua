local topLeft = DESERT_QUEST_TWO_ANCHOR:Moved(-118, -54, 0)
local downRight = DESERT_QUEST_TWO_ANCHOR:Moved(-51, 13, 0)

local vector = topLeft:VectorTo(downRight:Moved(1, 1, 0)):Abs()
local sideSize = 4
local dx = vector.x
local dy = vector.y

if vector.x ~= vector.y or vector.x % sideSize ~= 0 then
	print(debug.traceback("desertquest2 wrong room size"))
end

local function initializeRoom(center)
	for i = -1, 1, 2 do
		local pos = center:Moved(i, 0, 0)
		local floor = Game.createItem(429, 1, pos)
		floor:setActionId(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsTeleport)
	end
	for i = -1, 1, 2 do
		local pos = center:Moved(0, i, 0)
		local floor = Game.createItem(429, 1, pos)
		floor:setActionId(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsTeleport)
	end
	local ladder = Tile(center):getItemById(1948)
	if ladder then
		ladder:remove()
		local floor = Game.createItem(429, 1, center)
		floor:setActionId(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsGoDown)
	end
end

function InitializeDQ2IndeticalRooms()
	for i = 0, dx - 1, sideSize do
		for j = 0, dy - 1, sideSize do
			local roomCenter = topLeft:Moved(i + 1, j + 1, 0)
			initializeRoom(roomCenter)
		end
	end
	local startingRoomCenter = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -21, 0)
	for i = -1, 1, 2 do
		local pos = startingRoomCenter:Moved(i, 0, 0)
		local floor = Game.createItem(409, 1, pos)
		floor:setActionId(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsClassTeleport)
	end
	for i = -1, 1, 2 do
		local pos = startingRoomCenter:Moved(0, i, 0)
		local floor = Game.createItem(409, 1, pos)
		floor:setActionId(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsClassTeleport)
	end
end

local function isPosTeleportable(pos)
	local tilePos = pos:Moved(1, 1, -1)
	local tile = Tile(tilePos)
	return tile
end

local teleportTiles = MoveEvent()
function teleportTiles.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local dir = fromPosition:DirectionTo(toPosition)
	local offset = Vector.FromDirection(dir):scaled(4)
	local newPos = fromPosition:Moved(offset)
	if not isPosTeleportable(newPos) then
		newPos = fromPosition
	end
	player:teleportTo(newPos)
	newPos:sendMagicEffect(CONST_ME_TELEPORT)

	return false
end

teleportTiles:type("stepin")
teleportTiles:aid(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsTeleport)
teleportTiles:register()

local vocIdToPos = {
	[1] = DESERT_QUEST_TWO_ANCHOR:Moved(-113, -21, 0),
	[5] = DESERT_QUEST_TWO_ANCHOR:Moved(-113, -21, 0),
	[2] = DESERT_QUEST_TWO_ANCHOR:Moved(-69, -21, 0),
	[6] = DESERT_QUEST_TWO_ANCHOR:Moved(-69, -21, 0),
	[3] = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -41, 0),
	[7] = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -41, 0),
	[4] = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -17, 0),
	[8] = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -17, 0),
}

local goDownTile = MoveEvent()
function goDownTile.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	creature:teleportTo(toPosition:Moved(0, 0, 1))
	return false
end

goDownTile:type("stepin")
goDownTile:aid(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsGoDown)
goDownTile:register()

local classTile = MoveEvent()
function classTile.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	local classId = creature:getVocation():getId()
	local classPos = vocIdToPos[classId]
	if classPos then
		player:teleportTo(classPos)
	else
		player:teleportTo(fromPosition)
	end
	return false
end

classTile:type("stepin")
classTile:aid(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsClassTeleport)
classTile:register()
