local mType = Game.createMonsterType("Zarabustor")
local monster = {}

monster.description = "zarabustor"
monster.experience = 8000
monster.outfit = {
	lookType = 130,
	lookHead = 0,
	lookBody = 77,
	lookLegs = 92,
	lookFeet = 115,
	lookAddons = 1,
	lookMount = 0,
}

monster.health = 5100
monster.maxHealth = 5100
monster.race = "blood"
monster.corpse = 18273
monster.speed = 110
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	targetDistance = 4,
	runHealth = 900,
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

monster.summon = {
	maxSummons = 3,
	summons = {
		{ name = "Warlock", chance = 10, interval = 2000, count = 3 },
		{ name = "Green Djinn", chance = 10, interval = 2000, count = 3 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Killing is such a splendid diversion from my studies.", yell = false },
	{ text = "Time to test my newest spells!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 32000, maxCount = 80 },
	{ id = 3590, chance = 21000, maxCount = 4 },
	{ id = 3600, chance = 11000 },
	{ id = 3299, chance = 9600 },
	{ id = 3324, chance = 8330 },
	{ name = "great health potion", chance = 7190 },
	{ name = "great mana potion", chance = 6760 },
	{ name = "assassin star", chance = 5500, maxCount = 4 },
	{ id = 3728, chance = 5000 },
	{ id = 3051, chance = 4200 },
	{ id = 3062, chance = 4000 },
	{ id = 2917, chance = 3500 },
	{ id = 3567, chance = 3390 },
	{ id = 3029, chance = 3190 },
	{ id = 3034, chance = 3160 },
	{ id = 825, chance = 3040 },
	{ id = 3509, chance = 3000 },
	{ id = 3007, chance = 2670 },
	{ id = 11454, chance = 2500 },
	{ id = 3006, chance = 2420 },
	{ id = 3081, chance = 2320 },
	{ id = 2852, chance = 2310 },
	{ id = 3360, chance = 2240 },
	{ id = 2995, chance = 2060 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -130 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = 0, maxDamage = -250, range = 7, radius = 3, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_FIREAREA, target = true },
	{ name = "firefield", interval = 2000, chance = 10, range = 7, radius = 2, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -250, range = 7, shootEffect = CONST_ANI_ENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -130, maxDamage = -350, length = 8, spread = 0, effect = CONST_ME_BIGCLOUDS, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -250, range = 7, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -330, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
	{ name = "warlock skill reducer", interval = 2000, chance = 5, range = 5, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 100, maxDamage = 225, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 20, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 95 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
