local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest
	:NoQuestlog()
	:EncounterData(function()
		local function validateCreature(creatureName)
			if not MonsterType(creatureName) then
				logger.warn(T("[Wave::Creature] Cannot add creature :creatureName: to wave.", { creatureName = creatureName }))
			end
		end

		for key, luaRaid in pairs(LuaRaidRegistry.registry) do
			for key, wave in pairs(luaRaid.waves) do
				for key, creature in pairs(wave.monsters) do
					validateCreature(creature.name)
				end
			end
		end
	end)
	:Register()

---@class Wave
---@field delay number
---@field monsters table
---@field notifications table
Wave = {}
Wave.__index = Wave
function Wave.New(delay)
	local newObj = {}
	newObj.delay = delay
	newObj.monsters = {}
	newObj.notifications = {}
	setmetatable(newObj, Wave)
	return newObj
end
setmetatable(Wave, {
	__call = function(t, ...)
		return Wave.New(...)
	end,
})

function Wave:Creature(name, area, amount, forceSpawn)
	table.insert(self.monsters, {
		name = name,
		area = area,
		amount = amount,
		forceSpawn = forceSpawn,
	})
	return self
end

function Wave:Notification(delay, text)
	table.insert(self.notifications, {
		delay = self.delay + delay,
		text = text,
	})

	MissingStrings:TestAllLanguages(text, LOCALIZERS.LuaRaids)

	return self
end

local function canSpawn(pos, monsterData)
	if monsterData.force then
		return true
	end

	local tile = Tile(pos)
	if not tile then
		return false
	end
	if tile:getCreatureCount() ~= 0 then
		return false
	end
	return true
end

local function trySpawnRaidMonster(pos, monsterData, additionalLootTable)
	if not canSpawn(pos, monsterData) then
		return
	end

	local monster = Game.createMonster(monsterData.name, pos, false, monsterData.force)
	if monster then
		for _, loot in pairs(additionalLootTable) do
			monster:addLoot(loot)
		end
		return
	end

	if not monster and monsterData.force then
		logger.warn(debug.traceback(T("[trySpawnRaidMonster] Cannot create monster :name:, on position :pos:", { name = monsterData.name, pos = pos:ToString() })))
	end
end

function Wave:EnqueueCreatureSpawns(difficultyTier)
	local additionalLoot = LUA_RAID_DIFFICULTY_TIER_LOOT[difficultyTier]
	addEvent(function(monsters)
		for _, monsterData in pairs(monsters) do
			for _ = 1, monsterData.amount do
				local pos = monsterData.area:RandomPosition()
				trySpawnRaidMonster(pos, monsterData, additionalLoot)
			end
		end
	end, self.delay, self.monsters)
end

function Wave:EnqueueNotifications()
	for _, notification in pairs(self.notifications) do
		addEvent(function()
			Game.broadcastMessage(notification.text, MESSAGE_STATUS_WARNING, true)
		end, notification.delay)
	end
end

---@class LUA_RAID_DIFFICULTY_TIER
LUA_RAID_DIFFICULTY_TIER = {
	silver = "silver",
	gold = "gold",
}

LUA_RAID_DIFFICULTY_TIER_LOOT = {
	[LUA_RAID_DIFFICULTY_TIER.silver] = { Loot.fromItem({ id = ItemId.SILVER_RAID_TOKEN, chance = 7000 }) },
}

local fourHours = 14400

---@class LuaRaid
---@field name string
---@field perDay number
---@field waves Wave[]
---@field cooldown integer seconds
---@field minPlayerOnline integer
---@field isRare boolean generated field
---@field isCommon boolean generated field
---@field private difficultyTier LUA_RAID_DIFFICULTY_TIER
---@field private lastRunTime integer
LuaRaid = {}
LuaRaid.__index = LuaRaid
function LuaRaid.New(name, difficultyTier)
	local newObj = {}
	newObj.name = name
	newObj.perDay = 0.1
	newObj.waves = {}
	newObj.cooldown = fourHours
	newObj.minPlayersOnline = 0
	newObj.difficultyTier = difficultyTier or LUA_RAID_DIFFICULTY_TIER.silver

	newObj.lastRunTime = 0

	setmetatable(newObj, LuaRaid)
	return newObj
end
setmetatable(LuaRaid, {
	__call = function(t, ...)
		return LuaRaid.New(...)
	end,
})

function LuaRaid:Context(context)
	self.perDay = context.perDay or self.perDay
	self.waves = context.waves or {}
	self.cooldown = context.cooldown or self.cooldown
	self.minPlayersOnline = context.minPlayersOnline or self.minPlayersOnline
	return self
end

