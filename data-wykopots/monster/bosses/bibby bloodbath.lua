local mType = Game.createMonsterType("Bibby Bloodbath")
local monster = {}

monster.description = "Bibby Bloodbath"
monster.experience = 1500
monster.outfit = {
	lookType = 2,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 1200
monster.maxHealth = 1200
monster.race = "blood"
monster.corpse = 6008
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
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
	{ text = "Don't run, you'll just lose precious fat.", yell = false },
	{ text = "Hex hex!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 15 },
	{ id = 3316, chance = 45000 },
	{ id = 3287, chance = 22000, maxCount = 18 },
	{ id = 3265, chance = 22000 },
	{ id = 3383, chance = 14000 },
	{ id = 268, chance = 13000, maxCount = 3 },
	{ id = 3577, chance = 10000, maxCount = 2 },
	{ id = 266, chance = 9000, maxCount = 3 },
	{ id = 3578, chance = 7500 },
	{ id = 3557, chance = 79000 },
	{ id = 3049, chance = 77000 },
	{ id = 817, chance = 55000 },
	{ name = "butcher's axe", chance = 1600 },
	{ id = 3281, chance = 1000 },
	{ id = 7395, chance = 16000 },
	{ id = 3391, chance = 9030 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -200, length = 5, spread = 3, effect = CONST_ME_BLOCKHIT, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -300, radius = 3, effect = CONST_ME_BLOCKHIT, target = false, duration = 30000 },
}

monster.defenses = {
	defense = 35,
	armor = 22,
	{ name = "invisible", interval = 2000, chance = 12, duration = 5000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
