local mType = Game.createMonsterType("Dark Monk")
local monster = {}

monster.description = "a dark monk"
monster.experience = 145
monster.outfit = {
	lookType = 225,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 225
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Dark Cathedral, Vandura (Cult Cave), Foreigner Quarter.",
}

monster.health = 190
monster.maxHealth = 190
monster.race = "blood"
monster.corpse = 18090
monster.speed = 115
monster.manaCost = 480

monster.changeTarget = {
	interval = 4000,
	chance = 5,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 20,
	damage = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
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
	{ text = "You are no match to us!", yell = false },
	{ text = "This is where your path will end!", yell = false },
	{ text = "Your end has come!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 14600, maxCount = 18 },
	{ id = 3077, chance = 900 },
	{ id = 3600, chance = 20550 },
	{ id = 2885, chance = 380 },
	{ id = 9646, chance = 1900 },
	{ id = 2914, chance = 550 },
	{ id = 11492, chance = 6666 },
	{ id = 11493, chance = 990 },
	{ id = 3061, chance = 990 },
	{ id = 268, chance = 790 },
	{ id = 3050, chance = 120 },
	{ id = 10303, chance = 10500 },
	{ id = 2815, chance = 1790 },
	{ id = 3551, chance = 890 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 30, attack = 50 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -20, maxDamage = -50, range = 1, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 43,
	armor = 22,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 25, maxDamage = 49, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
