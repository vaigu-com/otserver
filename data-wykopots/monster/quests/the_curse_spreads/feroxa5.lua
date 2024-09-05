local mType = Game.createMonsterType("Feroxa5")
local monster = {}

monster.name = "Feroxa"
monster.description = "Feroxa"
monster.experience = 10000
monster.outfit = {
	lookType = 731,
	lookHead = 57,
	lookBody = 76,
	lookLegs = 77,
	lookFeet = 57,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "blood"
monster.corpse = 22089
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 2,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "GROOOWL", yell = false },
	{ text = "GRRR", yell = false },
}

monster.loot = {
	{ name = "golden raid token", chance = 100000, unique = 1 },
	{ name = "silver raid token", chance = 100000, maxCount = 3 },
	{ name = "gold coin", chance = 97000, maxCount = 242 },
	{ name = "platinum coin", chance = 18200, maxCount = 5 },
	{ name = "great health potion", chance = 1200, maxCount = 2 },
	{ id = 16124, chance = 1200, maxCount = 3 },
	{ id = 16123, chance = 1200, maxCount = 3 },
	{ name = "great mana potion", chance = 1200 },
	{ id = 7642, chance = 2210 },
	{ id = 16121, chance = 800 },
	{ id = 16122, chance = 1900, maxCount = 2 },
	{ id = 3028, chance = 950, maxCount = 3 },
	{ id = 3030, chance = 880, maxCount = 3 },
	{ id = 3029, chance = 900, maxCount = 3 },
	{ id = 9057, chance = 960, maxCount = 3 },
	{ id = 16120, chance = 4030 },
	{ id = 7436, chance = 9020 },
	{ id = 3041, chance = 4000 },
	{ id = 7428, chance = 1000 },
	{ id = 22086, chance = 2000 },
	{ id = 7419, chance = 20000 },
	{ id = 22085, chance = 400 },
	{ id = 7454, chance = 1000 },
	{ id = 22060, chance = 1000 },
	{ id = 3039, chance = 1000 },
	{ id = 7383, chance = 3000 },
	{ id = 3081, chance = 1000 },
	{ id = 22104, chance = 65000, unique = 1 },
	{ id = 7643, chance = 80000, maxCount = 2 },
	{ id = 8082, chance = 900 },
	{ id = 8094, chance = 5000 },
	{ id = 22087, chance = 8000 },
	{ id = 22084, chance = 30000 },
	{ id = 22062, chance = 20000, unique = 1 },
	{ id = 22083, chance = 800000, maxCount = 6 },
	{ id = 8061, chance = 25000 },
}

monster.attacks = {}

monster.defenses = {
	defense = 55,
	armor = 50,
	{ name = "speed", interval = 2000, chance = 12, speedChange = 1250, effect = CONST_ME_MAGIC_RED, target = false, duration = 10000 },
	{ name = "feroxa summon", interval = 2000, chance = 20, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -8 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onThink = function(monster, interval) end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
