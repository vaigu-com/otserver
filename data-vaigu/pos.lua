---@class Position
---@field x integer
---@field y integer
---@field z integer
Position = Position
Position.__eq = function(pos1, pos2)
	local xEq = pos1.x == pos2.x
	local yEq = pos1.y == pos2.y
	local zEq = pos1.z == pos2.z
	return xEq and yEq and zEq
end

function Position.isPosition(obj)
	return getmetatable(obj) == getmetatable(Position)
end

function Position.hasValidCoords(obj)
	if not obj or type(obj) ~= "table" then
		return false
	end

	if not (obj.x and obj.y and obj.z) then
		return false
	end

	if obj.x <= 0 or obj.y <= 0 then
		return false
	end

	if obj.z < 0 then
		return false
	end

	return true
end

function Player:teleportToStoredOrTemple(storage, sendMagicEffect)
	local posTab = self:getStorageValueByKeyRaw(storage)
	if not Position.hasValidCoords(posTab) then
		self:teleportTo(self:getTown():getTemplePosition(), true)
		return false
	end

	local pos = Position(posTab)
	self:teleportTo(pos)
	if sendMagicEffect ~= false then
		pos:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

---@class Area
---@field positions Position[]
---@field corner1 Position
---@field corner2 Position
Area = {}
Area.__index = Area
---@param corner1 Position
---@param corner2 Position
---@return Area newObj
function Area.New(corner1, corner2)
	local newObj = {}
	newObj.corner1 = corner1
	newObj.corner2 = corner2
	setmetatable(newObj, Area)
	return newObj
end
setmetatable(Area, {
	__call = function(t, ...)
		return Area.New(...)
	end,
})
---@param pos Position
---@param radius number
---@return Area
function Area.FromSquareRadius(pos, radius)
	radius = radius or 1
	local corner1 = pos:Moved(-radius, -radius)
	local corner2 = pos:Moved(radius, radius)
	return Area(corner1, corner2)
end

function Area:GetPositions()
	local positions = {}
	IterateBetweenPositions(self.corner1, self.corner2, function(context)
		local pos = context.pos
		table.append(positions, pos)
	end)
	return positions
end

function Area:GetCorners()
	return self.corner1, self.corner2
end

function Area:RandomPosition()
	return RandomPositionBetween(self.corner1, self.corner2)
end

---@class CreatureList
---@field creatures table
CreatureList = {}
CreatureList.__index = CreatureList

setmetatable(CreatureList, {
	__call = function(class, creatures)
		local instance = setmetatable({}, class)
		instance.creatures = creatures or {}
		return instance
	end,
})

function CreatureList:Get()
	return self.creatures
end

function reverse_pairs(t)
	local i = #t + 1
	return function()
		i = i - 1
		if i > 0 then
			return i, t[i]
		end
	end
end
function CreatureList:Flip()
	local flipped = {}
	for _, value in reverse_pairs(self:Get()) do
		table.insert(flipped, value)
	end
	self.creatures = flipped
	return self
end

function CreatureList:GetRandom()
	return table.random(self.creatures)
end

function CreatureList:Count()
	return TableSize(self.creatures)
end

function CreatureList.FromDamageMap(damageMap)
	local creatureList = CreatureList()
	for key in pairs(damageMap) do
		local creature = Creature(key)
		if creature then
			creatureList:Add(creature)
		end
	end
	return creatureList
end

function CreatureList:Add(creature)
	if table.contains(self.creatures, creature) then
		return self
	end
	table.insert(self.creatures, creature)
	return self
end

function CreatureList:Pos(pos)
	local tile = Tile(pos)
	if not tile then
		return
	end
	local creatures = tile:getCreatures()
	for _, creature in pairs(creatures) do
		self:Add(creature)
	end
	return self
end

