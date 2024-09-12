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

---@class CreatureList
---@field creatures table
---@field customData table
CreatureList = {}
CreatureList.__index = CreatureList

setmetatable(CreatureList, {
	__call = function(class, creatures)
		local instance = setmetatable({}, class)
		instance.creatures = creatures or {}
		instance.customData = {}
		return instance
	end,
})

function CreatureList:Get()
	return self.creatures
end

function CreatureList:Count()
	return TableSize(self.creatures)
end

function CreatureList:Add(creature, customData)
	customData = customData or {}
	self.creatures[customData] = creature
	return self
end

function CreatureList:Pos(pos, customData)
	local tile = Tile(pos)
	if not tile then
		return
	end
	local creatures = tile:getCreatures()
	for _, creature in pairs(creatures) do
		self:Add(creature, customData)
	end
	return self
end

function CreatureList:Area(pos1, pos2, customData)
	IterateBetweenPositions(pos1, pos2, function(context)
		local tile = Tile(context.pos)
		if not tile then
			return
		end
		local creatures = tile:getCreatures()
		for _, creature in pairs(creatures) do
			self:Add(creature, customData)
		end
	end)
	return self
end

function CreatureList:Move(destination)
	for _, creature in pairs(self.creatures) do
		creature:teleportTo(destination)
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

function Position:CreaturesBetween(destination, name)
	local creatures = CreatureList():Area(self, destination):FilterByName(name)
	return creatures:Get()
end

function Position:PlayersBetween(destination, name)
	local players = CreatureList():Area(self, destination):FilterByName(name):FilterByPlayer()
	return players:Get()
end

function Position:MonstersBetween(destination, name)
	local monsters = CreatureList():Area(self, destination):FilterByName(name):FilterByMonster()
	return monsters:Get()
end

function Position:NpcsBetween(destination, name)
	local npcs = CreatureList():Area(self, destination):FilterByName(name):FilterByNpc()
	return npcs:Get()
end

function Position:FirstCreatureBetween(destination, name)
	local creature = CreatureList():Area(self, destination):FilterByName(name):First()
	return creature
end

function Position:FirstPlayerBetween(destination, name)
	local player = CreatureList():Area(self, destination):FilterByName(name):FilterByPlayer():First()
	return player
end

function Position:FirstMonsterBetween(destination, name)
	local monster = CreatureList():Area(self, destination):FilterByName(name):FilterByMonster():First()
	return monster
end

function Position:FirstNpcBetween(destination, name)
	local npc = CreatureList():Area(self, destination):FilterByName(name):FilterByNpc():First()
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
	CreatureList():Area(self, self):FilterByName(name):Move(destination)
end

function Position:MovePlayers(destination, name)
	CreatureList():Area(self, self):FilterByName(name):FilterByPlayer():Move(destination)
end

function Position:MoveMonsters(destination, name)
	CreatureList():Area(self, self):FilterByName(name):FilterByMonster():Move(destination)
end

function Position:MoveNpcs(destination, name)
	CreatureList():Area(self, self):FilterByName(name):FilterByNpc():Move(destination)
end

function Position:MoveItems(destination)
	local tile = Tile(self)
	local items = tile:getItems()
	for _, item in pairs(items) do
		item:moveTo(destination)
	end
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

local function drawBackslashLine1(positions, verticalId, horizontalId)
	local items = ItemExList()
	for i = 1, #positions - 1 do
		local currentPos = positions[i + 0]
		local nextPos = positions[i + 1]

		local item1 = Game.createItem(horizontalId, 1, currentPos:Moved(0, -1, 0))
		table.insert(items, item1)
		if nextPos.y ~= currentPos.y then
			local item2 = Game.createItem(verticalId, 1, currentPos)
			table.insert(items, item2)
		end
	end
end

local function drawBackslashLine2(positions, verticalId, horizontalId)
	local items = ItemExList()
	for i = 1, #positions - 1 do
		local currentPos = positions[i + 0]
		local nextPos = positions[i + 1]

		local item1 = Game.createItem(verticalId, 1, currentPos)
		table.insert(items, item1)
		if nextPos.x ~= currentPos.x then
			local item2 = Game.createItem(horizontalId, 1, currentPos)
			table.insert(items, item2)
		end
	end
end

local function drawSlashLine1(positions, verticalId, horizontalId)
	local items = ItemExList()
	for i = 1, #positions - 1 do
		local currentPos = positions[i + 0]
		local nextPos = positions[i + 1]

		local item1 = Game.createItem(horizontalId, 1, currentPos)
		table.insert(items, item1)
		if nextPos.y ~= currentPos.y then
			local item2 = Game.createItem(verticalId, 1, currentPos)
			table.insert(items, item2)
		end
	end
