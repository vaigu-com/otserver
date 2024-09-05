local mType = Game.createMonsterType("Lava Golem")
local monster = {}

monster.description = "a lava golem"
monster.experience = 6200
monster.outfit = {
	lookType = 491,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 884
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Warzone 2.",
}

monster.health = 9000
monster.maxHealth = 9000
monster.race = "fire"
monster.corpse = 15987
monster.speed = 210
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 80,
	random = 20,
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
	{ text = "Grrrrunt", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "platinum coin", chance = 100000, maxCount = 11 },
	{ id = 268, chance = 20720, maxCount = 2 },
	{ id = 236, chance = 19000, maxCount = 2 },
	{ id = 237, chance = 18150, maxCount = 2 },
	{ name = "great mana potion", chance = 16030, maxCount = 2 },
	{ id = 16130, chance = 15370, maxCount = 2 },
	{ id = 7643, chance = 15290 },
	{ id = 16131, chance = 15000 },
	{ id = 16122, chance = 14000, maxCount = 2 },
	{ id = 9636, chance = 13580 },
	{ id = 16141, chance = 12460, maxCount = 5 },
	{ id = 5880, chance = 11620 },
	{ id = 16126, chance = 10990 },
	{ id = 5914, chance = 7300 },
	{ id = 3037, chance = 6480 },
	{ id = 16120, chance = 6200 },
	{ id = 5909, chance = 4810 },
	{ id = 5911, chance = 3530 },
	{ id = 3071, chance = 2650 },
	{ id = 817, chance = 2950 },
	{ id = 818, chance = 2570 },
	{ id = 3280, chance = 1730 },
	{ id = 3320, chance = 1800 },
	{ id = 16115, chance = 1390 },
	{ id = 3419, chance = 1750 },
	{ id = 3039, chance = 1200 },
	{ id = 8074, chance = 530 },
	{ id = 826, chance = 580 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -390 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -350, maxDamage = -700, length = 8, spread = 0, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -600, maxDamage = -1300, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "lava golem soulfire", interval = 2000, chance = 15, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -220, maxDamage = -350, radius = 4, effect = CONST_ME_FIREAREA, target = true },
	{ name = "speed", interval = 2000, chance = 10, speedChange = -300, length = 5, spread = 3, effect = CONST_ME_BLOCKHIT, target = false, duration = 10000 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -280, maxDamage = -350, radius = 3, effect = CONST_ME_HITBYFIRE, target = false },
}

monster.defenses = {
	defense = 84,
	armor = 84,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 35 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
