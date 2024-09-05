local mType = Game.createMonsterType("Dreadbeast")
local monster = {}

monster.description = "a dreadbeast"
monster.experience = 250
monster.outfit = {
	lookType = 101,
	lookHead = 20,
	lookBody = 30,
	lookLegs = 40,
	lookFeet = 50,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 800
monster.maxHealth = 800
monster.race = "undead"
monster.corpse = 4212
monster.speed = 100
monster.manaCost = 800

monster.changeTarget = {
	interval = 2000,
	chance = 7,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = true,
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
	{ id = 5925, chance = 650 },
	{ id = 3115, chance = 8280 },
	{ id = 3116, chance = 1960 },
	{ name = "gold coin", chance = 11550, maxCount = 88 },
	{ id = 3337, chance = 1530 },
	{ id = 3441, chance = 1530 },
	{ id = 3732, chance = 650 },
	{ id = 3357, chance = 2610 },
	{ id = 266, chance = 870 },
	{ id = 3114, chance = 2830 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 15, attack = 40 },
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_DROWNDAMAGE, minDamage = -70, maxDamage = -90, radius = 1, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_PURPLEENERGY, target = true },
	{ name = "dreadbeast skill reducer", interval = 2000, chance = 12, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 13, minDamage = -50, maxDamage = -60, radius = 3, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -25, maxDamage = -80, radius = 3, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 39,
	armor = 30,
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 35, maxDamage = 65, effect = CONST_ME_HITBYPOISON, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 55 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 75 },
	{ type = COMBAT_ICEDAMAGE, percent = 40 },
	{ type = COMBAT_HOLYDAMAGE, percent = -50 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
