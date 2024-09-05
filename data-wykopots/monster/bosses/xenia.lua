local mType = Game.createMonsterType("Xenia")
local monster = {}

monster.description = "xenia"
monster.experience = 255
monster.outfit = {
	lookType = 137,
	lookHead = 95,
	lookBody = 115,
	lookLegs = 115,
	lookFeet = 95,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 290
monster.maxHealth = 290
monster.race = "blood"
monster.corpse = 18261
monster.speed = 88
monster.manaCost = 450

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.strategiesTarget = {
	nearest = 60,
	health = 15,
	damage = 15,
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
	canPushCreatures = false,
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
	{ text = "Stand still!", yell = false },
	{ text = "One more head for me!", yell = false },
	{ text = "Head off!", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 100000 },
	{ id = 3492, chance = 50000, maxCount = 10 },
	{ name = "platinum coin", chance = 100000, maxCount = 10 },
	{ id = 3358, chance = 6666 },
	{ id = 3008, chance = 2500 },
	{ id = 3275, chance = 3333 },
	{ id = 3352, chance = 5000 },
	{ id = 3585, chance = 10000, maxCount = 4 },
	{ id = 3308, chance = 10000 },
	{ id = 3577, chance = 20000, maxCount = 3 },
	{ id = 3030, chance = 45000, maxCount = 3 },
	{ id = 3028, chance = 45000, maxCount = 3 },
	{ id = 3084, chance = 3000 },
	{ id = 3357, chance = 1533 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -50 },
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -28, maxDamage = -42, range = 7, shootEffect = CONST_ANI_SPEAR, target = false },
}

monster.defenses = {
	defense = 14,
	armor = 12,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -6 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 7 },
	{ type = COMBAT_DEATHDAMAGE, percent = -7 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
