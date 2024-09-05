local mType = Game.createMonsterType("Barbaria")
local monster = {}

monster.description = "barbaria"
monster.experience = 3550
monster.outfit = {
	lookType = 264,
	lookHead = 78,
	lookBody = 116,
	lookLegs = 95,
	lookFeet = 121,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 5550
monster.maxHealth = 5550
monster.race = "blood"
monster.corpse = 18058
monster.speed = 140
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
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
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
		{ name = "War Wolf", chance = 40, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "To me, creatures of the wild!", yell = false },
	{ text = "My instincts tell me about your cowardice.", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 100000 },
	{ name = "platinum coin", chance = 74000, maxCount = 15 },
	{ id = 2920, chance = 61500 },
	{ id = 3291, chance = 15500 },
	{ id = 3354, chance = 20360 },
	{ id = 3377, chance = 4090 },
	{ id = 3367, chance = 5080 },
	{ id = 3207, chance = 3270 },
	{ id = 5913, chance = 950 },
	{ id = 266, chance = 70000 },
	{ id = 3052, chance = 90000 },
	{ id = 7461, chance = 70000 },
	{ id = 7379, chance = 90000 },
	{ id = 7457, chance = 15000 },
	{ id = 7464, chance = 40000 },
	{ id = 7463, chance = 40000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 60, attack = 20 },
	{ name = "combat", interval = 2000, chance = 34, type = COMBAT_PHYSICALDAMAGE, minDamage = -30, maxDamage = -280, range = 7, radius = 1, shootEffect = CONST_ANI_SNOWBALL, target = true },
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -35, maxDamage = -270, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_ENERGYHIT, target = false },
}

monster.defenses = {
	defense = 10,
	armor = 10,
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_HEALING, minDamage = 150, maxDamage = 180, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
