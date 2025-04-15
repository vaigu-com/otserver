local mType = Game.createMonsterType("Stoner")
local monster = {}

monster.description = "a stoner"
monster.experience = 3500
monster.outfit = {
	lookType = 95,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 2250
monster.maxHealth = 2250
monster.race = "undead"
monster.corpse = 6027
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 30,
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
	{ text = "Harrrr Harrrr!", yell = false },
	{ text = "Stone sweet stone.", yell = false },
	{ text = "Feel my claws, softskin.", yell = false },
	{ text = "Chhhhhrrrrk!", yell = false },
	{ text = "There is a stone in your shoe!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 88000, minCount = 2, maxCount = 5 },
	{ id = 3413, chance = 56000 },
	{ id = 10426, chance = 16300 },
	{ id = 1781, chance = 35800, maxCount = 30 },
	{ id = 16125, chance = 33000 },
	{ id = 16121, chance = 35000 },
	{ id = 3351, chance = 85000 },
	{ id = 9057, chance = 26500, maxCount = 2 },
	{ id = 10310, chance = 15190 },
	{ id = 10278, chance = 91730 },
	{ id = 5880, chance = 15000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 55, attack = 20 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = -20, maxDamage = -120, range = 7, radius = 2, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_POFF, target = true },
	{ name = "combat", interval = 4000, chance = 40, type = COMBAT_EARTHDAMAGE, minDamage = -72, maxDamage = -150, range = 7, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "combat", interval = 2000, chance = 39, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -60, range = 7, shootEffect = CONST_ANI_SMALLSTONE, effect = CONST_ME_POFF, target = true },
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 15, maxDamage = 55, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 40 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 1 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
