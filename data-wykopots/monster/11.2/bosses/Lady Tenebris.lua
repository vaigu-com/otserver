local mType = Game.createMonsterType("Lady Tenebris")
local monster = {}

monster.description = "a Lady Tenebris"
monster.experience = 50000
monster.outfit = {
	lookType = 433,
	lookHead = 57,
	lookBody = 95,
	lookLegs = 38,
	lookFeet = 94,
	lookAddons = 2,
	lookMount = 0,
}

monster.health = 250000
monster.maxHealth = 250000
monster.race = "undead"
monster.corpse = 6068
monster.speed = 500
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 20,
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
	staticAttackChance = 98,
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

monster.summon = {
	maxSummons = 6,
	summons = {
		{ name = "Shadow Fiend", chance = 5, interval = 2000, count = 1 },
		{ name = "Shadow Tentacle", chance = 5, interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "May the embrace of darkness kill you!", yell = true },
	{ text = "I'm the one and only mistress of shadows!", yell = true },
	{ text = "LADY TENEBRIS BEGINS TO CHANNEL A POWERFULL SPELL! TAKE COVER!", yell = true },
}

monster.loot = {
	{ name = "platinum coin", chance = 10000, maxCount = 50 },
	{ id = 3043, chance = 10000, maxCount = 6 },
	{ id = 16124, chance = 10000, maxCount = 15 },
	{ name = "assassin star", chance = 10000, maxCount = 100 },
	{ id = 20264, chance = 7000, maxCount = 3 },
	{ name = "demonic essence", chance = 1000, maxCount = 2 },
	{ id = 7643, chance = 10000, maxCount = 100 },
	{ name = "great mana potion", chance = 10000, maxCount = 100 },
	{ id = 7642, chance = 10000, maxCount = 100 },
	{ id = 20063, chance = 2000, maxCount = 3 },
	{ id = 16121, chance = 10000, maxCount = 5 },
	{ id = 20062, chance = 2000, maxCount = 14 },
	{ id = 3041, chance = 10000, maxCount = 2 },
	{ id = 16122, chance = 10000, maxCount = 10 },
	{ id = 16120, chance = 10000, maxCount = 15 },
	{ id = 6528, chance = 6000 },
	{ id = 20278, chance = 6000 },
	{ id = 5914, chance = 6000 },
	{ id = 5911, chance = 6000 },
	{ id = 20276, chance = 1100 },
	{ id = 826, chance = 6000 },
	{ id = 281, chance = 6000 },
	{ id = 5954, chance = 6000 },
	{ id = 20274, chance = 6000, unique = 1 },
	{ id = 3079, chance = 6000 },
	{ id = 3052, chance = 6000 },
	{ id = 20280, chance = 6000 },
	{ id = 20279, chance = 6000 },
	{ id = 20277, chance = 6000 },
	{ id = 20064, chance = 800 },
	{ id = 20067, chance = 1000 },
	{ id = 20070, chance = 1000 },
	{ id = 20073, chance = 1000 },
	{ id = 20079, chance = 1000 },
	{ id = 20076, chance = 500 },
	{ id = 20082, chance = 1000 },
	{ id = 20085, chance = 400 },
	{ id = 20088, chance = 700 },
	{ id = 20065, chance = 100 },
	{ id = 20068, chance = 200 },
	{ id = 20071, chance = 1000 },
	{ id = 20074, chance = 500 },
	{ id = 20080, chance = 1000 },
	{ id = 20077, chance = 500 },
	{ id = 20083, chance = 250 },
	{ id = 20086, chance = 400 },
	{ id = 20089, chance = 200 },
	{ id = 20066, chance = 300 },
	{ id = 20069, chance = 700 },
	{ id = 20072, chance = 500 },
	{ id = 20075, chance = 300 },
	{ id = 20081, chance = 250 },
	{ id = 20078, chance = 300 },
	{ id = 20084, chance = 1300 },
	{ id = 20087, chance = 1000 },
	{ id = 20090, chance = 140 },
	{ id = 10345, chance = 6000 },
	{ id = 10344, chance = 6000 },
	{ id = 10343, chance = 6000 },
	{ id = 10342, chance = 6000 },
	{ id = 10341, chance = 6000 },
}

monster.attacks = {
	{ name = "melee", interval = 200, chance = 20, minDamage = 0, maxDamage = -1300 },
	{ name = "combat", interval = 200, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -600, maxDamage = -700, target = false },
	{ name = "combat", interval = 500, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -1200, maxDamage = -1500, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 500, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -2000, maxDamage = -2500, radius = 8, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	{ name = "combat", interval = 3000, chance = 35, type = COMBAT_HEALING, minDamage = 600, maxDamage = 2700, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 70 },
	{ type = COMBAT_DEATHDAMAGE, percent = 70 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
