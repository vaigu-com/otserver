local mType = Game.createMonsterType("The Blazing Rose")
local monster = {}

monster.description = "a the blazing rose"
monster.experience = 10000
monster.outfit = {
	lookType = 1068,
	lookHead = 95,
	lookBody = 94,
	lookLegs = 57,
	lookFeet = 79,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 18000
monster.maxHealth = 18000
monster.race = "undead"
monster.corpse = 28794
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
	{ text = "Encounter the flames of destiny!", yell = false },
	{ text = "Fire and destruction!", yell = true },
	{ text = "I will end your torment. Do not run, little mortal.", yell = false },
	{ text = "Join me, brothers, for a BLOODY FRENZY!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 12 },
	{ id = 3043, chance = 5230 },
	{ name = "flask of demonic blood", chance = 29000 },
	{ name = "great mana potion", chance = 16890, maxCount = 2 },
	{ id = 3033, chance = 7140, maxCount = 2 },
	{ id = 3028, chance = 7850, maxCount = 2 },
	{ id = 3032, chance = 17600, maxCount = 2 },
	{ id = 3030, chance = 10390, maxCount = 3 },
	{ id = 9057, chance = 9200, maxCount = 2 },
	{ name = "royal star", chance = 4360, maxCount = 3 },
	{ name = "small enchanted ruby", chance = 9200, maxCount = 2 },
	{ id = 3041, chance = 3810 },
	{ id = 6299, chance = 490 },
	{ name = "demonic essence", chance = 23240 },
	{ id = 8043, chance = 2460 },
	{ id = 21974, chance = 21970 },
	{ id = 826, chance = 2220 },
	{ id = 3078, chance = 2930 },
	{ id = 3574, chance = 3330 },
	{ id = 21981, chance = 3250 },
	{ id = 21975, chance = 22680 },
	{ id = 5911, chance = 2780 },
	{ id = 3016, chance = 3570 },
	{ id = 3039, chance = 3810 },
	{ name = "soul orb", chance = 20700 },
	{ id = 8074, chance = 1350 },
	{ id = 3071, chance = 1980 },
	{ name = "silver token", chance = 10000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
	{ name = "dawnfire asura fire", interval = 4000, chance = 10, range = 6, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -300, length = 8, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "flame strike", interval = 2000, chance = 20, minDamage = -450, maxDamage = -830, range = 7, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -700, radius = 3, effect = CONST_ME_SMALLCLOUDS, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -550, maxDamage = -750, radius = 6, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 77,
	armor = 77,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 220, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
