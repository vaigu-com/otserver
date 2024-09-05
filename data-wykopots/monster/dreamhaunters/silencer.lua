local mType = Game.createMonsterType("Silencer")
local monster = {}

monster.description = "Silencer"
monster.experience = 3800
monster.outfit = {
	lookType = 585,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1014
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 100,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "All over the Roshamuul surface and Nightmare Isles.",
}

monster.health = 4900
monster.maxHealth = 4900
monster.race = "blood"
monster.corpse = 20155
monster.speed = 235
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
	{ name = "platinum coin", chance = 100000, maxCount = 8 },
	{ id = 3049, chance = 1500 },
	{ id = 3079, chance = 550 },
	{ id = 3421, chance = 2000 },
	{ name = "assassin star", chance = 7600, maxCount = 10 },
	{ id = 7387, chance = 1000 },
	{ id = 7407, chance = 2000 },
	{ id = 7413, chance = 2100 },
	{ id = 7451, chance = 830 },
	{ id = 7454, chance = 2500 },
	{ id = 812, chance = 880 },
	{ id = 813, chance = 1000 },
	{ id = 20062, chance = 560 },
	{ id = 20200, chance = 17000 },
	{ id = 20201, chance = 8410 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 80, attack = 70, condition = { type = CONDITION_POISON, totalDamage = 600, interval = 4000 } },
	{ name = "silencer skill reducer", interval = 2000, chance = 10, range = 3, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -40, maxDamage = -150, radius = 4, shootEffect = CONST_ANI_ONYXARROW, effect = CONST_ME_MAGIC_RED, target = true },
}

monster.defenses = {
	defense = 71,
	armor = 71,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 350, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 220, maxDamage = 425, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
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
