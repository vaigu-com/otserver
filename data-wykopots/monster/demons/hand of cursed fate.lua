local mType = Game.createMonsterType("Hand of Cursed Fate")
local monster = {}

monster.description = "a hand of cursed fate"
monster.experience = 5000
monster.outfit = {
	lookType = 230,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 281
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Pits of Inferno, The Battlefield, The Arcanum, The Blood Halls and The Crystal Caves.",
}

monster.health = 7500
monster.maxHealth = 7500
monster.race = "blood"
monster.corpse = 6311
monster.speed = 130
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
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
	staticAttackChance = 20,
	targetDistance = 1,
	runHealth = 3500,
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
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "platinum coin", chance = 100000, maxCount = 7 },
	{ name = "flask of demonic blood", chance = 30000, maxCount = 4 },
	{ name = "soul orb", chance = 31111 },
	{ name = "demonic essence", chance = 12000 },
	{ id = 3029, chance = 11000, maxCount = 4 },
	{ id = 7643, chance = 19000 },
	{ name = "great mana potion", chance = 19990, maxCount = 2 },
	{ id = 3062, chance = 9090 },
	{ id = 7365, chance = 8333, maxCount = 3 },
	{ name = "assassin star", chance = 7692, maxCount = 5 },
	{ id = 3010, chance = 3500 },
	{ id = 3084, chance = 8740 },
	{ id = 3071, chance = 4890 },
	{ id = 3370, chance = 3850 },
	{ id = 6299, chance = 1750 },
	{ id = 3381, chance = 8900 },
	{ id = 3051, chance = 3150 },
	{ id = 3055, chance = 1005 },
	{ id = 7414, chance = 100 },
	{ name = "gold ingot", chance = 800 },
	{ id = 3324, chance = 570 },
	{ id = 3036, chance = 1100 },
	{ id = 3037, chance = 5940 },
	{ id = 3079, chance = 200 },
	{ id = 5799, chance = 195 },
	{ id = 5668, chance = 247 },
	{ id = 3155, chance = 4200, maxCount = 8 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 70, attack = 130, condition = { type = CONDITION_POISON, totalDamage = 400, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -920, range = 1, target = false },
	{ name = "drunk", interval = 2000, chance = 10, radius = 4, effect = CONST_ME_SMALLCLOUDS, target = false, duration = 6000 },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -880, range = 1, effect = CONST_ME_SMALLCLOUDS, target = false },
}

monster.defenses = {
	defense = 53,
	armor = 53,
	{ name = "speed", interval = 2000, chance = 7, speedChange = 980, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
	{ name = "invisible", interval = 2000, chance = 9, duration = 4000, effect = CONST_ME_MAGIC_BLUE },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_HEALING, minDamage = 150, maxDamage = 385, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
