local mType = Game.createMonsterType("Esmeralda")
local monster = {}

monster.description = "esmeralda"
monster.experience = 600
monster.outfit = {
	lookType = 305,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 800
monster.maxHealth = 800
monster.race = "blood"
monster.corpse = 8957
monster.speed = 122
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
	{ text = "Fcccccchhhhhh", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 68125, maxCount = 4 },
	{ id = 3098, chance = 100000 },
	{ id = 3428, chance = 41400 },
	{ id = 3269, chance = 30050 },
	{ name = "gold coin", chance = 58775, maxCount = 100 },
	{ name = "gold coin", chance = 58775, maxCount = 19 },
	{ id = 9668, chance = 100000 },
	{ id = 3326, chance = 14150 },
	{ id = 3370, chance = 45950 },
	{ id = 3735, chance = 9600 },
	{ id = 811, chance = 2775 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 60, attack = 50, condition = { type = CONDITION_POISON, totalDamage = 100, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -110, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 22, minDamage = -100, maxDamage = -100, length = 8, spread = 0, effect = CONST_ME_SMALLPLANTS, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -80, maxDamage = -80, radius = 3, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -110, range = 7, radius = 3, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 30,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
