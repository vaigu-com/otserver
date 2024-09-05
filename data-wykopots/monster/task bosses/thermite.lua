local mType = Game.createMonsterType("Thermite")
local monster = {}

monster.description = "a thermite"
monster.experience = 2500
monster.outfit = {
	lookType = 346,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 1865
monster.maxHealth = 1865
monster.race = "fire"
monster.corpse = 10430
monster.speed = 100
monster.manaCost = 505

monster.changeTarget = {
	interval = 5000,
	chance = 0,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Zrp zrp!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 97520, maxCount = 200 },
	{ name = "platinum coin", chance = 97520, minCount = 5, maxCount = 9 },
	{ id = 10454, chance = 74880, minCount = 2, maxCount = 3 },
	{ id = 10453, chance = 74680, minCount = 3, maxCount = 6 },
	{ id = 763, chance = 80000, minCount = 25, maxCount = 35 },
	{ id = 3030, chance = 88000, maxCount = 4 },
	{ id = 10452, chance = 99730 },
	{ name = "demonic essence", chance = 19500 },
	{ id = 9636, chance = 95475 },
	{ id = 818, chance = 14000 },
	{ id = 3071, chance = 28045 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 40, attack = 60, condition = { type = CONDITION_FIRE, totalDamage = 20, interval = 9000 } },
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_FIREDAMAGE, minDamage = -20, maxDamage = -120, range = 7, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "firefield", interval = 2000, chance = 25, range = 7, radius = 2, shootEffect = CONST_ANI_FIRE, target = true },
}

monster.defenses = {
	defense = 20,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 50, maxDamage = 280, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
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
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
