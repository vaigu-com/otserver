local mType = Game.createMonsterType("The Lily of Night")
local monster = {}

monster.description = "a the lily of night"
monster.experience = 10000
monster.outfit = {
	lookType = 1068,
	lookHead = 91,
	lookBody = 38,
	lookLegs = 91,
	lookFeet = 79,
	lookAddons = 2,
	lookMount = 0,
}

monster.health = 19000
monster.maxHealth = 19000
monster.race = "undead"
monster.corpse = 28802
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Ah, the sweet music of a beating heart!", yell = false },
	{ text = "Death and Darkness", yell = false },
	{ text = "Embrace the night!", yell = false },
	{ text = "May night fall upon you!", yell = false },
}

monster.loot = {
	{ id = 3043, chance = 5550 },
	{ name = "platinum coin", chance = 100000, maxCount = 8 },
	{ name = "assassin star", chance = 10540, maxCount = 5 },
	{ id = 3027, chance = 9440 },
	{ name = "flask of demonic blood", chance = 20000 },
	{ name = "demonic essence", chance = 15740 },
	{ id = 3028, chance = 16510, maxCount = 3 },
	{ id = 3032, chance = 8220, maxCount = 3 },
	{ id = 3030, chance = 8650, maxCount = 3 },
	{ id = 3029, chance = 10380, maxCount = 3 },
	{ id = 9057, chance = 8720, maxCount = 3 },
	{ name = "small enchanted amethyst", chance = 14000, maxCount = 3 },
	{ name = "great health potion", chance = 11910, maxCount = 2 },
	{ id = 3026, chance = 8150, maxCount = 2 },
	{ id = 7404, chance = 1800 },
	{ id = 3041, chance = 1870 },
	{ id = 3567, chance = 500 },
	{ name = "gold ingot", chance = 1950 },
	{ id = 21974, chance = 21340 },
	{ id = 3007, chance = 940 },
	{ id = 3069, chance = 2600 },
	{ id = 21981, chance = 2090 },
	{ id = 21975, chance = 20330 },
	{ id = 8061, chance = 1440 },
	{ id = 3017, chance = 9370 },
	{ id = 3054, chance = 1950 },
	{ name = "soul orb", chance = 20690 },
	{ id = 8074, chance = 1300 },
	{ id = 3403, chance = 3030 },
	{ id = 8082, chance = 870 },
	{ id = 3037, chance = 1150 },
	{ name = "royal star", chance = 4110, maxCount = 3 },
	{ name = "silver token", chance = 10000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -280, length = 8, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -240, length = 8, spread = 0, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "drunk", interval = 2000, chance = 12, range = 6, radius = 3, effect = CONST_ME_STUN, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 21, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -650, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -700, length = 8, spread = 0, effect = CONST_ME_POFF, target = false },
}

monster.defenses = {
	defense = 75,
	armor = 75,
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
	{ name = "invisible", interval = 2000, chance = 20, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -20 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
