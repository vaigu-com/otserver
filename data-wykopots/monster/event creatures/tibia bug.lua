local mType = Game.createMonsterType("Tibia Bug")
local monster = {}

monster.description = "Tibia Bug"
monster.experience = 50
monster.outfit = {
	lookType = 45,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 270
monster.maxHealth = 270
monster.race = "venom"
monster.corpse = 5990
monster.speed = 120
monster.manaCost = 250

monster.changeTarget = {
	interval = 2000,
	chance = 0,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
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

monster.summon = {
	maxSummons = 10,
	summons = {
		{ name = "tibia bug", chance = 15, interval = 1000, count = 10 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "My father was a year 2k bug.", yell = false },
	{ text = "Psst, I'll make you rich.", yell = false },
	{ text = "You are bugged ... by me!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 11 },
	{ id = 6570, chance = 5538 },
	{ id = 6571, chance = 1538 },
}

monster.attacks = {
	{ name = "melee", interval = 1000, chance = 100, skill = 43, attack = 20 },
	{ name = "combat", interval = 1000, chance = 13, type = COMBAT_ENERGYDAMAGE, minDamage = -5, maxDamage = -35, length = 4, spread = 0, effect = CONST_ME_ENERGYHIT, target = false },
}

monster.defenses = {
	defense = 15,
	armor = 10,
	{ name = "invisible", interval = 1000, chance = 17, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
