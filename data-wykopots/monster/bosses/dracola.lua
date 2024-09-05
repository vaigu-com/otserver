local mType = Game.createMonsterType("Dracola")
local monster = {}

monster.description = "a dracola"
monster.experience = 7750
monster.outfit = {
	lookType = 231,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 15850
monster.maxHealth = 15850
monster.race = "undead"
monster.corpse = 6306
monster.speed = 205
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5,
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
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 95,
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
	{ text = "DEATH CAN'T STOP MY HUNGER!", yell = true },
}

monster.loot = {
	{ id = 5944, chance = 100000 },
	{ id = 5741, chance = 9000 },
	{ id = 7420, chance = 3000 },
	{ id = 3061, chance = 12000 },
	{ id = 5925, chance = 5000, maxCount = 3 },
	{ id = 238, chance = 9000, maxCount = 4 },
	{ id = 239, chance = 9000, maxCount = 4 },
	{ id = 6299, chance = 14000 },
	{ id = 3383, chance = 29000 },
	{ id = 3031, chance = 29000, maxCount = 100 },
	{ id = 3031, chance = 29000, maxCount = 100 },
	{ id = 3035, chance = 20000, maxCount = 8 },
	{ id = 6499, chance = 6000, maxCount = 4 },
	{ id = 6546, chance = 100000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 85, attack = 85 },
	{ name = "melee", interval = 2000, chance = 20, minDamage = -300, maxDamage = -395 },
	{ name = "combat", interval = 3000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -800, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -120, maxDamage = -390, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true },
	{ name = "combat", interval = 1000, chance = 23, type = COMBAT_EARTHDAMAGE, minDamage = -50, maxDamage = -180, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 4000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -600, length = 8, spread = 0, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -685, length = 8, spread = 3, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -600, length = 8, spread = 3, effect = CONST_ME_MAGIC_GREEN, target = false },
	-- drown
	{ name = "condition", type = CONDITION_DROWN, interval = 1000, chance = 20, length = 8, spread = 3, effect = CONST_ME_POFF, target = false },
}

monster.defenses = {
	defense = 39,
	armor = 40,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
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
