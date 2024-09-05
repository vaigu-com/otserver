local mType = Game.createMonsterType("White Pale")
local monster = {}

monster.description = "White Pale"
monster.experience = 390
monster.outfit = {
	lookType = 564,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 500
monster.maxHealth = 500
monster.race = "blood"
monster.corpse = 18978
monster.speed = 85
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 0,
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
}

monster.loot = {
	{ id = 19083, chance = 2000 },
	{ name = "gold coin", chance = 100000, maxCount = 70 },
	{ id = 9692, chance = 50000 },
	{ id = 10275, chance = 100000 },
	{ id = 3577, chance = 50000, maxCount = 2 },
	{ id = 19358, chance = 1000 },
	{ id = 3327, chance = 15000 },
	{ id = 7452, chance = 3000 },
	{ id = 19359, chance = 3000 },
	{ id = 3028, chance = 5000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 45, attack = 40 },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -110, radius = 5, effect = CONST_ME_SMALLPLANTS, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 12, minDamage = -200, maxDamage = -300, radius = 3, effect = CONST_ME_HITAREA, target = false },
	{ name = "white pale paralyze", interval = 2000, chance = 11, target = false },
}

monster.defenses = {
	defense = 11,
	armor = 8,
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_HEALING, minDamage = 50, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "white pale summon", interval = 2000, chance = 12, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
