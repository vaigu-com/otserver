local mType = Game.createMonsterType("Hoodinion")
local monster = {}

monster.description = "Hoodinion"
monster.experience = 550
monster.outfit = {
	lookType = 1424,
}

monster.health = 800
monster.maxHealth = 800
monster.race = "undead"
monster.corpse = 6323
monster.speed = 130
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
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
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {}

monster.loot = {
	{ name = "platinum coin", chance = 30000, maxCount = 2 },
	{ name = "gold coin", chance = 20000, maxCount = 112 },
	{ name = "small enchanted emerald", chance = 1492, maxCount = 2 },
	{ name = "green mushroom", chance = 4492, maxCount = 2 },
	{ name = "strong mana potion", chance = 9800 },
	{ name = "clerical mace", chance = 5155 },
	{ name = "great mana potion", chance = 4591 },
	{ name = "diamond sceptre", chance = 1400 },
	{ name = "silver brooch", chance = 3400 },
	{ name = "fern", chance = 30100 },
	{ name = "opal", chance = 5155 },
	{ name = "strong health potion", chance = 719 },
	{ name = "orange mushroom", chance = 10000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -20 },
	{ name = "combat", interval = 1000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -20, maxDamage = -130, range = 7, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICEATTACK, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -20, maxDamage = -130, range = 7, radius = 6, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICETORNADO, target = true },
	{ name = "combat", interval = 3000, chance = 13, type = COMBAT_ICEDAMAGE, minDamage = -20, maxDamage = -130, range = 7, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ANI_TARSALARROW, target = true },
	{ name = "combat", interval = 3000, chance = 16, type = COMBAT_HOLYDAMAGE, minDamage = -20, maxDamage = -130, range = 7, radius = 6, effect = CONST_ME_HITBYFIRE, target = false },
}

monster.defenses = {
	defense = 110,
	armor = 110,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
