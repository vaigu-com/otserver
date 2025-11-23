local mType = Game.createMonsterType("True Dragonjade Asura")
local monster = {}

monster.description = "a true dragonjade asura"
monster.experience = 21600
monster.outfit = {
	lookType = 1068,
	lookHead = 94,
	lookBody = 25,
	lookLegs = 83,
	lookFeet = 121,
	lookAddons = 2,
	lookMount = 0,
}

monster.health = 16300
monster.maxHealth = 16300
monster.race = "fire"
monster.corpse = 28664
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
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
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
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
	{ name = "crystal coin", chance = 10186, maxCount = 1 },
	{ name = "magma clump", chance = 11440, maxCount = 1 },
	{ name = "onyx chip", chance = 12831, maxCount = 2 },
	{ name = "strange helmet", chance = 11001, maxCount = 1 },
	{ name = "fire sword", chance = 8347, maxCount = 1 },
	{ name = "ultimate mana potion", chance = 9687, maxCount = 3 },
	{ name = "blue gem", chance = 5868, maxCount = 1 },
	{ name = "magma legs", chance = 14497, maxCount = 1 },
	{ name = "white gem", chance = 9936, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1050 },
	{ name = "combat", interval = 2000, chance = 4, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -700, range = 7, shootEffect = CONST_ANI_ENVENOMEDARROW, condition = { type = CONDITION_POISON, totalDamage = 11500, interval = 1000 }, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -400, range = 7, target = false }, -- mana drain beam
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -450, maxDamage = -1330, length = 1, spread = 0, effect = CONST_ME_HITBYFIRE, target = false }, -- fire missile
	{ name = "combat", interval = 2000, chance = 5, type = COMBAT_EARTHDAMAGE, minDamage = -550, maxDamage = -950, radius = 4, effect = CONST_ME_PLANTATTACK, target = false }, -- death ball
	{ name = "speed", interval = 2000, chance = 15, speedChange = -200, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 30000 }, -- smoke berserk
	{ name = "combat", interval = 3200, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -450, radius = 4, range = 5, target = true, effect = CONST_ME_GREEN_ENERGY_SPARK },
}

monster.defenses = {
	defense = 55,
	armor = 77,
	mitigation = 2.16,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 50, maxDamage = 100, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
