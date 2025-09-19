local monsterIdToSpawnTimestamp = {}
local multiplierPerTimeUnit = 0.1
local maximumBonusMultiplier = 1.5

local function timeNow()
	return math.floor(tonumber(os.time()))
end

-- Bonus increases each interval below.
-- For example, when time unit is 600, it increases every 10 minutes. This means bonus for 12 and 19 minutes is the same.
--local timeUnit = 60 * 10
local timeUnit = 1
-- Bonus is only calculated and distributed if this amount of time passed since last death. For example minimumTimeUnitsElapsed=40*60 means 40 minutes had to pass.
local minimumTimeElapsed = 40 * 60

local function bonusExpByMonster(monster)
	local monsterId = monster:getId()
	local spawnTime = monsterIdToSpawnTimestamp[monsterId]
	if spawnTime == nil then
		return 0
	end

	monsterIdToSpawnTimestamp[monsterId] = nil
	local currentTime = timeNow()
	local timeElapsed = currentTime - spawnTime
	if timeElapsed < minimumTimeElapsed then
		return 0
	end

	local timeUnitsElapsed = timeElapsed / timeUnit
	local bonusMultiplier = multiplierPerTimeUnit * timeUnitsElapsed
	if bonusMultiplier <= 0 then
		return 0
	end

	bonusMultiplier = math.min(bonusMultiplier, maximumBonusMultiplier)

	local mType = monster:getType()
	local baseExp = mType:experience()
	return math.floor(baseExp * bonusMultiplier)
end

local function setMonsterSpawnTimestamp(monster)
	local monsterId = monster:getId()
	local currentTime = timeNow()
	monsterIdToSpawnTimestamp[monsterId] = currentTime
end

local callback = EventCallback("MonsterOnSpawn/SetSpawnHour")
function callback.monsterOnSpawn(monster, position)
	if not monster then
		return
	end

	monster:registerEvent("BonusExpForLifespan")
	setMonsterSpawnTimestamp(monster)
end
callback:register()

local function addPlayerBonusExperience(player, baseExp)
	local playerSpecificExpRate = getRateFromTable(experienceStages, player:getLevel(), configManager.getNumber(configKeys.RATE_EXPERIENCE))
	local finalExp = baseExp * playerSpecificExpRate
	player:sendTextMessage(MESSAGE_DAMAGE_DEALT, "You received " .. finalExp .. " bonus experience!")
	player:addExperience(finalExp)
end

local bonusExpKill = CreatureEvent("BonusExpForLifespan")
function bonusExpKill.onDeath(creature, corpse, lasthitkiller, mostdamagekiller, lasthitunjustified, mostdamageunjustified)
	if creature:isPlayer() or creature:getMaster() then
		return true
	end

	local targetMonster = creature:getMonster()
	if not targetMonster then
		return true
	end

	local baseBonusExp = bonusExpByMonster(targetMonster)
	if baseBonusExp <= 0 then
		return
	end

	local players = CreatureList.FromDamageMap(creature:getDamageMap()):FilterByPlayer()
	local playerCount = players:Count()
	local expPerPlayer = math.floor(baseBonusExp / playerCount)

	for _, player in pairs(players:Get()) do
		addPlayerBonusExperience(player, expPerPlayer)
	end

	return true
end
bonusExpKill:register()
