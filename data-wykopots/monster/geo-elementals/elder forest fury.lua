local mType = Game.createMonsterType("Elder Forest Fury")
local monster = {}

monster.description = "an elder forest fury"
monster.experience = 330
monster.outfit = {
	lookType = 569,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 670
monster.maxHealth = 670
monster.race = "blood"
monster.corpse = 19042
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
	targetDistance = 4,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "To arms, sisters!", yell = false },
	{ text = "Feel the wrath of mother forest!", yell = false },
	{ text = "By the power of Greenskull!", yell = false },
	{ text = "Yiiieeehhh!", yell = false },
	{ text = "I'll strike you infidels down!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 92250, maxCount = 58 },
	{ id = 3446, chance = 48270, maxCount = 15 },
	{ id = 3577, chance = 24930 },
	{ id = 7363, chance = 14900, maxCount = 5 },
	{ id = 18995, chance = 17000 },
	{ id = 18994, chance = 18000 },
	{ id = 3349, chance = 3850 },
	{ name = "raspberry", chance = 630 },
	{ name = "elvish bow", chance = 630 },
	{ name = "small emerald", chance = 3200 },
	{ name = "hunting spear", chance = 8200 },
	{ name = "terra rod", chance = 900 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 20, attack = 35 },
	{ name = "combat", interval = 1500, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -130, range = 7, radius = 4, shootEffect = CONST_ANI_HUNTINGSPEAR, effect = CONST_ME_MAGIC_GREEN, target = true },
	{ name = "forest fury skill reducer", interval = 2000, chance = 20, range = 5, target = false },
}

monster.defenses = {
	defense = 19,
	armor = 19,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