function CreatureList:Area(area)
	local pos1, pos2 = area:GetCorners()
	IterateBetweenPositions(pos1, pos2, function(context)
		local tile = Tile(context.pos)
		if not tile then
			return
		end
		local creatures = tile:getCreatures()
		for _, creature in pairs(creatures) do
			self:Add(creature)
		end
	end)
	return self
end

function CreatureList:RadiusSquare(pos, radiusX, radiusY)
	radiusY = radiusY or radiusX
	local pos1 = pos:Moved(radiusX, radiusY)
	local pos2 = pos:Moved(-radiusX, -radiusY)
	self:Area(Area(pos1, pos2))
	return self
end

function CreatureList:MovedToPos(destination)
	for _, creature in pairs(self.creatures) do
		creature:teleportTo(destination)
	end
	return self
end

function CreatureList:MovedByVector(vector)
	for _, creature in pairs(self.creatures) do
		local pos = creature:getPosition()
		creature:teleportTo(pos:Moved(vector))
	end
	return self
end

function CreatureList:FilterByName(name)
	if name == nil then
		return self
	end
	name = name:lower()
	for key, creature in pairs(self.creatures) do
		if creature:getName():lower() ~= name then
			self.creatures[key] = nil
		end
	end
	return self
end

function CreatureList:First()
	local _, result = next(self.creatures, nil)
	return result
end

function CreatureList:Filter(predicate, requiredOutcome)
	for key, creature in pairs(self.creatures) do
		if predicate(creature) ~= requiredOutcome then
			self.creatures[key] = nil
		end
	end
	return self
end

function CreatureList:FilterByPlayer()
	for key, creature in pairs(self.creatures) do
		if not creature:isPlayer() then
			self.creatures[key] = nil
		end
	end
	return self
end

function CreatureList:FilterByMonster()
	for key, creature in pairs(self.creatures) do
		if not creature:isMonster() then
			self.creatures[key] = nil
		end
	end
	return self
end

function CreatureList:FilterByNpc()
	for key, creature in pairs(self.creatures) do
		if not creature:isNpc() then
			self.creatures[key] = nil
		end
	end
	return self
end

function CreatureList:FilterByVocation(vocation)
	for key, value in pairs(self.creatures) do
		if not value:isVocation(vocation) then
			self.creatures[key] = nil
		end
	end
	return self
end

function Position:CreaturesBetween(destination, name)
	local creatures = CreatureList():Area(Area(self, destination)):FilterByName(name)
	return creatures
end

function Position:PlayersBetween(destination, name)
	local players = CreatureList():Area(Area(self, destination)):FilterByName(name):FilterByPlayer()
	return players
end

function Position:MonstersBetween(destination, name)
	local monsters = CreatureList():Area(Area(self, destination)):FilterByName(name):FilterByMonster()
	return monsters
end

function Position:NpcsBetween(destination, name)
	local npcs = CreatureList():Area(Area(self, destination)):FilterByName(name):FilterByNpc()
	return npcs
end

function Position:FirstCreatureBetween(destination, name)
	local creature = CreatureList():Area(Area(self, destination)):FilterByName(name):First()
	return creature
end

function Position:FirstPlayerBetween(destination, name)
	local player = CreatureList():Area(Area(self, destination)):FilterByName(name):FilterByPlayer():First()
	return player
end

function Position:FirstMonsterBetween(destination, name)
	local monster = CreatureList():Area(Area(self, destination)):FilterByName(name):FilterByMonster():First()
	return monster
end

function Position:FirstNpcBetween(destination, name)
	local npc = CreatureList():Area(Area(self, destination)):FilterByName(name):FilterByNpc():First()
	return npc
end

function Position:CountPlayersBetween(destination)
	return #(self:PlayersBetween(destination))
end

function Position:MoveThings(destination)
	self:MoveCreatures(destination)
	self:MoveItems(destination)
end

function Position:MoveCreatures(destination, name)
	CreatureList():Area(Area(self, self)):FilterByName(name):MovedToPos(destination)
end

