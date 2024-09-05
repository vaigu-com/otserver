local mType = Game.createMonsterType("Latrivan")
local monster = {}

monster.description = "Latrivan"
monster.experience = 10000
monster.outfit = {
	lookType = 12,
	lookHead = 120,
	lookBody = 128,
	lookLegs = 121,
	lookFeet = 111,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 25000
monster.maxHealth = 25000
monster.race = "fire"
monster.corpse = 7893
monster.speed = 170
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
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
	runHealth = 0,
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
	{ text = "I might reward you for killing my brother ~ with a swift dead!", yell = true },
	{ text = "Colateral damage is so fun!", yell = true },
	{ text = "Golgordan you fool!", yell = true },
	{ text = "We are the brothers of fear!", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 273 },
	{ name = "platinum coin", chance = 3000, maxCount = 6 },
	{ id = 3063, chance = 5560 },
	{ name = "great health potion", chance = 61110 },
	{ id = 3098, chance = 27780 },
	{ id = 3033, chance = 5560, maxCount = 15 },
	{ id = 3356, chance = 5560 },
	{ id = 3046, chance = 16670 },
	{ id = 3027, chance = 22220, maxCount = 28 },
	{ id = 7365, chance = 3000, maxCount = 7 },
	{ id = 3084, chance = 2000 },
	{ id = 3290, chance = 5560 },
	{ id = 3275, chance = 22220 },
	{ id = 3051, chance = 5560 },
	{ id = 3320, chance = 11060 },
	{ name = "gold ingot", chance = 10710 },
	{ id = 3054, chance = 11110 },
	{ id = 3029, chance = 16670, maxCount = 9 },
	{ id = 3081, chance = 5560 },
	{ id = 3420, chance = 12110 },
	{ name = "demonic essence", chance = 11110 },
	{ id = 3281, chance = 58110 },
	{ id = 3324, chance = 3400 },
	{ id = 3034, chance = 4000, maxCount = 13 },
	{ id = 3032, chance = 22220, maxCount = 4 },
	{ id = 3041, chance = 5560 },
	{ id = 6299, chance = 27780 },
	{ id = 3079, chance = 2440 },
	{ id = 3048, chance = 5560 },
	{ id = 3066, chance = 5560 },
	{ id = 3069, chance = 3000 },
	{ id = 3414, chance = 490 },
	{ name = "golden legs", chance = 980 },
	{ id = 7440, chance = 3000 },
	{ id = 3072, chance = 2400 },
	{ id = 3049, chance = 5560 },
	{ id = 3284, chance = 16670 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = 0, maxDamage = -850, length = 8, spread = 3, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 1000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -50, maxDamage = -250, length = 7, spread = 0, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = 0, maxDamage = -600, range = 4, radius = 1, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -60, maxDamage = -200, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = false },
}

monster.defenses = {
	defense = 54,
	armor = 48,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 1 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -1 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
