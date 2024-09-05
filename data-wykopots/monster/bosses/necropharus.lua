local mType = Game.createMonsterType("Necropharus")
local monster = {}

monster.description = "necropharus"
monster.experience = 700
monster.outfit = {
	lookType = 209,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 750
monster.maxHealth = 750
monster.race = "blood"
monster.corpse = 18293
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
	maxSummons = 4,
	summons = {
		{ name = "ghoul", chance = 20, interval = 1000, count = 3 },
		{ name = "ghost", chance = 17, interval = 1000, count = 3 },
		{ name = "mummy", chance = 15, interval = 1000, count = 3 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You will rise as my servant!", yell = false },
	{ text = "Praise to my master Urgith!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 40 },
	{ id = 2902, chance = 10000 },
	{ id = 3405, chance = 150 },
	{ id = 3280, chance = 220 },
	{ id = 3740, chance = 20000, maxCount = 2 },
	{ id = 3492, chance = 50000, maxCount = 10 },
	{ id = 5809, chance = 100000 },
	{ id = 3070, chance = 500 },
	{ id = 3377, chance = 8500 },
	{ id = 3732, chance = 22500 },
	{ id = 3116, chance = 6000 },
	{ id = 3115, chance = 30000 },
	{ id = 3337, chance = 19900 },
	{ id = 3441, chance = 7500 },
	{ id = 3300, chance = 10000 },
	{ id = 3114, chance = 20000, maxCount = 3 },
	{ id = 3661, chance = 20000 },
	{ id = 3324, chance = 833 },
	{ id = 3574, chance = 909 },
	{ id = 3079, chance = 666 },
	{ id = 3311, chance = 5000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 35, attack = 45, condition = { type = CONDITION_POISON, totalDamage = 95, interval = 4000 } },
	{ name = "combat", interval = 1000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -80, maxDamage = -120, range = 1, target = false },
	{ name = "combat", interval = 1000, chance = 17, type = COMBAT_EARTHDAMAGE, minDamage = -50, maxDamage = -140, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false },
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_HEALING, minDamage = 60, maxDamage = 90, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
