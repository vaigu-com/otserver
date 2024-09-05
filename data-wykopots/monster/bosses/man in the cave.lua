local mType = Game.createMonsterType("Man in the Cave")
local monster = {}

monster.description = "man in the cave"
monster.experience = 555
monster.outfit = {
	lookType = 128,
	lookHead = 95,
	lookBody = 116,
	lookLegs = 95,
	lookFeet = 114,
	lookAddons = 2,
	lookMount = 0,
}

monster.health = 1485
monster.maxHealth = 1485
monster.race = "blood"
monster.corpse = 18165
monster.speed = 105
monster.manaCost = 0

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
	runHealth = 0,
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

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Monk", chance = 20, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "THE MONKS ARE MINE", yell = true },
	{ text = "I will rope you up! All of you!", yell = false },
	{ text = "You have been roped up!", yell = false },
	{ text = "A MIC to rule them all!", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 100000 },
	{ name = "platinum coin", chance = 100000, maxCount = 12 },
	{ id = 3003, chance = 20000 },
	{ id = 3003, chance = 6666 },
	{ id = 3003, chance = 3333 },
	{ id = 3602, chance = 4000 },
	{ id = 5913, chance = 2000 },
	{ id = 7290, chance = 80000 },
	{ id = 7463, chance = 6666 },
	{ id = 7386, chance = 60000 },
	{ id = 7458, chance = 1000 },
	{ id = 3057, chance = 500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 60, attack = 30 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -10, maxDamage = -195, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
	{ name = "combat", interval = 1000, chance = 100, type = COMBAT_LIFEDRAIN, minDamage = -20, maxDamage = -130, range = 1, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 30,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
