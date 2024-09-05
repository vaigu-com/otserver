local mType = Game.createMonsterType("Enfeebled Silencer")
local monster = {}

monster.description = "a silencer"
monster.experience = 1100
monster.outfit = {
	lookType = 585,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1443
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Feyrist.",
}

monster.health = 1100
monster.maxHealth = 1100
monster.race = "blood"
monster.corpse = 20155
monster.speed = 165
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 5,
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
	{ text = "Prrrroooaaaah!!! PRROAAAH!!", yell = false },
	{ text = "PRRRROOOOOAAAAAHHHH!!!", yell = false },
	{ text = "HUUUSSSSSSSSH!!", yell = false },
	{ text = "Hussssssh!!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "platinum coin", chance = 28000 },
	{ id = 3049, chance = 1140 },
	{ id = 3079, chance = 255 },
	{ name = "assassin star", chance = 7560, maxCount = 10 },
	{ id = 7387, chance = 630 },
	{ id = 7407, chance = 1140 },
	{ id = 7451, chance = 525 },
	{ id = 7454, chance = 780 },
	{ id = 812, chance = 667 },
	{ id = 813, chance = 682 },
	{ id = 20200, chance = 9045 },
	{ name = "fairy wings", chance = 10232 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350, condition = { type = CONDITION_POISON, totalDamage = 200, interval = 4000 } },
	{ name = "silencer skill reducer", interval = 2000, chance = 9, range = 3, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -40, maxDamage = -130, radius = 4, shootEffect = CONST_ANI_ONYXARROW, effect = CONST_ME_MAGIC_RED, target = true },
}

monster.defenses = {
	defense = 44,
	armor = 44,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 0, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 60 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 65 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
