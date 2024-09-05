local mType = Game.createMonsterType("Mage Supply Dragon")
local monster = {}

monster.name = "Supply Dragon"
monster.description = "a supply dragon"
monster.experience = 10000
monster.outfit = {
	lookType = 947,
	lookHead = 90,
	lookBody = 91,
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
	{ name = "mana potion", chance = 100000, minCount = 80, maxCount = 120 }, -- 35gp
	{ name = "strong mana potion", chance = 80000, minCount = 50, maxCount = 80 }, -- 35gp
	{ name = "great mana potion", chance = 50000, minCount = 50, maxCount = 70 }, -- 35gp
	{ name = "ultimate mana potion", chance = 20000, minCount = 30, maxCount = 40 }, -- 35gp
	{ name = "avalanche rune", chance = 70000, minCount = 60, maxCount = 99 }, -- 35gp
	{ name = "great fireball rune", chance = 70000, minCount = 60, maxCount = 99 }, -- 35gp
	{ name = "stone shower rune", chance = 20000, minCount = 50, maxCount = 80 }, -- 35gp
	{ name = "thunderstorm rune", chance = 20000, minCount = 50, maxCount = 80 }, -- 35gp
	{ name = "sudden death rune", chance = 60000, minCount = 30, maxCount = 60 }, -- 35gp
	{ name = "soulfire rune", chance = 20000, minCount = 5, maxCount = 10 }, -- 35gp
	{ name = "magic wall rune", chance = 50000, minCount = 15, maxCount = 25 }, -- 35gp
	{ name = "fire bomb rune", chance = 20000, minCount = 15, maxCount = 20 }, -- 35gp
	{ name = "energy bomb rune", chance = 20000, minCount = 15, maxCount = 20 }, -- 35gp
	{ name = "poison bomb rune", chance = 20000, minCount = 15, maxCount = 20 }, -- 35gp
	{ name = "wild growth rune", chance = 20000, minCount = 10, maxCount = 20 }, -- 35gp
	{ id = 3097, chance = 25000, maxCount = 1 },
	{ id = 3052, chance = 50000, maxCount = 1 }, -- life ring
	{ name = "might ring", chance = 20000, maxCount = 1 },
	{ id = 3098, chance = 15000, maxCount = 1 },
	{ id = 3053, chance = 25000, maxCount = 1 },
	{ id = 3051, chance = 45000, maxCount = 1 }, -- energy ring
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
