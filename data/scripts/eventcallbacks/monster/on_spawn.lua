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

local cobraNames = {
	["cobra scout"] = "cobra scout",
	["cobra vizier"] = "cobra vizier",
	["cobra assassin"] = "cobra assassin",
}

local function handleCobra(monster)
	local name = monster:getName():lower()
	if cobraNames[name] == nil then
		return
	end
	if getGlobalStorageValue(GlobalStorage.CobraBastionFlask) >= os.time() then
		monster:setHealth(monster:getMaxHealth() * 0.75)
	end
end

local function handleIronServantReplica(monster)
	if monster:getName():lower() ~= "iron servant replica" then
		return
	end

	local chance = math.random(100)
	if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.MechanismDiamond) >= 1 and Game.getStorageValue(GlobalStorage.ForgottenKnowledge.MechanismGolden) >= 1 then
		if chance > 30 then
			local monsterType = math.random(2) == 1 and "diamond servant replica" or "golden servant replica"
			Game.createMonster(monsterType, monster:getPosition(), false, true)
			monster:remove()
		end
		return
	end

	if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.MechanismDiamond) >= 1 and chance > 30 then
		Game.createMonster("diamond servant replica", monster:getPosition(), false, true)
		monster:remove()
		return
	end

	if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.MechanismGolden) >= 1 and chance > 30 then
		Game.createMonster("golden servant replica", monster:getPosition(), false, true)
		monster:remove()
	end
end

local callback = EventCallback()

function callback.monsterOnSpawn(monster, position)
	if not monster then
		return
	end
	HazardMonster.onSpawn(monster, position)

	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end

	--handleCobra(monster)
	--handleIronServantReplica(monster)

	if not monster:getType():canSpawn(position) then
		monster:remove()
	else
		local spec = Game.getSpectators(position, false, false)
		for _, creatureId in pairs(spec) do
			local monster = Monster(creatureId)
			if monster and not monster:getType():canSpawn(position) then
				monster:remove()
			end
		end
	end
	setMonsterSpawnHour(monster)
end

callback:register()