function Position:MovePlayers(destination, name)
	CreatureList():Area(Area(self, self)):FilterByName(name):FilterByPlayer():MovedToPos(destination)
end

function Position:MoveMonsters(destination, name)
	CreatureList():Area(Area(self, self)):FilterByName(name):FilterByMonster():MovedToPos(destination)
end

function Position:MoveNpcs(destination, name)
	CreatureList():Area(Area(self, self)):FilterByName(name):FilterByNpc():MovedToPos(destination)
end

function Position:MoveItems(destination)
	local tile = Tile(self)
	local items = tile:getItems()
	for _, item in pairs(items) do
		item:moveTo(destination)
	end
end

function Position:MovedInDirection(direction, magnitude)
	local vector = Vector.FromDirection(direction):Scaled(magnitude)
	return self:Moved(vector)
end
local directionToReversed = {
	[DIRECTION_NORTH] = DIRECTION_SOUTH,
	[DIRECTION_NORTHEAST] = DIRECTION_SOUTHWEST,
	[DIRECTION_EAST] = DIRECTION_WEST,
	[DIRECTION_SOUTHEAST] = DIRECTION_NORTHWEST,
	[DIRECTION_SOUTH] = DIRECTION_NORTH,
	[DIRECTION_SOUTHWEST] = DIRECTION_NORTHEAST,
	[DIRECTION_WEST] = DIRECTION_EAST,
	[DIRECTION_NORTHWEST] = DIRECTION_SOUTHEAST,
	[DIRECTION_NONE] = DIRECTION_NONE,
}
function Position:MovedInDirectionReversed(direction, magnitude)
	local vector = Vector.FromDirection(directionToReversed[direction]):Scaled(magnitude)
	return self:Moved(vector)
end

function Position:MoveInDirection(direction, magnitude)
	local vector = Vector.FromDirection(direction):Scaled(magnitude)
	self:Move(vector)
	return self
end

function Position:CreateItem(id, count)
	Game.createItem(id, count, self)
end

function Position:RemoveItem(id)
	self:removeItem(id)
end
function Position:IsWalkable(a, b, c, d, e)
	local tile = Tile(self)
	if not tile then
		return false
	end

	return tile:isWalkable(a, b, c, d, e)
end

local function xyzBoundaries(pos1, pos2)
	local lowX, lowY, lowZ = pos1:ToXYZ()
	local highX, highY, highZ = pos2:ToXYZ()
	if pos1.x > pos2.x then
		highX = pos1.x
		lowX = pos2.x
	end
	if pos1.y > pos2.y then
		highY = pos1.y
		lowY = pos2.y
	end
	if pos1.z > pos2.z then
		highZ = pos1.z
		lowZ = pos2.z
	end

	return lowX, lowY, lowZ, highX, highY, highZ
end

local function calculateSlopeAB(pos1, pos2, flipAxis)
	local a = (pos2.y - pos1.y) / (pos2.x - pos1.x)
	local b = pos1.y - a * pos1.x

	if flipAxis then
		a = (pos2.x - pos1.x) / (pos2.y - pos1.y)
		b = pos1.x - a * pos1.y
	end

	return a, b
end

local function calculateDxDy(pos1, pos2)
	local dx = pos1.x - pos2.x
	local dy = pos1.y - pos2.y
	dx = math.abs(dx)
	dy = math.abs(dy)
	return dx, dy
end

function Position:CalculatePositionsOnSlope(destination)
	local dx, dy = calculateDxDy(self, destination)
	local highestAxisDiff = dx
	local flipAxis = false
	if dy > dx then
		highestAxisDiff = dy
		flipAxis = true
	end

	local a, b = calculateSlopeAB(self, destination, flipAxis)

	local lowX, lowY, lowZ, highX, highY, highZ = xyzBoundaries(self, destination)
	if lowZ ~= highZ then
		logger.debug("[Position:CalculatePositionsOnSlope] positions have different z")
	end

	local positions = {}
	local z = lowZ
	if highestAxisDiff == dx then
		for x = lowX, highX do
			local pos = Position(x, a * x + b, z)
			table.insert(positions, pos)
		end
	else
		for y = lowY, highY do
			local pos = Position(a * y + b, y, z)
			table.insert(positions, pos)
		end
	end

	return positions, dx, dy, flipAxis
