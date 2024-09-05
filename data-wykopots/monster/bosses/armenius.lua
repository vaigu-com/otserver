local mType = Game.createMonsterType("Armenius")
local monster = {}

monster.description = "Armenius"
monster.experience = 500
monster.outfit = {
	lookType = 68,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 550
monster.maxHealth = 550
monster.race = "undead"
monster.corpse = 6006
monster.speed = 110
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
	{ text = "I smell warm blood!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 90230, maxCount = 60 },
	{ id = 9685, chance = 7600 },
	{ id = 11449, chance = 5100 },
	{ id = 3661, chance = 1910 },
	{ id = 3027, chance = 1800 },
	{ id = 3300, chance = 1560 },
	{ id = 236, chance = 1500 },
	{ id = 3271, chance = 1000 },
	{ id = 3114, chance = 1000 },
	{ id = 3284, chance = 420 },
	{ id = 3373, chance = 420 },
	{ id = 3010, chance = 230 },
	{ id = 3434, chance = 230 },
	{ id = 3056, chance = 220 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 50 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -50, maxDamage = -200, range = 1, radius = 1, effect = CONST_ME_SMALLCLOUDS, target = true },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -400, radius = 1, effect = CONST_ME_MAGIC_RED, target = false, duration = 60000 },
}

monster.defenses = {
	defense = 30,
	armor = 30,
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_GROUNDSHAKER, target = false, duration = 5000, outfitMonster = "bat" },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_MAGIC_RED, target = false, duration = 3000 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 15, maxDamage = 25, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 35 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
