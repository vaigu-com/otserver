local mType = Game.createMonsterType("Werefox")
local monster = {}

monster.description = "a werefox"
monster.experience = 1600
monster.outfit = {
	lookType = 1030,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1549
monster.Bestiary = {
	class = "Lycanthrope",
	race = BESTY_RACE_LYCANTHROPE,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Were-beasts cave south-west of Edron and in the Last Sanctum east of Cormaya.",
}

monster.health = 1500
monster.maxHealth = 1500
monster.race = "blood"
monster.corpse = 27521
monster.speed = 140
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
	staticAttackChance = 75,
	targetDistance = 4,
	runHealth = 40,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
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
	{ text = "Grrrrrr", yell = false },
	{ text = "Yelp!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 85000, maxCount = 85 },
	{ name = "platinum coin", chance = 90000, maxCount = 4 },
	{ id = 677, chance = 1570, maxCount = 2 },
	{ id = 3010, chance = 3100 },
	{ id = 27462, chance = 15470 },
	{ id = 27463, chance = 13010 },
	{ id = 268, chance = 4990 },
	{ id = 237, chance = 4360 },
	{ id = 3741, chance = 4950 },
	{ name = "assassin star", chance = 2990, maxCount = 5 },
	{ id = 3055, chance = 570 },
	{ id = 3098, chance = 820 },
	{ id = 3070, chance = 400 },
	{ id = 8094, chance = 400 },
	{ id = 22083, chance = 470 },
	{ id = 22060, chance = 670 },
	{ id = 27706, chance = 150 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -150 },
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_EARTHDAMAGE, minDamage = -85, maxDamage = -120, range = 7, shootEffect = CONST_ANI_REDSTAR, effect = CONST_ME_POISONAREA, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -160, maxDamage = -230, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "speed", interval = 4000, chance = 10, speedChange = -600, radius = 5, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000 },
}

monster.defenses = {
	defense = 35,
	armor = 35,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 60, maxDamage = 110, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 13, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
	{ name = "speed", interval = 2000, chance = 10, speedChange = 250, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 5000 },
	{ name = "werefox summon", interval = 2000, chance = 12, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