end

local function drawSlashLine2(positions, verticalId, horizontalId)
	local items = ItemExList()
	for i = 1, #positions - 1 do
		local currentPos = positions[i + 0]
		local nextPos = positions[i + 1]

		local item1 = Game.createItem(verticalId, 1, currentPos)
		table.insert(items, item1)
		if nextPos.x ~= currentPos.x then
			local item2 = Game.createItem(horizontalId, 1, currentPos)
			table.insert(items, item2)
		end
	end
end

function Position:DrawLineTo(destination, verticalId, horizontalId, removeAfterSeconds)
	local positions, dx, dy, flipAxis = self:CalculatePositionsOnSlope(destination)

	local items = {}

	if flipAxis and dx >= dy then
		items = drawBackslashLine1(positions, verticalId, horizontalId)
	elseif flipAxis and dx < dy then
		items = drawBackslashLine2(positions, verticalId, horizontalId)
	elseif dx >= dy then
		items = drawSlashLine1(positions, verticalId, horizontalId)
	elseif dx < dy then
		items = drawSlashLine2(positions, verticalId, horizontalId)
	end

	if removeAfterSeconds and items then
		addEvent(function()
			items:Remove()
		end, removeAfterSeconds)
	end
end

function IsMoveDiagonal(fromPos, toPos)
	local dir = fromPos:DirectionTo(toPos)
	if dir >= 4 and dir <= 7 then
		return true
	end
	return false
end

function Position:VectorTo(dest)
	local dx = self.x - dest.x
	local dy = self.y - dest.y
	local dz = self.z - dest.z
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
function Position:FindAnyUnoccupiedSpot(radius)
	radius = radius or 1
	if radius < 0 then
		logger.warn("[Position:FindAnyUnoccupiedSpot] radius less than 0")
	end

	local pos1, pos2 = self:GetBoundariesByRadius(radius)

	local result = IterateBetweenPositions(pos1, pos2, function(context)
		local pos = context.pos
		local tile = Tile(pos)
		if tile and tile:isWalkable(false, false, true, false, false) then
			return pos
		end
	end, { stopCondition = STOP_CONDITIONS.isNotNull })
	return result or self
end

---@return Creature|nil creature
function Position:GetTopCreature()
	local tile = Tile(self)
	if not tile then
		return nil
	end
	return tile:getTopCreature()
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

function PosToOffset(pos, anchor)
	local offset = {}
	offset.x = pos.x - anchor.x
	offset.y = pos.y - anchor.y
	offset.z = pos.z - anchor.z
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
	context.xi = context.pos.x - context.lowX
	context.yi = context.pos.y - context.lowY
	context.zi = context.pos.z - context.lowZ

	local lastResult = context.callback(context)
	if parseStopCondition(context.stopCondition, lastResult) then
		return lastResult, true
	end

	return lastResult, false
end

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

function Position:DistanceTo(dest, sum)
	local vector = self:VectorTo(dest):Abs()
	if sum then
		return vector.x + vector.y + vector.z
	end
	return vector.x, vector.y, vector.z
end

function RandomPositionBetween(pos1, pos2)
	math.randomseed(os.time())
	local dx = pos1.x - pos2.x
	local dy = pos1.y - pos2.y
	local dz = pos1.z - pos2.z

	local randX, randY, randZ = 0, 0, 0
	randX = math.random(0, math.abs(dx))
	randY = math.random(0, math.abs(dy))
	randZ = math.random(0, math.abs(dz))
	if dx >= 0 then
		randX = -randX
	end
	if dy >= 0 then
		randY = -randY
	end
	if dz >= 0 then
		randZ = -randZ
	end

	local result = Position(pos1.x + randX, pos1.y + randY, pos1.z + randZ)
	return result
end

function IsPosition(obj)
	return getmetatable(obj) == Position
end

function Position:GetTopItem(stackPos)
	stackPos = stackPos or 0
	local tile = Tile(self)
	if not tile then
		return nil
	end

	local items = tile:getItems()
	if not items or #items < 1 then
		return nil
	end

	if not items[1 + stackPos] then
		return nil
	end
	return items[1 + stackPos]
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
	return IterateBetweenPositions(corner1, corner2, function(context)
		local pos = context.pos
		local tile = Tile(pos)
		if not tile then
			return
		end
		local creature = tile:getTopCreature()
		if not (creature and creature:isNpc()) then
			return
		end

		if name == nil then
			return creature
		end
		if creature:getName() == name then
			return creature
		end
	end, { stopCondition = STOP_CONDITIONS.isNotNull })
end

