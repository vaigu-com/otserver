local mType = Game.createMonsterType("Crazed Winter Vanguard")
local monster = {}

monster.description = "a Crazed Winter Vanguard"
monster.experience = 5400
monster.outfit = {
	lookType = 1136,
	lookHead = 0,
	lookBody = 123,
	lookLegs = 28,
	lookFeet = 20,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1730
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Court of Winter, Dream Labyrinth.",
}

monster.health = 5800
monster.maxHealth = 5800
monster.race = "undead"
monster.corpse = 30122
monster.speed = 190
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
}

monster.loot = {
	{ name = "platinum coin", chance = 80000, maxCount = 13 },
	{ id = 30058, chance = 12560, maxCount = 2 },
	{ name = "small enchanted ruby", chance = 12088 },
	{ name = "miraculum", chance = 9136 },
	{ name = "ultimate health potion", chance = 8520 },
	{ name = "dream essence egg", chance = 7808 },
	{ name = "tiger eye", chance = 6200 },
	{ name = "northwind rod", chance = 4832 },
	{ name = "glacier amulet", chance = 4736 },
	{ name = "ice rapier", chance = 5944 },
	{ name = "glacier robe", chance = 2312 },
	{ name = "elven amulet", chance = 680 },
	{ name = "blue gem", chance = 184 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ICEDAMAGE, minDamage = -200, maxDamage = -300, range = 5, radius = 4, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_ICEDAMAGE, minDamage = -220, maxDamage = -270, length = 4, spread = 0, effect = CONST_ME_GIANTICE, target = false },
	{ name = "crazed winter chain", interval = 2000, chance = 100, range = 6, target = true }, -- chain -- ice chain
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_ICEDAMAGE, minDamage = -250, maxDamage = -300, radius = 3, effect = CONST_ME_ICETORNADO, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 77,
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_ICEDAMAGE, percent = 70 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = -20 },
	{ type = COMBAT_FIREDAMAGE, percent = -30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
