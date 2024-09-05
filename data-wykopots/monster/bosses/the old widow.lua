local mType = Game.createMonsterType("The Old Widow")
local monster = {}

monster.description = "the Old Widow"
monster.experience = 4200
monster.outfit = {
	lookType = 208,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3200
monster.maxHealth = 3200
monster.race = "blood"
monster.corpse = 5977
monster.speed = 120
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

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "giant spider", chance = 13, interval = 1000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 99 },
	{ name = "platinum coin", chance = 100000, maxCount = 10 },
	{ id = 5879, chance = 89000 },
	{ id = 3351, chance = 74000 },
	{ name = "great health potion", chance = 67000, maxCount = 4 },
	{ id = 3370, chance = 36260 },
	{ id = 3049, chance = 33000 },
	{ id = 3051, chance = 33000 },
	{ id = 3053, chance = 33000 },
	{ id = 12320, chance = 22500 },
	{ id = 3371, chance = 24180 },
	{ id = 3055, chance = 16480 },
	{ id = 5886, chance = 11000 },
	{ id = 7416, chance = 2225 },
	{ id = 7419, chance = 3039 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 130, attack = 100, condition = { type = CONDITION_POISON, totalDamage = 450, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -350, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false },
	{ name = "mamma longlegs paralyze", interval = 2000, chance = 20, range = 7, target = false },
	{ name = "poisonfield", interval = 2000, chance = 9, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, target = true },
}

monster.defenses = {
	defense = 21,
	armor = 17,
	{ name = "combat", interval = 1000, chance = 17, type = COMBAT_HEALING, minDamage = 225, maxDamage = 275, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 1000, chance = 8, speedChange = 345, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