end

local function calculateIds(dx, dy, verticalId, horizontalId)
	if dx >= dy then
		return horizontalId, verticalId
	else
		return verticalId, horizontalId
	end
end

local function drawTest(positions, dx, dy, verticalId, horizontalId)
	local firstId, secondId = calculateIds(dx, dy, verticalId, horizontalId)
	local items = ItemExList()

	for i = 1, #positions - 1 do
		local currentPos = positions[i + 0]
		local nextPos = positions[i + 1]

		local firstItem = Game.createItem(firstId, 1, currentPos)
		local secondItem = Game.createItem(secondId, 1, nextPos)

		items:Add(firstItem)
		items:Add(secondItem)
	end
	return items
end

function Position:DrawLine(destination, verticalId, horizontalId, removeAfterSeconds)
	local positions, dx, dy = self:CalculatePositionsOnSlope(destination)

	local items = drawTest(positions, dx, dy, verticalId, horizontalId)
	if removeAfterSeconds then
		addEvent(function()
			if items then
				items:Remove()
			end
		end, removeAfterSeconds)
	end
end

---comment
---@param fromPos Position
---@param toPos Position
---@return boolean
function IsMoveDiagonal(fromPos, toPos)
	local dir = fromPos:DirectionTo(toPos)
	if dir >= 4 and dir <= 7 then
		return true
	end
	return false
end

function Position:VectorTo(dest)
	local dx = dest.x - self.x
	local dy = dest.y - self.y
	local dz = dest.z - self.z
	return Vector(dx, dy, dz)
end

--[x][y]
local diffToDir = {
	[1] = {
		[1] = DIRECTION_SOUTHEAST,
		[-1] = DIRECTION_NORTHEAST,
		[0] = DIRECTION_EAST,
	},
	[-1] = {
		[1] = DIRECTION_SOUTHWEST,
		[-1] = DIRECTION_NORTHWEST,
		[0] = DIRECTION_WEST,
	},
	[0] = { [1] = DIRECTION_SOUTH, [-1] = DIRECTION_NORTH, [0] = DIRECTION_NONE },
}

function Position:DirectionTo(toPos)
	local fromX = self.x
	local fromY = self.y

	local toX = toPos.x
	local toY = toPos.y

	local dx = Signum(toX - fromX)
	local dy = Signum(toY - fromY)

	return diffToDir[dx][dy]
end

---@param radius integer abs of radius value will be used
---@return Position|nil unoccupiedPos
function Position:FindAnyUnoccupiedSpot(radius)
	radius = radius or 1
	if radius < 0 then
		logger.warn("[Position:FindAnyUnoccupiedSpot] radius less than 0")
	end

	local selfTile = Tile(self)
	if selfTile and selfTile:isWalkable(false, false, true, false, false) then
		return self
	end

	local pos1, pos2 = self:GetBoundariesByRadius(radius)

	local unoccupiedPos = IterateBetweenPositions(pos1, pos2, function(context)
		local pos = context.pos
		local tile = Tile(pos)
		if tile and tile:isWalkable(false, false, true, false, false) then
			return pos
		end
	end, { stopCondition = STOP_CONDITIONS.isNotNull })
	return unoccupiedPos
end

---@return Creature|nil creature
function Position:GetTopCreature()
	local tile = Tile(self)
	if not tile then
		return nil
	end
	return tile:getTopCreature()
end

---@return Player|nil creature
function Position:GetTopPlayer()
	local tile = Tile(self)
	if not tile then
		return nil
	end

	local creature = tile:getTopCreature()
	if not creature then
		return nil
	end

	return creature:getPlayer()
