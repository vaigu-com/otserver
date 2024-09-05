local mType = Game.createMonsterType("Golgordan")
local monster = {}

monster.description = "Golgordan"
monster.experience = 10000
monster.outfit = {
	lookType = 12,
	lookHead = 108,
	lookBody = 100,
	lookLegs = 105,
	lookFeet = 114,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 40000
monster.maxHealth = 40000
monster.race = "fire"
monster.corpse = 7893
monster.speed = 195
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 8,
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
	staticAttackChance = 85,
	targetDistance = 1,
	runHealth = 500,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.events = {
	"InquisitionBossDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Latrivan your fool!", yell = true },
	{ text = "Colateral damage is so fun!", yell = false },
	{ text = "I might reward you for killing my brother ~ with a swift death!", yell = false },
	{ text = "We are the right hand and the left hand of the seven!", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 243 },
	{ id = 3063, chance = 17820 },
	{ name = "great health potion", chance = 52940 },
	{ id = 3098, chance = 29410 },
	{ id = 3033, chance = 18410, maxCount = 18 },
	{ id = 3356, chance = 23530 },
	{ id = 3046, chance = 23530 },
	{ id = 3027, chance = 17650, maxCount = 10 },
	{ id = 7365, chance = 17650, maxCount = 7 },
	{ id = 3084, chance = 17650 },
	{ id = 3290, chance = 17650 },
	{ id = 3275, chance = 11760 },
	{ id = 3051, chance = 16760 },
	{ id = 3320, chance = 9860 },
	{ name = "gold ingot", chance = 6360 },
	{ id = 3062, chance = 4960 },
	{ id = 3054, chance = 11760 },
	{ id = 3029, chance = 16760, maxCount = 7 },
	{ id = 3081, chance = 11760 },
	{ id = 3076, chance = 1480 },
	{ id = 3420, chance = 8380 },
	{ name = "demonic essence", chance = 7880 },
	{ id = 3281, chance = 6880 },
	{ id = 3324, chance = 5880 },
	{ id = 3028, chance = 7380, maxCount = 4 },
	{ id = 3026, chance = 8380, maxCount = 11 },
	{ id = 3038, chance = 490 },
	{ id = 3002, chance = 5000 },
	{ id = 6299, chance = 5880 },
	{ id = 3048, chance = 3400 },
	{ id = 3066, chance = 6200 },
	{ id = 3069, chance = 980 },
	{ id = 3049, chance = 4500 },
	{ id = 3284, chance = 6500 },
	{ id = 3414, chance = 490 },
	{ name = "golden legs", chance = 490 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 80, attack = 100 },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_FIREDAMAGE, minDamage = -350, maxDamage = -550, length = 12, spread = 0, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "twins skill reducer", interval = 2000, chance = 11, target = false },
	{ name = "drunk", interval = 2000, chance = 9, length = 13, spread = 0, effect = CONST_ME_POFF, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -400, length = 5, spread = 2, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -450, maxDamage = -600, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_SMALLCLOUDS, target = true },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 12, minDamage = -400, maxDamage = -900, length = 10, spread = 0, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_FIREDAMAGE, minDamage = -150, maxDamage = -200, radius = 4, effect = CONST_ME_FIREATTACK, target = false },
}

monster.defenses = {
	defense = 54,
	armor = 48,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
