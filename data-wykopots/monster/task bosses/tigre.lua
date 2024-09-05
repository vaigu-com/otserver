local mType = Game.createMonsterType("Tigre")
local monster = {}

monster.description = "a tigre"
monster.experience = 2750
monster.outfit = {
	lookType = 318,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3100
monster.maxHealth = 3100
monster.race = "blood"
monster.corpse = 8999
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 200,
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
	{ text = "GRAAARRRRRR", yell = false },
	{ text = "CHHHHHHHHHHH", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, minCount = 250, maxCount = 370 },
	{ id = 10293, chance = 100000, minCount = 2, maxCount = 4 },
	{ id = 3577, chance = 29500, maxCount = 2 },
	{ id = 10311, chance = 100000, maxCount = 2 },
	{ id = 3052, chance = 100000 },
	{ id = 236, chance = 6000 },
	{ id = 3415, chance = 38000 },
	{ id = 3428, chance = 6000 },
	{ id = 7454, chance = 38700 },
	{ id = 7436, chance = 14400 },
	{ id = 9046, chance = 7300 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 40, attack = 70 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -200, length = 5, spread = 3, effect = CONST_ME_BLOCKHIT, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -50, maxDamage = -250, range = 7, radius = 5, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_GROUNDSHAKER, target = false },
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{ name = "invisible", interval = 2000, chance = 10, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 300, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 80 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
