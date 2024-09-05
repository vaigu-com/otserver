local mType = Game.createMonsterType("Thul")
local monster = {}

monster.description = "a thul"
monster.experience = 2700
monster.outfit = {
	lookType = 46,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 2950
monster.maxHealth = 2950
monster.race = "blood"
monster.corpse = 6065
monster.speed = 260
monster.manaCost = 670

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

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Massive Water Elementals", chance = 10, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Gaaahhh!", yell = false },
}

monster.loot = {
	{ id = 3381, chance = 10940 },
	{ id = 3391, chance = 15630 },
	{ id = 5895, chance = 100000 },
	{ name = "great mana potion", chance = 46880 },
	{ id = 901, chance = 65630 },
	{ name = "platinum coin", chance = 87500, maxCount = 10 },
	{ id = 7383, chance = 35940 },
	{ id = 3033, chance = 39060, maxCount = 4 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 47, attack = 100, condition = { type = CONDITION_POISON, totalDamage = 120, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_LIFEDRAIN, minDamage = -85, maxDamage = -195, range = 7, radius = 3, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -120, maxDamage = -230, range = 7, radius = 4, effect = CONST_ME_ICEATTACK, target = false },
	{ name = "poisonfield", interval = 2000, chance = 11, range = 7, radius = 3, effect = CONST_ME_GREEN_RINGS, target = false },
	{ name = "thul paralyze", interval = 2000, chance = 10, range = 7, target = false },
	{ name = "quara constrictor electrify", interval = 2000, chance = 18, range = 1, target = false },
}

monster.defenses = {
	defense = 40,
	armor = 35,
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_HEALING, minDamage = 215, maxDamage = 320, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "speed", interval = 2000, chance = 9, speedChange = 856, effect = CONST_ME_BUBBLES, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
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
