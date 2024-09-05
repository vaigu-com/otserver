local mType = Game.createMonsterType("True Dawnfire Asura")
local monster = {}

monster.description = "a true dawnfire asura"
monster.experience = 7360
monster.outfit = {
	lookType = 1068,
	lookHead = 79,
	lookBody = 94,
	lookLegs = 79,
	lookFeet = 120,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1620
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Asura Palace.",
}

monster.health = 8500
monster.maxHealth = 8500
monster.race = "blood"
monster.corpse = 28663
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10,
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
	staticAttackChance = 80,
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
	{ text = "Encounter the flames of destiny!", yell = false },
	{ text = "Fire and destruction!", yell = true },
	{ text = "I will end your torment. Do not run, little mortal.", yell = false },
	{ text = "Join me, brothers, for a BLOODY FRENZY!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 80000, maxCount = 12 },
	{ id = 3043, chance = 4184 },
	{ name = "flask of demonic blood", chance = 23200 },
	{ name = "great mana potion", chance = 13512, maxCount = 2 },
	{ id = 3033, chance = 5712, maxCount = 2 },
	{ id = 3028, chance = 6280, maxCount = 2 },
	{ id = 3032, chance = 14080, maxCount = 2 },
	{ id = 3030, chance = 8312, maxCount = 3 },
	{ id = 9057, chance = 7360, maxCount = 2 },
	{ name = "royal star", chance = 3488, maxCount = 3 },
	{ name = "small enchanted ruby", chance = 7360, maxCount = 2 },
	{ id = 3041, chance = 3048 },
	{ id = 6299, chance = 392 },
	{ name = "demonic essence", chance = 18592 },
	{ id = 8043, chance = 1968 },
	{ id = 21974, chance = 17576 },
	{ id = 826, chance = 1776 },
	{ id = 3078, chance = 2344 },
	{ id = 3574, chance = 2664 },
	{ id = 21981, chance = 2600 },
	{ id = 21975, chance = 18144 },
	{ id = 5911, chance = 2224 },
	{ id = 3016, chance = 2856 },
	{ id = 3039, chance = 3048 },
	{ name = "soul orb", chance = 16560 },
	{ id = 8074, chance = 1080 },
	{ id = 3071, chance = 1584 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
	{ name = "dawnfire asura fire", interval = 4000, chance = 10, range = 6, target = true }, --fire box
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -300, length = 7, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false }, -- md beam
	{ name = "flame strike", interval = 2000, chance = 20, minDamage = -350, maxDamage = -750, range = 7, target = false }, -- flame strike
	{ name = "speed", interval = 2000, chance = 15, speedChange = -700, radius = 3, effect = CONST_ME_SMALLCLOUDS, target = false, duration = 5000 }, -- paral
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -550, maxDamage = -750, radius = 6, effect = CONST_ME_MORTAREA, target = true }, --death ball
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
