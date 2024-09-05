local mType = Game.createMonsterType("Orewalker")
local monster = {}

monster.description = "an orewalker"
monster.experience = 4800
monster.outfit = {
	lookType = 490,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 883
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Warzone 3.",
}

monster.health = 7200
monster.maxHealth = 7200
monster.race = "undead"
monster.corpse = 15911
monster.speed = 190
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
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
	{ text = "Sizzle!", yell = false },
	{ text = "CLONK!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 198 },
	{ name = "platinum coin", chance = 100000, maxCount = 10 },
	{ id = 9057, chance = 15610, maxCount = 3 },
	{ id = 16141, chance = 14900, maxCount = 5 },
	{ id = 16124, chance = 14920, maxCount = 2 },
	{ id = 237, chance = 15610, maxCount = 2 },
	{ name = "great mana potion", chance = 14590, maxCount = 2 },
	{ id = 268, chance = 16280, maxCount = 4 },
	{ id = 236, chance = 14050, maxCount = 2 },
	{ id = 7643, chance = 9750, maxCount = 2 },
	{ id = 16125, chance = 12530 },
	{ id = 10315, chance = 19120 },
	{ id = 16133, chance = 20500 },
	{ id = 5880, chance = 14400 },
	{ id = 16135, chance = 15110 },
	{ id = 10310, chance = 11770 },
	{ id = 16121, chance = 8780 },
	{ id = 3097, chance = 3700 },
	{ id = 5904, chance = 2370 },
	{ id = 7413, chance = 2370 },
	{ id = 7454, chance = 3200 },
	{ id = 3371, chance = 2210 },
	{ id = 3037, chance = 880 },
	{ id = 16096, chance = 1780 },
	{ id = 3385, chance = 970 },
	{ id = 8050, chance = 310 },
	{ id = 3381, chance = 190 },
	{ id = 16163, chance = 240 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 70, attack = 75 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -296, maxDamage = -700, length = 4, spread = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -1500, length = 6, spread = 0, effect = CONST_ME_GROUNDSHAKER, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -800, maxDamage = -1080, radius = 3, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_SMALLPLANTS, target = true },
	{ name = "drunk", interval = 2000, chance = 15, radius = 4, effect = CONST_ME_SOUND_PURPLE, target = false, duration = 6000 },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -800, radius = 2, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
}

monster.defenses = {
	defense = 79,
	armor = 79,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 65 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
