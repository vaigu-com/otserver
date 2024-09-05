Vector = {}
function Vector:new()
	local newObj = {}
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(Vector, {
	__call = function(class, x, y, z)
		local instance = setmetatable({}, class)
		instance.x = x
		instance.y = y
		instance.z = z
		return instance
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

-- static factory method
function Vector.FromDirection(dir)
	local originalVector = dirToVector[dir]
	local copy = Vector(originalVector.x, originalVector.y, 0)
	return copy
end

function Vector:Scale(factor)
	self.x = self.x * factor
	self.y = self.y * factor
	self.z = self.z * factor
	return self
end

function Vector:Abs()
	self.x = math.abs(self.x)
	self.y = math.abs(self.y)
	self.z = math.abs(self.z)
	return self
end

local dirs = {
	DIRECTION_NORTH,
	DIRECTION_NORTHEAST,
	DIRECTION_EAST,
	DIRECTION_SOUTHEAST,
	DIRECTION_SOUTH,
	DIRECTION_SOUTHWEST,
	DIRECTION_WEST,
	DIRECTION_NORTHWEST,
}
function Vector:Dir()
	if self.x == 0 and self.y == 0 then
		return DIRECTION_NONE
	end
	local angle = math.atan2(self.x, self.y)
	local dirId = (math.ceil((angle + 22.5) % 360 / 45))
	return dirs[dirId]
end
