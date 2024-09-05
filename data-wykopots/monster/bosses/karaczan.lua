local mType = Game.createMonsterType("Karaczan")
local monster = {}

monster.description = "a karaczan"
monster.experience = 9000
monster.outfit = {
	lookType = 352,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 15000
monster.maxHealth = 15000
monster.race = "venom"
monster.corpse = 11571
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 4,
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
	canPushCreatures = false,
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
	{ text = "Chrrr!", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 20000, maxCount = 3 },
	{ name = "gold coin", chance = 50000, maxCount = 100 },
	{ name = "platinum coin", chance = 50000, maxCount = 15 },
	{ name = "great health potion", chance = 50000, maxCount = 15 },
	{ name = "great mana potion", chance = 50000, maxCount = 15 },
	{ id = 7642, chance = 50000, maxCount = 15 },
	{ id = 3033, chance = 15200, maxCount = 4 },
	{ id = 3028, chance = 15770, maxCount = 4 },
	{ id = 3032, chance = 15730, maxCount = 4 },
	{ id = 3030, chance = 15700, maxCount = 4 },
	{ id = 9057, chance = 15730, maxCount = 4 },
	{ id = 3041, chance = 1910 },
	{ id = 3038, chance = 1910 },
	{ id = 3037, chance = 16010 },
	{ id = 3039, chance = 16010 },
	{ id = 5904, chance = 6000 },
	{ id = 3049, chance = 5000 },
	{ id = 3051, chance = 5000 },
	{ id = 3053, chance = 20000 },
	{ id = 3098, chance = 20000 },
	{ id = 3052, chance = 20000 },
	{ id = 3048, chance = 2000 },
	{ id = 14172, chance = 50000, maxCount = 7 },
	{ id = 12519, chance = 3000 },
	{ id = 12549, chance = 3000 },
	{ id = 12548, chance = 8000 },
	{ id = 14143, chance = 900 },
	{ id = 123, chance = 4000 },
	{ id = 8179, chance = 3000 },
	{ id = 10294, chance = 2500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300, condition = { type = CONDITION_POISON, totalDamage = 200, interval = 4000 } },
	{ name = "brimstone bug paralyze", interval = 2000, chance = 15, range = 7, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 20, minDamage = -800, maxDamage = -1600, radius = 6, effect = CONST_ME_BIGPLANTS, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_EARTHDAMAGE, minDamage = -120, maxDamage = -290, radius = 7, effect = CONST_ME_BIGPLANTS, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_MANADRAIN, minDamage = -60, maxDamage = -200, length = 8, spread = 0, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "brimstone bug wave", interval = 2000, chance = 16, minDamage = -60, maxDamage = -120, target = false },
	{ name = "drunk", interval = 2000, chance = 20, radius = 8, effect = CONST_ME_STUN, target = false, duration = 5000 },
}

monster.defenses = {
	defense = 33,
	armor = 26,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 50, maxDamage = 100, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 2000, chance = 2, type = COMBAT_HEALING, minDamage = 400, maxDamage = 1000, effect = CONST_ME_HITAREA, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
