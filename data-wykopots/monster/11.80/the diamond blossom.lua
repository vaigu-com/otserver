local mType = Game.createMonsterType("The Diamond Blossom")
local monster = {}

monster.description = "a the diamond blossom"
monster.experience = 10000
monster.outfit = {
	lookType = 1068,
	lookHead = 85,
	lookBody = 0,
	lookLegs = 86,
	lookFeet = 79,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 20500
monster.maxHealth = 20500
monster.race = "undead"
monster.corpse = 28798
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
	targetDistance = 3,
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
	{ text = "Welcome your frosty fate!", yell = false },
	{ text = "May you freeze forever!", yell = false },
	{ text = "Frost and fear!", yell = false },
}

monster.loot = {
	{ id = 3043, chance = 4270 },
	{ name = "platinum coin", chance = 100000, maxCount = 8 },
	{ name = "assassin star", chance = 9830, maxCount = 5 },
	{ id = 3027, chance = 11540 },
	{ name = "flask of demonic blood", chance = 18800 },
	{ name = "demonic essence", chance = 17950 },
	{ id = 3028, chance = 14510, maxCount = 3 },
	{ id = 3032, chance = 18000, maxCount = 3 },
	{ id = 3030, chance = 8650, maxCount = 3 },
	{ id = 3029, chance = 8900, maxCount = 3 },
	{ id = 9057, chance = 6500, maxCount = 3 },
	{ name = "small enchanted sapphire", chance = 8550, maxCount = 3 },
	{ name = "great health potion", chance = 18910, maxCount = 2 },
	{ id = 3026, chance = 9850, maxCount = 2 },
	{ id = 7404, chance = 1000 },
	{ id = 3041, chance = 2990 },
	{ id = 3567, chance = 600 },
	{ name = "gold ingot", chance = 2500 },
	{ id = 21974, chance = 20000 },
	{ id = 3007, chance = 1000 },
	{ id = 8083, chance = 4000 },
	{ id = 21981, chance = 1200 },
	{ id = 21975, chance = 20330 },
	{ id = 8061, chance = 2300 },
	{ id = 3017, chance = 9370 },
	{ id = 3054, chance = 1750 },
	{ name = "soul orb", chance = 20690 },
	{ id = 8074, chance = 1300 },
	{ id = 3403, chance = 5530 },
	{ id = 3067, chance = 850 },
	{ id = 3037, chance = 4700 },
	{ name = "royal star", chance = 5510, maxCount = 3 },
	{ name = "silver token", chance = 10000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -560 },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -280, length = 7, spread = 0, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -300, maxDamage = -600, length = 7, spread = 0, effect = CONST_ME_ICEAREA, target = false },
	{ name = "icicle rune", interval = 2000, chance = 18, minDamage = -500, maxDamage = -650, range = 7, target = true },
	{ name = "ice overlord freeze", interval = 2000, chance = 12, range = 7, target = true },
}

monster.defenses = {
	defense = 72,
	armor = 72,
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
