local mType = Game.createMonsterType("Knight Supply Dragon")
local monster = {}

monster.name = "Supply Dragon"
monster.description = "a supply dragon"
monster.experience = 10000
monster.outfit = {
	lookType = 947,
	lookHead = 90,
	lookBody = 113,
	lookLegs = 85,
	lookFeet = 85,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 12000
monster.maxHealth = 12000
monster.race = "blood"
monster.corpse = 25064
monster.speed = 75
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 0,
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
	runHealth = 12000,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 5,
	color = 71,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "mana potion", chance = 100000, minCount = 120, maxCount = 200 },
	{ name = "health potion", chance = 100000, minCount = 50, maxCount = 80 },
	{ name = "great health potion", chance = 100000, minCount = 60, maxCount = 80 },
	{ name = "ultimate health potion", chance = 100000, minCount = 30, maxCount = 40 },
	{ id = 3148, chance = 60000, minCount = 10, maxCount = 15 },
	{ name = "fire bomb rune", chance = 60000, minCount = 20, maxCount = 25 },
	{ name = "poison bomb rune", chance = 60000, minCount = 20, maxCount = 25 },
	{ name = "magic wall rune", chance = 60000, minCount = 10, maxCount = 20 },
	{ id = 3097, chance = 35000, maxCount = 1 },
	{ id = 3052, chance = 80000, maxCount = 1 }, -- life ring
	{ name = "might ring", chance = 35000, maxCount = 1 },
	{ id = 3098, chance = 25000, maxCount = 1 },
	{ id = 3053, chance = 25000, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -150 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -10, maxDamage = -30, range = 7, shootEffect = CONST_ANI_ENERGY, target = true },
}

monster.defenses = {
	defense = 20,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
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
