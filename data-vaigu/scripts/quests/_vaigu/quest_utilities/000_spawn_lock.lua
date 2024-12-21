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
	newObj.refreshed = 0
	newObj.onSet = function() end
	newObj.onReset = function() end
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

function SpawnLock:Set(npc)
	self.set = SPAWN_LOCK_STATE.SET
	self.created = os.time()
	self.refreshed = self.created
	self.npc = npc
	self.onSet()
	return self
end

function SpawnLock:Reset()
	self.set = SPAWN_LOCK_STATE.NOT_SET

	self.onReset()
	return self
end

function SpawnLock:Refresh()
	self.refreshed = os.time()
	return self
end

function SpawnLock:Context(context)
	for key, value in pairs(context) do
		self[key] = value
	end
	return self
end

function SpawnLock:SecondsSinceRefresh()
	return os.time() - self.refreshed
end

function SpawnLock:IsSet()
	return self.set == SPAWN_LOCK_STATE.SET
end
