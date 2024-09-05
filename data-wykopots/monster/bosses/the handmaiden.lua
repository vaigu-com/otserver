local mType = Game.createMonsterType("The Handmaiden")
local monster = {}

monster.description = "the handmaiden"
monster.experience = 3850
monster.outfit = {
	lookType = 230,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 14500
monster.maxHealth = 14500
monster.race = "blood"
monster.corpse = 6311
monster.speed = 225
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
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 3100,
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
}

monster.loot = {
	{ name = "Handmaiden's protector", chance = 100000 },
	{ name = "gold coin", chance = 100000 },
	{ name = "platinum coin", chance = 40000 },
	{ id = 3050, chance = 35000 },
	{ id = 3049, chance = 35000 }, -- stealth ring
	{ name = "piece of iron", chance = 80000 },
	{ id = 3116, chance = 35000 }, --big bone
	{ name = "dark shield", chance = 20000 },
	{ name = "steel boots", chance = 40000 },
	{ name = "blue robe", chance = 15000 },
	{ name = "demonic essence", chance = 100000 },
	{ name = "soul orb", chance = 100000 },
	{ id = 6299, chance = 20000 }, -- death ring
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_MANADRAIN, minDamage = -150, maxDamage = -800, range = 7, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "drunk", interval = 1000, chance = 12, range = 1, target = true },
}

monster.defenses = {
	defense = 35,
	armor = 25,
	{ name = "speed", interval = 3000, chance = 12, speedChange = 380, effect = CONST_ME_MAGIC_RED, target = false, duration = 8000 },
	{ name = "invisible", interval = 4000, chance = 50, duration = 6000, effect = CONST_ME_MAGIC_RED },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_HEALING, minDamage = 100, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 1000, chance = 35, speedChange = 370, effect = CONST_ME_MAGIC_RED, target = false, duration = 30000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
