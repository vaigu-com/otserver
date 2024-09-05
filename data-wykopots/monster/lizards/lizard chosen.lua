local mType = Game.createMonsterType("Lizard Chosen")
local monster = {}

monster.description = "a lizard chosen"
monster.experience = 2200
monster.outfit = {
	lookType = 344,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 620
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Temple of Equilibrium (Zao) Hidden stairs, Fire Dragon Dojo, Corruption Hole, Razzachai.",
}

monster.health = 3050
monster.maxHealth = 3050
monster.race = "blood"
monster.corpse = 10371
monster.speed = 136
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
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 50,
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
	{ text = "Grzzzzzzz!", yell = false },
	{ text = "Garrrblarrrrzzzz!", yell = false },
	{ text = "Kzzzzzz!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 97600, maxCount = 239 },
	{ id = 5876, chance = 2000 },
	{ id = 10408, chance = 10000 },
	{ id = 11673, chance = 2980 },
	{ name = "platinum coin", chance = 3030, maxCount = 5 },
	{ id = 10410, chance = 5960 },
	{ name = "great health potion", chance = 6910, maxCount = 3 },
	{ id = 10386, chance = 780 },
	{ id = 3028, chance = 2460, maxCount = 5 },
	{ id = 10409, chance = 2950 },
	{ id = 5881, chance = 970 },
	{ id = 3428, chance = 1000 },
	{ id = 10387, chance = 920 },
	{ id = 10385, chance = 110 },
	{ id = 10384, chance = 1040 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 80, attack = 80 },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -240, maxDamage = -320, length = 3, spread = 2, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -190, maxDamage = -340, radius = 3, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -90, maxDamage = -180, length = 8, spread = 0, effect = CONST_ME_GREEN_RINGS, target = false },
}

monster.defenses = {
	defense = 28,
	armor = 28,
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_HEALING, minDamage = 150, maxDamage = 300, effect = CONST_ME_GREEN_RINGS, target = false },
	{ name = "combat", interval = 2000, chance = 26, type = COMBAT_HEALING, minDamage = 15, maxDamage = 100, effect = CONST_ME_GREEN_RINGS, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
