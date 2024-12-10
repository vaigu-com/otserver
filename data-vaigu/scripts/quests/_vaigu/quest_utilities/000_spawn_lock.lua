local nextSpawnLockIndex = 0
local function nextSpawnLockName()
	nextSpawnLockIndex = nextSpawnLockIndex + 1
	return "spawn-lock-" .. nextSpawnLockIndex
end

SpawnLock = {}
SpawnLock.__index = SpawnLock
function SpawnLock:New(name)
	local newObj = {}
	name = name or nextSpawnLockName()
	newObj.name = name
	setmetatable(newObj, self)
	return newObj
end
setmetatable(SpawnLock, {
	__call = function(class, ...)
		return class:New(...)
	end,
})

SPAWN_LOCK_STATE = {
	SET = "SET",
	NOT_SET = "NOT_SET",
}

function SpawnLock:Set()
	self.set = SPAWN_LOCK_STATE.SET
end

function SpawnLock:Reset()
	self.set = SPAWN_LOCK_STATE.NOT_SET
end

function SpawnLock:IsSet()
	return self.set == SPAWN_LOCK_STATE.SET
end
