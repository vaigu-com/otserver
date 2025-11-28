local mType = Game.createMonsterType("Murmillion")
local monster = {}

monster.description = "Murmillion"
monster.experience = 900
monster.outfit = {
	lookType = 1422,
}

monster.health = 1100
monster.maxHealth = 1100
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
	{ name = "platinum coin", chance = 30000, maxCount = 3 },
	{ id = 24390, chance = 3000, maxCount = 3 }, -- ancient coin
	{ id = 7439, chance = 1500 }, -- berserk potion
	{ id = 9067, chance = 100 }, -- crystal of power
	{ id = 3031, chance = 100000, maxCount = 200 }, -- gold coin
	{ id = 3306, chance = 900 }, -- golden sickle
	{ id = 5014, chance = 100 }, -- mandrake
	{ id = 16126, chance = 3600, maxCount = 2 }, -- red crystal fragment
	{ id = 3738, chance = 3200 }, -- sling herb
	{ id = 677, chance = 3000, maxCount = 3 }, -- small enchanted emerald
	{ id = 236, chance = 15000 }, -- strong health potion
	{ id = 814, chance = 3200 }, -- terra amulet
	{ id = 3727, chance = 4500 }, -- wood mushroom
	{ id = 9301, chance = 910 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -270 },
	{ name = "combat", interval = 1000, chance = 8, type = COMBAT_PHYSICALDAMAGE, minDamage = -20, maxDamage = -170, radius = 4, effect = CONST_ME_SLASH, target = false },
	{ name = "combat", interval = 2500, chance = 13, type = COMBAT_PHYSICALDAMAGE, minDamage = -20, maxDamage = -170, range = 5, radius = 7, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_DEATHDAMAGE, minDamage = -20, maxDamage = -170, range = 7, length = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = -100, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 15000 },
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
