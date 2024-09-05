local mType = Game.createMonsterType("Stonecracker")
local monster = {}

monster.description = "stonecracker"
monster.experience = 3500
monster.outfit = {
	lookType = 55,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 6500
monster.maxHealth = 6500
monster.race = "blood"
monster.corpse = 5999
monster.speed = 185
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.strategiesTarget = {
	nearest = 60,
	health = 15,
	damage = 15,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
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
	{ text = "HUAHAHA!", yell = false },
	{ text = "Smaaaashing!", yell = false },
}

monster.loot = {
	{ name = "assassin star", chance = 83070, maxCount = 100 },
	{ id = 5930, chance = 100000 },
	{ id = 7396, chance = 100000 },
	{ id = 3383, chance = 417 },
	{ id = 3275, chance = 20830 },
	{ id = 3281, chance = 4170 },
	{ name = "gold coin", chance = 100000, maxCount = 176 },
	{ id = 3577, chance = 31030, maxCount = 3 },
	{ id = 5893, chance = 100000, maxCount = 3 },
	{ id = 10310, chance = 1250 },
	{ id = 3033, chance = 75000, maxCount = 5 },
	{ name = "steel boots", chance = 5000 },
	{ id = 3265, chance = 41600 },
	{ id = 3342, chance = 5000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 103, attack = 100 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -280, range = 7, shootEffect = CONST_ANI_LARGEROCK, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -10, maxDamage = -300, range = 7, shootEffect = CONST_ANI_LARGEROCK, target = false },
}

monster.defenses = {
	defense = 57,
	armor = 44,
	{ name = "speed", interval = 2000, chance = 10, speedChange = 630, effect = CONST_ME_MAGIC_RED, target = false, duration = 7000 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 500, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 75 },
	{ type = COMBAT_FIREDAMAGE, percent = 40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 35 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
