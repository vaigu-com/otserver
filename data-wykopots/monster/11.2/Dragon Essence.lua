local mType = Game.createMonsterType("Dragon Essence")
local monster = {}

monster.description = "a Dragon Essence"
monster.experience = 1600
monster.outfit = {
	lookType = 248,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 10000
monster.maxHealth = 10000
monster.race = "blood"
monster.corpse = 7091
monster.speed = 75
monster.manaCost = 290

monster.changeTarget = {
	interval = 5000,
	chance = 0,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = true,
	rewardBoss = false,
	illusionable = true,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 250,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "YOU WILL FREEZE!", yell = true },
	{ text = "ZCHHHHH!", yell = true },
	{ text = "I am so cool", yell = false },
	{ text = "Chill out!.", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 94000, maxCount = 100 },
	{ name = "gold coin", chance = 94000, maxCount = 100 },
	{ name = "gold coin", chance = 94000, maxCount = 42 },
	{ id = 3583, chance = 80370, maxCount = 5 },
	{ id = 3732, chance = 12000 },
	{ id = 2842, chance = 8900 },
	{ id = 3029, chance = 5100 },
	{ id = 7441, chance = 4000 },
	{ id = 3386, chance = 110 },
	{ id = 2991, chance = 11000 },
	{ id = 6569, chance = 11000 },
	{ id = 6570, chance = 11000 },
	{ id = 6571, chance = 11000 },
	{ id = 6393, chance = 11000 },
	{ id = 6574, chance = 11000 },
	{ id = 24384, chance = 11000 },
	{ id = 24390, chance = 11000 },
	{ id = 24936, chance = 11000 },
	{ id = 24937, chance = 11000 },
	{ id = 6576, chance = 11000 },
	{ id = 6279, chance = 11000 },
	{ id = 24383, chance = 11 },
	{ id = 24385, chance = 11 },
	{ id = 5791, chance = 110 },
	{ id = 123, chance = 110 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 57, attack = 67 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -175, maxDamage = -380, length = 8, spread = 0, effect = CONST_ME_POFF, target = false },
	{ name = "speed", interval = 2000, chance = 5, speedChange = -700, radius = 3, effect = CONST_ME_POFF, target = false, duration = 12000 },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -850, length = 7, spread = 0, effect = CONST_ME_ICEATTACK, target = false, duration = 18000 },
	{ name = "combat", interval = 2000, chance = 5, type = COMBAT_ICEDAMAGE, minDamage = -60, maxDamage = -120, radius = 3, effect = CONST_ME_ICETORNADO, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -100, maxDamage = -240, radius = 4, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 2000, chance = 5, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -220, length = 1, spread = 0, effect = CONST_ME_POFF, target = false },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -600, radius = 4, effect = CONST_ME_ICEAREA, target = true, duration = 12000 },
}

monster.defenses = {
	defense = 45,
	armor = 45,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 290, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