function LuaRaid:CanStart()
	local secondsSinceThisRaidEnded = os.time() - self.lastRunTime
	if secondsSinceThisRaidEnded < self.cooldown then
		return false
	end

	if #Game.getPlayers() < self.minPlayersOnline then
		return false
	end

	return true
end

function LuaRaid:Start()
	self.lastRunTime = os.time()
	for _, wave in pairs(self.waves) do
		wave:EnqueueCreatureSpawns(self.difficultyTier)
		wave:EnqueueNotifications()
	end
end

---@class LuaRaidRegistry
---@field registry LuaRaid[]
LuaRaidRegistry = {}
LuaRaidRegistry.__index = LuaRaidRegistry
LuaRaidRegistry.registry = {}
LuaRaidRegistry.failStacks = 0
local tryStartRaidInterval = 5 * 60 * 1000
local triesPerDay = 24 * 60 * 60 * 1000 / tryStartRaidInterval
local maxRoll = 100000
local additionalChancePerFailstack = 1 / triesPerDay

local rareThreshold = 0.2

---@param luaRaid LuaRaid
function LuaRaidRegistry:Register(luaRaid)
	if luaRaid.perDay < rareThreshold then
		luaRaid.isRare = true
	else
		luaRaid.isCommon = true
	end
	self.registry[luaRaid.name] = luaRaid
end

function LuaRaidRegistry:Get(name)
	return self.registry[name] or self.registry
end

function LuaRaidRegistry:TryStartRandomCommon()
	for name, raid in randomPairs(self.registry) do
		if raid.isCommon then
			local roll = math.random(1, maxRoll)
			local requiredRoll = raid.perDay / triesPerDay * maxRoll * (1 + self.failStacks * additionalChancePerFailstack)
			if roll <= requiredRoll and raid:CanStart() then
				self.failStacks = 0
				logger.info("Randomly Starting Raid: " .. name)
				raid:Start()
				return true
			end
			self.failStacks = self.failStacks + 1
		end
	end
	return true
end

function LuaRaidRegistry:TryStartRandomRare()
	for name, raid in randomPairs(self.registry) do
		if raid.isRare then
			local roll = math.random(1, maxRoll)
			local requiredRoll = raid.perDay / triesPerDay * maxRoll * (1 + self.failStacks * additionalChancePerFailstack)
			if roll <= requiredRoll and raid:CanStart() then
				self.failStacks = 0
				logger.info("Randomly Starting Rare Raid: " .. name)
				raid:Start()
				return true
			end
		end
	end
	return true
end

function LuaRaidRegistry:StartByName(name, force)
	local raid = self.registry[name]
	if not raid then
		logger.warn("[LuaRaidRegistry::StartByName] Trying to start unexistant raid " .. name)
		return
	end
	if force or raid:CanStart() then
		raid:Start()
		return true
	end
end

---@class LUA_RAIDS
---@field self LuaRaid[]
dofile(DATA_DIRECTORY .. "/lua_raid_data.lua")

DAYS_TO_RUN_LUARAIDS = 4
if DAYS_SINCE_START >= DAYS_TO_RUN_LUARAIDS then
	local globalevent = GlobalEvent("LuaRaids")
	function globalevent.onThink(...)
		return LuaRaidRegistry:TryStartRandomCommon()
	end
	globalevent:interval(tryStartRaidInterval)
	globalevent:register()

	local globalevent = GlobalEvent("LuaRaidsRare")
	function globalevent.onThink(...)
		return LuaRaidRegistry:TryStartRandomRare()
	end
	globalevent:interval(tryStartRaidInterval)
	globalevent:register()
end

local function handleWave(wave, waveIndex, raidName)
	for creatureIndex, waveCreature in pairs(wave.monsters) do
		local atLeastOneCorrectPosition = false
		local corner1, corner2 = waveCreature.area:GetCorners()
		IterateBetweenPositions(corner1, corner2, function(context)
			local pos = context.pos
			local tile = Tile(pos)
			if tile then
				atLeastOneCorrectPosition = true
				return true
			end
			return false
		end, { stopCondition = STOP_CONDITIONS.isTrue })
		if not atLeastOneCorrectPosition then
			logger.warn(T("[LuaRaidRegistry::TestDry] Could not find at least one correct spawn position for creature#:creatureIndex: wave #:waveIndex: for raid :raidName:", { waveIndex = waveIndex, raidName = raidName, creatureIndex = creatureIndex }))
		end
	end
end
function LuaRaidRegistry:TestDry()
	for key, luaraid in pairs(self.registry) do
		for key, wave in pairs(luaraid.waves) do
			handleWave(wave, key, luaraid.name)
		end
	end
end
