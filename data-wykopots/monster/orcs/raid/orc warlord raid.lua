local mType = Game.createMonsterType("Orc Warlord Raid")
local monster = {}

monster.name = "Orc Warlord"
monster.description = "an orc warlord"
monster.experience = 670
monster.outfit = {
	lookType = 2,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Orc Fortress, Foreigner Quarter, Zao Orc Land.",
}

monster.health = 950
monster.maxHealth = 950
monster.race = "blood"
monster.corpse = 6008
monster.speed = 117
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 15,
	damage = 15,
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
	{ text = "Ranat Ulderek!", yell = false },
	{ text = "Orc buta bana!", yell = false },
	{ text = "Ikem rambo zambo!", yell = false },
	{ text = "Futchi maruk buta!", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 600 },
	{ name = "gold coin", chance = 18000, maxCount = 45 },
	{ id = 3287, chance = 13920, maxCount = 18 },
	{ id = 3578, chance = 10800, maxCount = 2 },
	{ id = 3307, chance = 3450 },
	{ id = 3577, chance = 9000, maxCount = 2 },
	{ id = 3316, chance = 5400 },
	{ id = 3357, chance = 5210 },
	{ id = 3084, chance = 2190 },
	{ id = 3557, chance = 4280 },
	{ id = 3347, chance = 5260 },
	{ id = 3372, chance = 9000 },
	{ id = 3359, chance = 740 },
	{ id = 3384, chance = 1260 },
	{ id = 3265, chance = 1680 },
	{ id = 3322, chance = 320 },
	{ id = 3391, chance = 360 },
	{ id = 3049, chance = 90 },
	{ id = 266, chance = 470 },
	{ id = 7395, chance = 50 },
	{ id = 3063, chance = 30 },
	{ id = 818, chance = 280 },
	{ id = 11479, chance = 20620 },
	{ id = 10196, chance = 9640 },
	{ id = 11480, chance = 4610 },
	{ id = 11453, chance = 24350 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 50 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -200, range = 7, shootEffect = CONST_ANI_THROWINGSTAR, target = false },
}

monster.defenses = {
	defense = 28,
	armor = 28,
	{ name = "invisible", interval = 2000, chance = 5, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 80 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
