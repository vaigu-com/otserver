local mType = Game.createMonsterType("Deadly Beetle")
local monster = {}

monster.description = "a deadly beetle"
monster.experience = 2750
monster.outfit = {
	lookType = 348,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 1900
monster.maxHealth = 1900
monster.race = "undead"
monster.corpse = 10458
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
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
	{ text = "Crump!", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 90000, maxCount = 100 },
	{ name = "platinum coin", chance = 90000, minCount = 5, maxCount = 7 },
	{ id = 10455, chance = 95666 },
	{ id = 9640, chance = 83330 },
	{ id = 9692, chance = 4166 },
	{ id = 10457, chance = 90123 },
	{ id = 3033, chance = 24700 },
	{ id = 3072, chance = 70050 },
	{ id = 6299, chance = 73000 },
	{ id = 3027, chance = 59060, maxCount = 3 },
	{ id = 3026, chance = 50000 },
	{ id = 3432, chance = 22022 },
	{ id = 3081, chance = 18200 },
	{ id = 8082, chance = 7100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 40, attack = 46 },
	{ name = "poisonfield", interval = 2000, chance = 10, radius = 4, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -90, length = 7, spread = 0, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = 0, maxDamage = -165, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 4000, chance = 70, type = COMBAT_DEATHDAMAGE, minDamage = 0, maxDamage = -265, range = 7, radius = 4, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "lancer beetle curse", interval = 2000, chance = 15, range = 5, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 20,
	{ name = "invisible", interval = 2000, chance = 10, duration = 3000, effect = CONST_ME_GROUNDSHAKER },
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
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
