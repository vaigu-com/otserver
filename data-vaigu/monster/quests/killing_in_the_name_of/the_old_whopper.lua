local mType = Game.createMonsterType("The Old Whopper")
local monster = {}

monster.description = "The Old Whopper"
monster.experience = 750
monster.outfit = {
	lookType = 277,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 785
monster.maxHealth = 785
monster.race = "blood"
monster.corpse = 656
monster.speed = 102
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Han oydar hot auden oydar", yell = false },
}

monster.loot = {
	{ id = 7398, chance = 10000 },
	{ id = 3093, chance = 900 },
	{ id = 3384, chance = 2200 },
	{ id = 9657, chance = 100000 },
	{ name = "gold coin", chance = 82910, maxCount = 106 },
	{ name = "platinum coin", chance = 99910, maxCount = 9 },
	{ id = 236, chance = 3900 },
	{ id = 3577, chance = 49950 },
	{ id = 3413, chance = 61900 },
	{ id = 3305, chance = 52100 },
	{ id = 3410, chance = 19900 },
	{ id = 3266, chance = 54500 },
	{ id = 3330, chance = 20600 },
	{ id = 3275, chance = 8900 },
	{ id = 7452, chance = 75000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 70, attack = 50 },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -100, range = 7, shootEffect = CONST_ANI_WHIRLWINDCLUB, target = false },
	{ name = "drunk", interval = 2000, chance = 12, range = 7, shootEffect = CONST_ANI_WHIRLWINDCLUB, effect = CONST_ME_STUN, target = true, duration = 3000 },
}

monster.defenses = {
	defense = 24,
	armor = 17,
	{ name = "speed", interval = 2000, chance = 9, speedChange = 315, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 25, maxDamage = 60, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
