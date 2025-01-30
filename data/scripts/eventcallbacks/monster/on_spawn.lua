local monsterIdToSpawnTimeSeconds = {}
local multiplierPerTimeUnit = 0.5
-- Total exp for kill is up to baseExp*(1 + maximumBonusMultiplier)
local maximumBonusMultiplier = 1.5

local function currentTimeSeconds()
	return math.floor(tonumber(os.time()))
end

local timeUnit = 3600
local minimumTimeUnitsElapsed = 0.5

function BonusExpByMonsterId(monster)
	local monsterId = monster:getId()
	local spawnTime = monsterIdToSpawnTimeSeconds[monsterId] / timeUnit
	if spawnTime == nil then
		return 0
	end

	monsterIdToSpawnTimeSeconds[monsterId] = nil
	local currentTime = currentTimeSeconds() / timeUnit
	local timeUnitsElapsed = currentTime - spawnTime
	if timeUnitsElapsed < minimumTimeUnitsElapsed then
		return 0
	end

	local bonusMultiplier = multiplierPerTimeUnit * timeUnitsElapsed
	if bonusMultiplier <= 0 then
		return 0
	end

	if bonusMultiplier > maximumBonusMultiplier then
		bonusMultiplier = maximumBonusMultiplier
	end

	local mType = monster:getType()
	local baseExp = mType:experience()
	return math.floor(baseExp * bonusMultiplier)
end

local function setMonsterSpawnHour(monster)
	local monsterId = monster:getId()
	local currentTime = currentTimeSeconds()
	monsterIdToSpawnTimeSeconds[monsterId] = currentTime
end

local callback = EventCallback("MonsterOnSpawn/SetSpawnHour")

function callback.monsterOnSpawn(monster, position)
	if not monster then
		return
	end

	setMonsterSpawnHour(monster)
end

callback:register()
