local mType = Game.createMonsterType("Brimstone Bug Raid")
local monster = {}

monster.name = "Brimstone Bug"
monster.description = "a brimstone bug"
monster.experience = 900
monster.outfit = {
	lookType = 352,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 674
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Beneath Razzachai, Northern Zao Plantations, Brimstone Bug Caves, Chyllfroest, Krailos Spider Lair.",
}

monster.health = 1300
monster.maxHealth = 1300
monster.race = "venom"
monster.corpse = 11571
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
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
	canPushCreatures = false,
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
	{ text = "Chrrr!", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 1000 },
	{ name = "gold coin", chance = 100000, maxCount = 199 },
	{ id = 9640, chance = 50000 },
	{ id = 10305, chance = 20000 },
	{ id = 10315, chance = 14970 },
	{ id = 11703, chance = 10000 },
	{ id = 237, chance = 9025 },
	{ id = 236, chance = 9003 },
	{ id = 11702, chance = 5710 },
	{ id = 3032, chance = 2702, maxCount = 4 },
	{ id = 5904, chance = 1739 },
	{ id = 3049, chance = 912 },
	{ id = 3055, chance = 110 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -150, condition = { type = CONDITION_POISON, totalDamage = 300, interval = 4000 } },
	{ name = "brimstone bug paralyze", interval = 2000, chance = 7, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 6, type = COMBAT_EARTHDAMAGE, minDamage = -180, maxDamage = -270, radius = 7, effect = CONST_ME_BIGPLANTS, target = false },
	{ name = "combat", interval = 2000, chance = 7, type = COMBAT_MANADRAIN, minDamage = -130, maxDamage = -200, length = 8, spread = 0, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "brimstone bug wave", interval = 2000, chance = 16, minDamage = -80, maxDamage = -120, target = false },
}

monster.defenses = {
	defense = 38,
	armor = 38,
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_HEALING, minDamage = 50, maxDamage = 100, effect = CONST_ME_HITAREA, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
