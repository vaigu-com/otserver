local mType = Game.createMonsterType("Undead Jester")
local monster = {}

monster.description = "an undead jester"
monster.experience = 350
monster.outfit = {
	lookType = 273,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 114,
	lookFeet = 0,
	lookAddons = 2,
	lookMount = 0,
}

monster.health = 355
monster.maxHealth = 355
monster.race = "blood"
monster.corpse = 18238
monster.speed = 112
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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

monster.summon = {
	maxSummons = 3,
	summons = {
		{ name = "skeleton mage", chance = 30, interval = 2000, count = 1 },
	},
}

monster.loot = {
	{ id = 8853, chance = 10000, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{
		name = "combat",
		interval = 2000,
		chance = 40,
		type = COMBAT_LIFEDRAIN,
		minDamage = 0,
		maxDamage = -5,
		length = 8,
		spread = 0,
		effect = CONST_ME_MAGIC_RED,
		target = false,
	},
	{
		name = "combat",
		interval = 2000,
		chance = 50,
		type = COMBAT_EARTHDAMAGE,
		minDamage = -1,
		maxDamage = -2,
		radius = 6,
		effect = CONST_ME_MAGIC_GREEN,
		target = false,
	},
	{
		name = "combat",
		interval = 2000,
		chance = 15,
		type = COMBAT_ENERGYDAMAGE,
		minDamage = -1,
		maxDamage = -7,
		range = 6,
		length = 6,
		spread = 7,
		shootEffect = CONST_ANI_ENERGY,
		effect = CONST_ME_ENERGYAREA,
		target = false,
	},
	{
		name = "combat",
		interval = 2000,
		chance = 10,
		type = COMBAT_MANADRAIN,
		minDamage = -6,
		maxDamage = -13,
		range = 5,
		effect = CONST_ME_SMALLPLANTS,
		target = false,
	},
}

monster.defenses = {
	defense = 15,
	armor = 3,
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
