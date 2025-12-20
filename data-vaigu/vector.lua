---@class Vector
---@field x integer
---@field y integer
---@field z integer
Vector = {}
Vector.__eq = function(vec1, vec2)
	local xEq = vec1.x == vec2.x
	local yEq = vec1.y == vec2.y
	local zEq = vec1.z == vec2.z
	return xEq and yEq and zEq
end
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

---@return Vector self copy of original vector with each axis multiplied by factor
function Vector:Scaled(factor)
	local result = Vector(self.x * factor, self.y * factor, self.z * factor)
	return result
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
local anglePerDir = 360 / #directions

function Vector:ToDirectionByAngle()
	if self.x == 0 and self.y == 0 then
		return DIRECTION_NONE
	end

	local angle = math.deg(math.atan2(-self.y, -self.x))
	angle = (angle + 90 + 180) % 360
	local dirId = math.floor((angle + anglePerDir / 2) / anglePerDir) % 8 + 1
	return directions[dirId]
end

function Vector:ToDirectionSnap()
	if self.x == 0 and self.y == 0 then
		return DIRECTION_NONE
	end

	if self.x == 0 then
		if self.y > 0 then
			return DIRECTION_SOUTH
		else
			return DIRECTION_NORTH
		end
	elseif self.y == 0 then
		if self.x > 0 then
			return DIRECTION_EAST
		else
			return DIRECTION_WEST
		end
	else
		if self.x > 0 and self.y > 0 then
			return DIRECTION_SOUTHEAST
		elseif self.x > 0 and self.y < 0 then
			return DIRECTION_NORTHEAST
		elseif self.x < 0 and self.y > 0 then
			return DIRECTION_SOUTHWEST
		else
			return DIRECTION_NORTHWEST
		end
	end
end

local facingDirectionToQualifiedDirections = {
	[DIRECTION_NORTH] = { DIRECTION_NORTHWEST, DIRECTION_NORTH, DIRECTION_NORTHEAST },
	[DIRECTION_EAST] = { DIRECTION_NORTHEAST, DIRECTION_EAST, DIRECTION_SOUTHEAST },
	[DIRECTION_SOUTH] = { DIRECTION_SOUTHEAST, DIRECTION_SOUTH, DIRECTION_SOUTHWEST },
	[DIRECTION_WEST] = { DIRECTION_SOUTHWEST, DIRECTION_WEST, DIRECTION_NORTHWEST },

	[DIRECTION_NORTHEAST] = { DIRECTION_NORTH, DIRECTION_EAST, DIRECTION_NORTHEAST },
	[DIRECTION_SOUTHEAST] = { DIRECTION_SOUTH, DIRECTION_EAST, DIRECTION_SOUTHEAST },
	[DIRECTION_SOUTHWEST] = { DIRECTION_SOUTH, DIRECTION_WEST, DIRECTION_SOUTHWEST },
	[DIRECTION_NORTHWEST] = { DIRECTION_NORTH, DIRECTION_WEST, DIRECTION_NORTHWEST },

	[DIRECTION_NONE] = { DIRECTION_NONE },
}
function Vector:IsFacingPartially(otherDirection)
	local vectorDirection = self:ToDirectionByAngle()
	local qualifiedDirections = facingDirectionToQualifiedDirections[otherDirection]
	if not qualifiedDirections then
		return false
	end

	for _, qualifiedDirection in pairs(qualifiedDirections) do
		if vectorDirection == qualifiedDirection then
			return true
		end
	end
	return false
end

function Vector:IsFacingSnap(...)
	local vectorDirection = self:ToDirectionSnap()
	if type(...) == "table" then
		return table.contains(..., vectorDirection)
	else
		return table.contains({ ... }, vectorDirection)
	end
end

function Vector:IsFacingDiagonalSnap()
	return self:IsFacingSnap(DIRECTION_NORTHEAST, DIRECTION_SOUTHEAST, DIRECTION_SOUTHWEST, DIRECTION_NORTHWEST)
end

function Vector:IsFacingVerticalPartially()
	return self:IsFacingPartially(DIRECTION_NORTH) or self:IsFacingPartially(DIRECTION_SOUTH)
end