--38f
function PlayersPresentAtAllPositions(positions, anchor)
	for _, pos in pairs(positions) do
		pos = pos.offPos or pos.pos or pos.position or pos
		if anchor then
			pos = anchor:Moved(pos)
		end
		local tile = Tile(pos)
		local creature = tile:getTopCreature()
		if not creature then
			return false
		end
		if not creature:isPlayer() then
			return false
		end
	end
	return true
end

-- in an offset the magnitude of each coordinate is very rarely higher than 200
-- trying to create Position() with negative coordinate causes overflow, eg. Position(-10, 2, 3) will have {x: 65526, y: 2, z:3} -> this is Position class
-- such coordinates are never used relistically, so:
--- if x/y is higher than OVERFLOW_XY, and lowered back by 2^16 so it has its original value, eg. {x: -10, y: 2, z: 3} -> this is normal table
--- if z is higher than OVERFLOW_Z, then its lowered back by 2^8, so its has its original value
local OVERFLOW_XY = 2 ^ 16 - 5000
local OVERFLOW_Z = 2 ^ 8 - 50
local function calculateOverflow(x, y, z)
	if x > OVERFLOW_XY then
		x = x - 2 ^ 16
	end
	if y > OVERFLOW_XY then
		y = y - 2 ^ 16
	end
	if z > OVERFLOW_Z then
		z = z - 2 ^ 8
	end
	return x, y, z
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

	-- x, y, z = calculateOverflow(x, y, z)
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

---@param vectorOrX Vector|number passing vector will ignore other params
---@param y number
---@param z number
---@return Position self origial position moved by the vector or the x, y, z
function Position:Move(vectorOrX, y, z)
	local offset = ExtractCoords(vectorOrX, y, z)
	self.x = self.x + (offset.x or 0)
	self.y = self.y + (offset.y or 0)
	self.z = self.z + (offset.z or 0)
	return self
end

---@param vectorOrX Vector|number passing vector will ignore other params
---@param y number
---@param z number
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

---@param inputSeparator string one character or many characters eg. ", "
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
	local offset = ExtractCoords(vector)
	local temp = Position(self)
	local pos = { x = temp.x, y = temp.y, z = temp.z }
	pos.x = pos.x + (offset.x or 0)
	pos.y = pos.y + (offset.y or 0)
	pos.z = pos.z + (offset.z or 0)
	return Position(pos)
end

DESERT_QUEST_HUB_ANCHOR = Position(6795, 1275, 9)
DESERT_QUEST_ONE_ANCHOR = Position(5158, 866, 11)
DESERT_QUEST_TWO_ANCHOR = Position(5051, 646, 7)
RUBIKS_CUBE_ANCHOR = DESERT_QUEST_TWO_ANCHOR:Moved(-20, -39, -3)

RETRO_MIRKO_ANCHOR = Position(4750, 856, 7)
CAMEL_FARM_ANCHOR = Position(6095, 1256, 4)
MIRKO_MAGICIANS_ANCHOR = Position(6029, 1338, 6)

KROL_SZCZUROW_HUB_ANCHOR = Position(6142, 1423, 10)
LIBRUM_VORTEX_ANCHOR = Position(6802, 1224, 10)
SCIEZKA_NIEUMARLYCH_ANCHOR = Position(6713, 1373, 14)

PETRUS_CIEMIEZCA_ANCHOR = Position(6078, 1349, 2)
HFPX_ANCHOR = Position(6788, 547, 13)
RETRO_KNUROWO_ANCHOR = Position(4445, 859, 7)
KRAKEN_ANCHOR = Position(5974, 1177, 6)
SKURWIWIJ_ANCHOR = Position(6546, 543, 9)
ZUL_SZCZUROW_ANCHOR = Position(6006, 1382, 13)

KUZNIA_YAANUSHA_ANCHOR = Position(6657, 1066, 15)
STARSHIP_ANCHOR = Position(7356, 789, 7)
DEEPLING_TEMPLE_ANCHOR = Position(6788, 994, 14)
FUEL_SHOP_ANCHOR = Position(7369, 671, 6)
GANYMEDE_ANCHOR = Position(7910, 295, 6)
HUGO_TAR_PLANET_ANCHOR = Position(7717, 244, 7)
HUGO_BEACH_PLANET_ANCHOR = Position(7488, 263, 7)
RUKCA_ANCHOR = Position(7594, 114, 8)

JANUSZEX_MOVING_TRAIN_ANCHOR = Position(6400, 1126, 13)
JANUSZEX_ANCHOR = Position(7687, 1025, 10)

-- 38f85df67705e9e59ab4b44bc8590644
CHESS_ANCHOR = Position(1428, 1302, 8)
FNAF_ANCHOR = Position(5227, 1035, 8)
