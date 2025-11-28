local mType = Game.createMonsterType("Domestikion")
local monster = {}

monster.description = "Domestikion"
monster.experience = 500
monster.outfit = {
	lookType = 1426,
}

monster.health = 750
monster.maxHealth = 750
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
	{ name = "white pearl", chance = 3000 },
	{ id = 3098, chance = 1000 }, -- ring of healing
	{ name = "orichalcum pearl", chance = 6000, maxCount = 4 },
}

monster.loot = {
	{ name = "platinum coin", chance = 30000, maxCount = 2 },
	{ name = "gold coin", chance = 30000, maxCount = 112 },
	{ name = "wood cape", chance = 492 },
	{ name = "wand of dimensions", chance = 10 },
	{ name = "mandrake", chance = 50 },
	{ name = "leaf legs", chance = 492 },
	{ name = "small stone", chance = 492, maxCount = 4 },
	{ name = "small enchanted sapphire", chance = 492, maxCount = 2 },
	{ name = "cave turnip", chance = 55000, maxCount = 4 },
	{ name = "leaf legs", chance = 719 },
	{ name = "dark mushroom", chance = 719 },
	{ name = "prismatic quartz", chance = 719 },
	{ name = "leaf star", chance = 10000, maxCount = 8 },
	{ name = "strong health potion", chance = 6800, maxCount = 2 },
	{ name = "goat grass", chance = 5155 },
	{ name = "great health potion", chance = 591 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -50 },
	{ name = "combat", interval = 1000, chance = 8, type = COMBAT_ENERGYDAMAGE, minDamage = -20, maxDamage = -170, range = 7, radius = 3, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "combat", interval = 3000, chance = 13, type = COMBAT_HOLYDAMAGE, minDamage = -20, maxDamage = -170, range = 7, length = 3, effect = CONST_ME_HOLYAREA, target = true },
	{ name = "combat", interval = 3000, chance = 8, type = COMBAT_ENERGYDAMAGE, minDamage = -20, maxDamage = -170, range = 7, radius = 4, effect = CONST_ME_ENERGYAREA, target = false },
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
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
