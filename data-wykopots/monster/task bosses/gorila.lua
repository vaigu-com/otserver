local mType = Game.createMonsterType("Gorila")
local monster = {}

monster.description = "a gorila"
monster.experience = 2515
monster.outfit = {
	lookType = 116,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 1940
monster.maxHealth = 1940
monster.race = "blood"
monster.corpse = 6043
monster.speed = 105
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
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
	{ text = "Hugah!", yell = false },
	{ text = "Ungh! Ungh!", yell = false },
	{ text = "Huaauaauaauaa!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 69000, minCount = 4, maxCount = 6 },
	{ id = 3587, chance = 90000, maxCount = 10 },
	{ id = 3029, chance = 85000, minCount = 2, maxCount = 5 },
	{ id = 3028, chance = 25001, minCount = 2, maxCount = 5 },
	{ id = 3357, chance = 85000 },
	{ id = 5883, chance = 100000, minCount = 4, maxCount = 6 },
	{ id = 3050, chance = 3000 },
	{ id = 3093, chance = 23000 },
	{ id = 266, chance = 570 },
	{ id = 11471, chance = 94900 },
	{ id = 3348, chance = 15000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -90 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_PHYSICALDAMAGE, minDamage = -20, maxDamage = -150, range = 7, radius = 5, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_PHYSICALDAMAGE, minDamage = -50, maxDamage = -150, range = 7, shootEffect = CONST_ANI_LARGEROCK, target = true },
}

monster.defenses = {
	defense = 20,
	armor = 20,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 360, effect = CONST_ME_MAGIC_RED, target = false, duration = 2000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
