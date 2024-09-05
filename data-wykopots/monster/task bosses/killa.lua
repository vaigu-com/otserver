local mType = Game.createMonsterType("Killa")
local monster = {}

monster.description = "a killa"
monster.experience = 4900
monster.outfit = {
	lookType = 358,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 4500
monster.maxHealth = 4500
monster.race = "blood"
monster.corpse = 10221
monster.speed = 115
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 10,
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
}

monster.loot = {
	{ name = "gold coin", chance = 50000, maxCount = 100 },
	{ name = "platinum coin", chance = 85000, minCount = 5, maxCount = 9 },
	{ id = 10279, chance = 95430, maxCount = 5 },
	{ id = 281, chance = 71300 },
	{ id = 3032, chance = 95150, maxCount = 5 },
	{ id = 3556, chance = 35100 },
	{ id = 3313, chance = 25975 },
	{ id = 812, chance = 24200 },
	{ id = 7413, chance = 11600 },
	{ id = 811, chance = 8700 },
	{ id = 9302, chance = 18500 },
	{ id = 813, chance = 78500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 80 },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_EARTHDAMAGE, minDamage = -66, maxDamage = -320, length = 8, spread = 3, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_EARTHDAMAGE, minDamage = -72, maxDamage = -105, range = 7, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_PHYSICALDAMAGE, minDamage = -20, maxDamage = -150, length = 4, spread = 2, effect = CONST_ME_POFF, target = false },
}

monster.defenses = {
	defense = 35,
	armor = 35,
	{ name = "speed", interval = 4000, chance = 75, speedChange = 750, effect = CONST_ME_MAGIC_RED, target = false, duration = 3000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
