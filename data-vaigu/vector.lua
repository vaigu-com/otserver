---@class Vector
---@field x integer
---@field y integer
---@field z integer
Vector = {}
function Vector:New(x, y, z)
	local newObj = {}
	newObj.x = x
	newObj.y = y
	newObj.z = z
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(Vector, {
	__call = function(class, ...)
		return Vector:New(...)
	end,
})

local dirToVector = {
	[DIRECTION_SOUTH] = Vector(0, 1, 0),
	[DIRECTION_EAST] = Vector(1, 0, 0),
	[DIRECTION_NORTH] = Vector(0, -1, 0),
	[DIRECTION_WEST] = Vector(-1, 0, 0),

	[DIRECTION_SOUTHWEST] = Vector(-1, 1, 0),
	[DIRECTION_SOUTHEAST] = Vector(1, 1, 0),
	[DIRECTION_NORTHWEST] = Vector(-1, -1, 0),
	[DIRECTION_NORTHEAST] = Vector(1, -1, 0),

	[DIRECTION_NONE] = Vector(0, 0, 0),
}

---@param dir number dir enum eg. DIRECTION_NORTH
---@return Vector vector deepcopy of the vector corresponding direction
function Vector.FromDirection(dir)
	local originalVector = dirToVector[dir]
	local vector = Vector(originalVector.x, originalVector.y, 0)
	return vector
end

---@param pos1 Position
---@param pos2 Position
---@return Vector vector
function Vector.BetweenPositions(pos1, pos2)
	local dx = pos2.x - pos1.x
	local dy = pos2.y - pos1.y
	local dz = pos2.z - pos1.z
	local vector = Vector(dx, dy, dz)
	return vector
end

---@return Vector self original vector with each axis multiplied by factor
function Vector:Scale(factor)
	self.x = self.x * factor
	self.y = self.y * factor
	self.z = self.z * factor
	return self
end

---@return Vector self original vector with each axis value changed to abs of itself
function Vector:Abs()
	self.x = math.abs(self.x)
	self.y = math.abs(self.y)
	self.z = math.abs(self.z)
	return self
end

---@param inputSeparator string one character or many characters eg. ", "
function Vector:ToString(inputSeparator)
	local separator = inputSeparator or ", "
	local x = string.format("%05d", self.x)
	local y = string.format("%05d", self.y)
	local z = string.format("%05d", self.z)
	return x .. separator .. y .. separator .. z
end

---@param inputSeparator string one character or many characters eg. ", "
function Vector:ToStringShort(inputSeparator)
	local separator = inputSeparator or ", "
	return self.x .. separator .. self.y .. separator .. self.z
end

local directions = {
	DIRECTION_NORTH,
	DIRECTION_NORTHEAST,
	DIRECTION_EAST,
	DIRECTION_SOUTHEAST,
	DIRECTION_SOUTH,
	DIRECTION_SOUTHWEST,
	DIRECTION_WEST,
	DIRECTION_NORTHWEST,
}

---@return integer direction direction enum, based on vector x and y; eg. x = 1, y = 1 returns DIRECTION_SOUTHEAST
function Vector:ToDirection()
	if self.x == 0 and self.y == 0 then
		return DIRECTION_NONE
	end
	local angle = math.atan2(self.x, self.y)
	local dirId = (math.ceil((angle + 22.5) % 360 / 45))
	local direction = directions[dirId]
	return direction
end