end

---@return Monster|nil creature
function Position:GetTopMonster()
	local tile = Tile(self)
	if not tile then
		return nil
	end

	local creature = tile:getTopCreature()
	if not creature then
		return nil
	end

	return creature:getMonster()
end

function Position:GetItemById(id)
	local tile = Tile(self)
	if not tile then
		return
	end
	return tile:getItemById(id)
end

---@param vectors Vector[]
---@param anchor Position
---@return Position[]
function VectorsMovedByAnchor(vectors, anchor)
	local positions = {}
	for _, vector in pairs(vectors) do
		local movedPos = anchor:Moved(vector)
		table.insert(positions, movedPos)
	end
	return positions
end

function Position:GetBoundariesByRadius(radius)
	local topLeft = self:Moved(-radius, -radius, 0)
	local downRight = self:Moved(radius, radius, 0)
	return topLeft, downRight
end

---@param destination Position
---@return Vector vector
function Position:VectorBetween(destination)
	local vector = Vector()
	vector.x = self.x - destination.x
	vector.y = self.y - destination.y
	vector.z = self.z - destination.z
	return vector
end

function Position:ToOffset(anchor)
	local offset = {}
	offset.x = self.x - anchor.x
	offset.y = self.y - anchor.y
	offset.z = self.z - anchor.z
	return offset
end

function OffsetToString(offset)
	local result = ""
	result = result .. tostring(offset.x) .. ", " .. tostring(offset.y) .. ", " .. tostring(offset.z)
	return result
end

function Position:ToXYZ()
	return self.x, self.y, self.z
end

local function parseStopCondition(stopCondition, lastResult)
	if stopCondition == nil then
		return false
	end
	return stopCondition(lastResult)
end

STOP_CONDITIONS = {
	isNull = function(...)
		return ... == nil
	end,
	isNotNull = function(...)
		return ... ~= nil
	end,
	isTrue = function(...)
		return ... == true
	end,
	isFalse = function(...)
		return ... == false
	end,
}

local function processPosition(context)
	local lastResult = context.callback(context)
	if parseStopCondition(context.stopCondition, lastResult) then
		return lastResult, true
	end

	return lastResult, false
end

---@class IterateContext
---@field pos Position
---@field i integer

---@param pos1 Position
---@param pos2 Position
---@param callback fun(context: IterateContext): any
---@param context table|nil
---@return any, table|nil
function IterateBetweenPositions(pos1, pos2, callback, context)
	if not (IsPosition(pos1) and IsPosition(pos2) and callback) then
		logger.debug("[IterateBetweenPositions] pos1 or pos2 is not a position or callback is nil")
		return nil
	end

	local lowX, lowY, lowZ, highX, highY, highZ = xyzBoundaries(pos1, pos2)
	local lastResult = nil
	local done = false
	local i = 0

	context = context or {}
	context.lowX = lowX
	context.lowY = lowY
	context.lowZ = lowZ
	context.callback = callback

	for currentX = lowX, highX do
		for currentY = lowY, highY do
			for currentZ = lowZ, highZ do
				i = i + 1
				context.i = i
				local pos = Position(currentX, currentY, currentZ)
				context.pos = pos
				lastResult, done = processPosition(context)
				if done then
					return lastResult, context
				end
			end
		end
	end
	return lastResult, context
end

function Position:EuclideanDistance(dest)
	local x2 = (self.x - dest.x) ^ 2
	local y2 = (self.y - dest.y) ^ 2
	local z2 = (self.z - dest.z) ^ 2
	local distance = math.sqrt(x2 + y2 + z2)
	return distance
end

function Position:ManhattanDistance(dest)
	local x = math.abs(self.x - dest.x)
	local y = math.abs(self.y - dest.y)
	local z = math.abs(self.z - dest.z)
	local distance = x + y + z
	return distance
end

