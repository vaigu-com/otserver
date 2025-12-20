local mType = Game.createMonsterType("Scissorion")
local monster = {}

monster.description = "Scissorion"
monster.experience = 600
monster.outfit = {
	lookType = 1423,
}

monster.health = 950
monster.maxHealth = 950
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
	targetDistance = 1,
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
	{ name = "gold coin", chance = 60000, maxCount = 136 },
	{ name = "grapes", chance = 30100, maxCount = 2 },
	{ name = "small enchanted sapphire", chance = 492, maxCount = 2 },
	{ name = "cookie", chance = 55000, maxCount = 5 },
	{ name = "strong health potion", chance = 6800, maxCount = 2 },
	{ name = "rainbow quartz", chance = 1086, maxCount = 2 },
	{ name = "small stone", chance = 8492, maxCount = 3 },
	{ name = "wood cape", chance = 492 },
	{ id = 5792, chance = 800 }, -- die
	{ name = "assassin dagger", chance = 150 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -170 },
	{ name = "melee", interval = 2000, chance = 16, minDamage = 0, maxDamage = -10, condition = { type = CONDITION_POISON, totalDamage = 500, interval = 2000 } },
	{ name = "combat", interval = 1000, chance = 8, type = COMBAT_EARTHDAMAGE, minDamage = -20, maxDamage = -70, range = 7, radius = 4, effect = CONST_ME_GREENSMOKE, target = false },
	{ name = "combat", interval = 3000, chance = 13, type = COMBAT_FIREDAMAGE, minDamage = -20, maxDamage = -270, range = 7, effect = CONST_ME_CRITICAL_DAMAGE, target = true },
	{ name = "combat", interval = 3000, chance = 8, type = COMBAT_FIREDAMAGE, minDamage = -20, maxDamage = -70, range = 7, length = 3, effect = CONST_ME_FIREATTACK, target = false },
}

monster.defenses = {
	defense = 110,
	armor = 110,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
