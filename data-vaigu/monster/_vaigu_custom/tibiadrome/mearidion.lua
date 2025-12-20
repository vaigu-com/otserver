local mType = Game.createMonsterType("Mearidion")
local monster = {}

monster.description = "Mearidion"
monster.experience = 600
monster.outfit = {
	lookType = 1425,
}

monster.health = 850
monster.maxHealth = 850
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
	{ id = 3659, chance = 400 }, -- blue rose
	{ id = 3010, chance = 1800 }, -- emerald bangle
	{ id = 3031, chance = 65000, maxCount = 110 }, -- gold coin
	{ id = 238, chance = 3000 }, -- great mana potion
	{ id = 9302, chance = 1000 }, -- sacred tree amulet
	{ id = 678, chance = 2000, maxCount = 2 }, -- small enchanted amethyst
	{ id = 9057, chance = 2500, maxCount = 2 }, -- small topaz
	{ id = 237, chance = 1000 }, -- strong mana potion
	{ name = "rainbow quartz", chance = 719, maxCount = 4 },
	{ name = "Yol's bow", chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -70 },
	{ name = "combat", interval = 1000, chance = 12, type = COMBAT_FIREDAMAGE, minDamage = -20, maxDamage = -130, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_HITBYFIRE, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -20, maxDamage = -130, range = 7, shootEffect = CONST_ANI_BOLT, effect = CONST_ME_BLACKSMOKE, target = true },
	{ name = "combat", interval = 3000, chance = 13, type = COMBAT_DEATHDAMAGE, minDamage = -20, maxDamage = -130, range = 7, radius = 7, effect = CONST_ME_BLACKSMOKE, target = false },
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_HOLYDAMAGE, minDamage = -20, maxDamage = -130, range = 7, radius = 2, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 110,
	armor = 110,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -20 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