function Position:ChebyshevDistance(dest)
	local x = math.abs(self.x - dest.x)
	local y = math.abs(self.y - dest.y)
	local z = math.abs(self.z - dest.z)
	local distance = math.max(x, y, z)
	return distance
end

function Position:GetDistanceVector(dest)
	local vector = self:VectorTo(dest):Abs()
	return vector.x, vector.y, vector.z
end

local function randomClamp(a, b)
	local lower = math.min(a, b)
	local upper = math.max(a, b)
	return math.random(lower, upper)
end
function RandomPositionBetween(pos1, pos2)
	return Position(randomClamp(pos1.x, pos2.x), randomClamp(pos1.y, pos2.y), randomClamp(pos1.z, pos2.z))
end

function IsPosition(obj)
	return getmetatable(obj) == Position
end

function Position:GetGroundId()
	local ground = self:GetGround()
	if ground then
		return ground:getId()
	end
	return NO_GROUND_ID
end

function Position:GetGround()
	local tile = Tile(self)
	if not tile then
		return
	end
	local ground = tile:getGround()
	return ground
end

function Position:GetTopItem()
	local tile = Tile(self)
	if not tile then
		return nil
	end
	local topThing = tile:getTopVisibleThing()
	if not topThing then
		return nil
	end
	if not topThing:isItem() then
		return nil
	end

	return topThing
end

function Position:GetPlayers()
	local tile = Tile(self)
	if not tile then
		return {}
	end
	return tile:getPlayers()
end

function Signum(val)
	if type(val) ~= "number" then
		return nil
	end
	if val > 0 then
		return 1
	end
	if val < 0 then
		return -1
	end
	return 0
end

function PrintPosition(pos, verbose)
	if not (pos.x and pos.y and pos.z) then
		logger.debug("[PrintPosition] Wrong position format")
		print("", debug.traceback())
	end
	if verbose then
		print("x: " .. pos.x, "y: " .. pos.y, "z: " .. pos.z)
		return
	end
	print(pos.x, pos.y, pos.z)
end

function Position:IsPathable(dontPathPz, dontPathOnTopOfOtherCreature)
	local tile = Tile(self)
	if not tile then
		return false
	end

	if dontPathPz then
		if tile:hasFlag(TILESTATE_PROTECTIONZONE) then
			return false
		end
	end

	if dontPathOnTopOfOtherCreature then
		if tile:getTopCreature() then
			return false
		end
	end

	-- if tile:hasFlag(TILESTATE_MAGICFIELD) then end

	if tile:hasFlag(TILESTATE_BLOCKSOLID) then
		return false
	end

	return true
end

---@param radius number
---@param name string?
function Position:GetFirstNpcInRadius(radius, name)
	local corner1, corner2 = self:GetBoundariesByRadius(radius)
	return CreatureList():Area(Area(corner1, corner2)):First()
end

function PlayersPresentAtAllPositions(positions, anchor)
	for _, pos in pairs(positions) do
		pos = pos.offPos or pos.pos or pos.position or pos
		if anchor then
			pos = anchor:Moved(pos)
		end
		local player = CreatureList():Pos(pos):FilterByPlayer():First()
		if not player then
			return
		end
	end
	return true
end

function ExtractCoords(...)
	local x, y, z
	if type(...) == "table" then
		x = (...).x or (...)[1]
		y = (...).y or (...)[2]
		z = (...).z or (...)[3]
	else
		local arg = { ... }
		x = arg[1]
		y = arg[2]
		z = arg[3]
	end

	return { x = x, y = y, z = z }
end

---@param corner1 Position
---@param corner2 Position
---@return boolean _ if original position lays somewhere between the corners
function Position:IsBetween(corner1, corner2)
	local lowX, lowY, lowZ, highX, highY, highZ = xyzBoundaries(corner1, corner2)

	if self.x < lowX or self.x > highX then
		return false
	end
	if self.y < lowY or self.y > highY then
		return false
	end
	if self.z < lowZ or self.z > highZ then
		return false
	end
	return true
