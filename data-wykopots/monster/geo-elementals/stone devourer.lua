local mType = Game.createMonsterType("Stone Devourer")
local monster = {}

monster.description = "a stone devourer"
monster.experience = 2900
monster.outfit = {
	lookType = 486,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 879
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Warzone 1.",
}

monster.health = 4200
monster.maxHealth = 4200
monster.race = "undead"
monster.corpse = 15865
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	damage = 30,
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
	runHealth = 1,
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
	{ text = "Rumble!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "platinum coin", chance = 92000, maxCount = 7 },
	{ id = 16137, chance = 18679 },
	{ id = 16138, chance = 16320 },
	{ name = "great mana potion", chance = 15610, maxCount = 2 },
	{ id = 268, chance = 15050, maxCount = 2 },
	{ id = 237, chance = 14900, maxCount = 2 },
	{ id = 7643, chance = 14410 },
	{ id = 236, chance = 13840, maxCount = 2 },
	{ id = 9632, chance = 12850 },
	{ id = 7920, chance = 11360 },
	{ id = 15793, chance = 9940, maxCount = 10 },
	{ id = 16122, chance = 6960 },
	{ id = 16125, chance = 6810 },
	{ id = 7454, chance = 3340 },
	{ id = 3097, chance = 2840 },
	{ id = 3081, chance = 2270 },
	{ id = 7437, chance = 1490 },
	{ id = 7452, chance = 1490 },
	{ id = 3342, chance = 920 },
	{ id = 3333, chance = 850 },
	{ id = 3281, chance = 570 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -950 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -460, range = 7, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_STONES, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = -650, range = 7, shootEffect = CONST_ANI_LARGEROCK, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -150, maxDamage = -260, length = 5, spread = 0, effect = CONST_ME_STONES, target = false },
}

monster.defenses = {
	defense = 75,
	armor = 75,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
