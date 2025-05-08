local monsterIdToSpawnTimestamp = {}
local multiplierPerTimeUnit = 0.1
-- Total exp for kill is up to baseExp*(1 + maximumBonusMultiplier)
local maximumBonusMultiplier = 1.5

local function timeNow()
	return math.floor(tonumber(os.time()))
end

--Bonus increases each interval below. For example, when time unit is 600, there is same bonus for 12 minutes and 19 minutes.
local timeUnit = 60 * 10
--Bonus is only calculated and distributed if this amount of time units passed since last death. For example 4 means 40 minutes had to pass.
local minimumTimeUnitsElapsed = 4
--Bonus is only calculated above the specified value. For example, if 30 minutes passed, bonus is 0. if 50 minutes passed, bonus is 2.
local countBonusAfter = minimumTimeUnitsElapsed - 1

local function bonusExpByMonsterId(monster)
	local monsterId = monster:getId()
	local spawnTime = monsterIdToSpawnTimestamp[monsterId]
	if spawnTime == nil then
		return 0
	end

	monsterIdToSpawnTimestamp[monsterId] = nil
	local currentTime = timeNow()
	local timeUnitsElapsed = (currentTime - spawnTime) / timeUnit
	if timeUnitsElapsed < minimumTimeUnitsElapsed then
		return 0
	end

	local bonusMultiplier = multiplierPerTimeUnit * (timeUnitsElapsed - countBonusAfter)
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

	local baseBonusExp = bonusExpByMonsterId(targetMonster)
	if baseBonusExp <= 0 then
		return
	end

	local damageMap = targetMonster:getDamageMap()
	local playerCount = TableSize(damageMap)
	local expPerPlayer = math.floor(baseBonusExp / playerCount)

	for playerid in pairs(damageMap) do
		local attackerPlayer = Player(playerid)
		if not attackerPlayer then
			goto continue
		end
		addPlayerBonusExperience(attackerPlayer, expPerPlayer)

		::continue::
	end

	return true
end
bonusExpKill:register()
