local mType = Game.createMonsterType("Laga Dyga")
local monster = {}

monster.description = "a skeleton"
monster.experience = 35
monster.outfit = {
	lookType = 33,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 1000
monster.maxHealth = 1000
monster.race = "undead"
monster.corpse = 5972
monster.speed = 150
monster.manaCost = 300

monster.changeTarget = { interval = 4000, chance = 100 }

monster.strategiesTarget = { random = 100, nearest = 0 }

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {
	"LagaDygaDeath",
}

monster.light = { level = 0, color = 0 }

monster.voices = { interval = 5000, chance = 10 }

monster.loot = {}

monster.attacks = {
	{
		name = "melee",
		interval = 2000,
		chance = 100,
		minDamage = 0,
		maxDamage = -20,
	},
	{
		name = "combat",
		interval = 2000,
		chance = 100,
		type = COMBAT_LIFEDRAIN,
		minDamage = -7,
		maxDamage = -13,
		range = 1,
		target = false,
	},
	{
		name = "berserk",
		interval = 2000,
		chance = 10,
		minDamage = 0,
		maxDamage = -100,
		range = 1,
		target = false,
	},
}

monster.defenses = { defense = 10, armor = 10 }

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
