local nextSpawnLockIndex = 0
local function nextSpawnLockName()
	nextSpawnLockIndex = nextSpawnLockIndex + 1
	return "spawn-lock-" .. nextSpawnLockIndex
end

local resetSpawnLockDeath = CreatureEvent("resetSpawnLock")
function resetSpawnLockDeath.onDeath(creature)
	if not creature then
		return true
	end
	if creature:isPlayer() then
		return true
	end

	local spawnLock = SpawnLockRegistry:Get(creature)
	if spawnLock then
		spawnLock:Reset()
	end

	return true
end
resetSpawnLockDeath:register()

SpawnLockRegistry = {}
SpawnLockRegistry.__index = SpawnLockRegistry
SpawnLockRegistry.registry = {}

---@param spawnLock SpawnLock
---@return SpawnLock
function SpawnLockRegistry:Add(spawnLock)
	if not spawnLock.creature then
		return self
	end
	if not spawnLock.creature.getId then
		return self
	end

	self.registry[spawnLock.creature:getId()] = spawnLock
	return self
end

---@param spawnLock SpawnLock
---@return SpawnLock
function SpawnLockRegistry:Remove(spawnLock)
	if not spawnLock.creature then
		return self
	end
	if not spawnLock.creature.getId then
		return self
	end

	self.registry[spawnLock.creature:getId()] = nil
	return self
end

---@param creature Creature
---@return SpawnLock|nil
function SpawnLockRegistry:Get(creature)
	if not creature then
		return
	end
	if not creature.getId then
		return
	end

	return self.registry[creature:getId()]
end

---@class SpawnLock
---@field name string
---@field lastRefreshed number
---@field creature Creature
---@field onSet function
---@field onReset function
SpawnLock = {}
SpawnLock.__index = SpawnLock
function SpawnLock:New(name)
	local newObj = {}
	name = name or nextSpawnLockName()
	newObj.name = name
	newObj.lastRefreshed = 0
	newObj.onSet = function()
		newObj.creature:registerEvent("resetSpawnLock")
	end
	newObj.onReset = function() end
	setmetatable(newObj, self)
	return newObj
end
setmetatable(SpawnLock, {
	---@return SpawnLock
	__call = function(class, ...)
		return class:New(...)
	end,
})

SPAWN_LOCK_STATE = {
	SET = "SET",
	NOT_SET = "NOT_SET",
}

---comment
---@param creature Creature
---@return SpawnLock
function SpawnLock:Set(creature)
	self.state = SPAWN_LOCK_STATE.SET
	self.created = os.time()
	self.lastRefreshed = self.created
	self.creature = creature
	self:onSet()
	SpawnLockRegistry:Add(self)
	return self
end

function SpawnLock:Reset()
	self.state = SPAWN_LOCK_STATE.NOT_SET

	SpawnLockRegistry:Remove(self)
	self:onReset()
	return self
end

function SpawnLock:Refresh()
	self.lastRefreshed = os.time()
	return self
end

function SpawnLock:Context(context)
	for key, value in pairs(context) do
		self[key] = value
	end
	return self
end

function SpawnLock:SecondsSinceRefresh()
	return os.time() - self.lastRefreshed
end

function SpawnLock:IsSet()
	return self.state == SPAWN_LOCK_STATE.SET
end
