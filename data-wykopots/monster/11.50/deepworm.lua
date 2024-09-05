local mType = Game.createMonsterType("Deepworm")
local monster = {}

monster.description = "a deepworm"
monster.experience = 2300
monster.outfit = {
	lookType = 1033,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1531
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Gnome Deep Hub.",
}

monster.health = 3500
monster.maxHealth = 3500
monster.race = "blood"
monster.corpse = 27545
monster.speed = 102
monster.manaCost = 450

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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 85,
	targetDistance = 1,
	runHealth = 0,
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
	{ text = "bluuuuuure", yell = false },
	{ text = "slurp slurp ... slurp", yell = false },
}

monster.loot = {
	{ name = "small enchanted ruby", chance = 3640, maxCount = 2 },
	{ name = "deepworm jaws", chance = 24810 },
	{ name = "ham", chance = 20430 },
	{ name = "green mushroom", chance = 20320 },
	{ name = "wood mushroom", chance = 19790 },
	{ name = "meat", chance = 19040 },
	{ name = "dark mushroom", chance = 13580 },
	{ name = "deepworm spike roots", chance = 11870 },
	{ name = "deepworm spikes", chance = 10370 },
	{ id = 3052, chance = 7590 }, -- life ring
	{ name = "terra amulet", chance = 5130 },
	{ name = "green crystal shard", chance = 3960 },
	{ name = "small enchanted amethyst", chance = 3640 },
	{ id = 281, chance = 1390 },
	{ name = "suspicious device", chance = 1070 },
	{ name = "springsprout rod", chance = 960 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -300, length = 5, spread = 0, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -350, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_HITBYPOISON, target = true },
}

monster.defenses = {
	defense = 73,
	armor = 73,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