end

---@param vectorOrX number|Vector|Position passing vector will ignore other params
---@param y number|nil
---@param z number|nil
---@return Position self origial position moved by the vector or the x, y, z
function Position:Move(vectorOrX, y, z)
	local offset = ExtractCoords(vectorOrX, y, z)
	self.x = self.x + (offset.x or 0)
	self.y = self.y + (offset.y or 0)
	self.z = self.z + (offset.z or 0)
	return self
end

---@param vectorOrX number|Vector|Position passing vector/position will ignore other params
---@param y number|nil
---@param z number|nil
---@return Position moved deepcopy of origial position moved by the vector or the x, y, z
function Position:Moved(vectorOrX, y, z)
	local offset = ExtractCoords(vectorOrX, y, z)
	local pos = {}
	pos.x = self.x + (offset.x or 0)
	pos.y = self.y + (offset.y or 0)
	pos.z = self.z + (offset.z or 0)
	local moved = Position(pos)
	return moved
end

---@param inputSeparator string|nil one character or many characters eg. ", "
function Position:ToString(inputSeparator)
	local separator = inputSeparator or ", "
	local x = string.format("%05d", self.x)
	local y = string.format("%05d", self.y)
	local z = string.format("%05d", self.z)
	return x .. separator .. y .. separator .. z
end

function Position:ToNumber()
	local result = 0
	result = result + self.x * 10 ^ 10
	result = result + self.y * 10 ^ 5
	result = result + self.z * 10 ^ 0
	return result
end

function Position:MovedByVector(vector)
	return self:Moved(vector)
end

DESERT_QUEST_HUB_ANCHOR = Position(6795, 1275, 9)
DESERT_QUEST_ONE_ANCHOR = Position(5158, 866, 11)
DESERT_QUEST_TWO_ANCHOR = Position(4670, 2565, 7)
RUBIKS_CUBE_ANCHOR = DESERT_QUEST_TWO_ANCHOR:Moved(-20, -39, -3)

RETRO_MIRKO_ANCHOR = Position(4750, 856, 7)
MIRKO_MAGICIANS_ANCHOR = Position(6029, 1338, 6)

KING_OF_RATS_HQ_ANCHOR = Position(5465, 1546, 10)
LIBRUM_VORTEX_ANCHOR = Position(6802, 1224, 10)
PATH_OF_THE_UNDEAD_ANCHOR = Position(6645, 1177, 14)

PETRUS_CIEMIEZCA_ANCHOR = Position(6078, 1349, 2)
THREE_SRAMATIANS_AND_THE_DRAGON_ANCHOR = Position(6788, 547, 13)
RETRO_KNUROWO_ANCHOR = Position(4445, 859, 7)
KRAKEN_ANCHOR = Position(5974, 1177, 6)
SKURWIWIJ_ANCHOR = Position(6534, 536, 9)
ZUL_SZCZUROW_ANCHOR = Position(6006, 1382, 13)

USHAYAAN_FORGE_ANCHOR = Position(6657, 1066, 15)
STARSHIP_ANCHOR = Position(7356, 789, 7)
DEEPLING_TEMPLE_ANCHOR = Position(33452, 31178, 14)
FUEL_SHOP_ANCHOR = Position(7369, 671, 6)
GANYMEDE_ANCHOR = Position(7910, 295, 6)
HUGO_TAR_PLANET_ANCHOR = Position(7717, 244, 7)
HUGO_BEACH_PLANET_ANCHOR = Position(7488, 263, 7)
RUKCA_ANCHOR = Position(7594, 114, 8)

JANUSZEX_MOVING_TRAIN_ANCHOR = Position(6400, 1126, 13)
JANUSZEX_ANCHOR = Position(7687, 1025, 10)

CHESS_ANCHOR = Position(1428, 1302, 8)
FNAF_ANCHOR = Position(5227, 1035, 8)
