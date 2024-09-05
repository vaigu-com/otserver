local mType = Game.createMonsterType("Kraken tentacles slammer")
local monster = {}

monster.description = "a Kraken tentacle"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 11350,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 40000
monster.maxHealth = 40000
monster.race = "blood"
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 3717,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = false,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = true,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -120, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
}

monster.defenses = {
	defense = 5,
	armor = 5,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true },
}
local slamCastTime = 3509
local tentacleDamageOnHit = 300
local shipYheight = 3
local tentacleSpriteIds = { 11337, 11349, 11350, 11351 }

local function setOutfit(creature, itemId)
	local condition = Condition(CONDITION_OUTFIT)
	condition:setTicks(15 * 60 * 1000)
	condition:setOutfit({ lookTypeEx = itemId })
	creature:addCondition(condition)
end
local function spawnSlamSqm(pos)
	for i = 0, slamCastTime, 1000 do
		addEvent(function()
			pos:sendMagicEffect(CONST_ME_POFF)
		end, i)
	end
	addEvent(function()
		pos:sendMagicEffect(CONST_ME_POFF)
	end, slamCastTime - 50)
end

local function doTentacleCombatDamage(target, dmg)
	dmg = dmg or tentacleDamageOnHit
	doTargetCombatHealth(0, target, COMBAT_DROWNDAMAGE, dmg, dmg, CONST_ME_NONE)
end

local function activatePhase2()
	local fightningPlatformPositions = KRAKEN_ENCOUNTER_DATA.fightningPlatformPositions
	local fightingShipPositions = KRAKEN_ENCOUNTER_DATA.fightingShipPositions

	local immovableTentancles = fightingShipPositions.topLeft:MonstersBetween(fightingShipPositions.downRight):FilterByName("Kraken tentacles"):Get()
	local totalDamage = 0

	for i = 1, 2 do
		local monster = immovableTentancles[i]
		if monster then
			local maxHp = monster:getMaxHealth()
			local currentHp = monster:getHealth()
			totalDamage = totalDamage + (maxHp - currentHp)
			monster:remove()
		else
			totalDamage = totalDamage + 50000
		end
	end

	local kraken = fightningPlatformPositions.downRight:MonstersBetween(fightningPlatformPositions.topLeft):FilterByName("The kraken"):First()
	local damageThreshold = kraken:getMaxHealth() * 0.4
	if totalDamage > damageThreshold then
		totalDamage = damageThreshold
	end
	kraken:setHealth(kraken:getMaxHealth() - totalDamage)

	local players = fightingShipPositions.topLeft:PlayersBetween(fightingShipPositions.downRight):Get()
	for _, player in pairs(players) do
		print(player)
		print(player:getName())
		player:teleportTo(fightningPlatformPositions.entrance)
	end
end

local function doShipDamage()
	local shipHealth = KRAKEN_ENCOUNTER_DATA.corner1:MonstersBetween(KRAKEN_ENCOUNTER_DATA.corner2):FilterByName("Ship health"):First()

	if not shipHealth then
		return activatePhase2()
	end

	doTentacleCombatDamage(shipHealth, -tentacleDamageOnHit * 5)
	if shipHealth:getHealth() <= 0 then
		return activatePhase2()
	end
end

local function tryDamageAnything(columnPos)
	local player = columnPos:Moved(0, -3, 0):PlayersBetween(columnPos:Moved(0, 3, 0)):First()
	if player then
		doTentacleCombatDamage(player)
	else
		doShipDamage()
	end
end

mType.onAppear = function(monster, creature)
	if monster ~= creature then
		return
	end
	setOutfit(monster, tentacleSpriteIds[math.random(1, #tentacleSpriteIds)])
	local pos = monster:getPosition()
	pos.y = KRAKEN_ANCHOR.y
	spawnSlamSqm(pos)
	local i = (shipYheight - 1) / 2 + 1
	for j = 1, i do
		spawnSlamSqm(pos:Moved(0, j, 0))
		spawnSlamSqm(pos:Moved(0, -j, 0))
	end

	local shipHealth = KRAKEN_ENCOUNTER_DATA.corner1:MonstersBetween(KRAKEN_ENCOUNTER_DATA.corner2):FilterByName("Ship health"):First()
	if shipHealth then
		doTentacleCombatDamage(shipHealth, -tentacleDamageOnHit)
	end

	addEvent(function()
		monster:remove()
		tryDamageAnything(pos)
	end, slamCastTime)
end

mType:register(monster)
