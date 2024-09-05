local mType = Game.createMonsterType("Brutus")
local monster = {}

monster.description = "a brutus"
monster.experience = 4800
monster.outfit = {
	lookType = 857,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3500
monster.maxHealth = 3500
monster.race = "blood"
monster.corpse = 22143
monster.speed = 105
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
	{ text = "You so juicy!", yell = false },
	{ text = "You stop! You lunch!", yell = false },
	{ text = "Smash you face in!!!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 92000, maxCount = 130 },
	{ name = "platinum coin", chance = 92000, minCount = 8, maxCount = 13 },
	{ id = 3577, chance = 6200 },
	{ id = 3030, chance = 25000, maxCount = 4 },
	{ id = 3026, chance = 24000 },
	{ id = 11447, chance = 56200 },
	{ id = 1781, chance = 4990, maxCount = 2 },
	{ id = 22188, chance = 95720 },
	{ id = 22189, chance = 95310 },
	{ id = 22193, chance = 21870, maxCount = 2 },
	{ id = 22194, chance = 21580, maxCount = 2 },
	{ id = 3050, chance = 1580 },
	{ id = 22191, chance = 4130 },
	{ id = 236, chance = 72430, maxCount = 8 },
	{ id = 7428, chance = 2400 },
	{ id = 22171, chance = 25000 },
	{ id = 22172, chance = 25000 },
	{ id = 22183, chance = 25620 },
	{ id = 22192, chance = 190 },
	{ name = "butcher's axe", chance = 5000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -250, condition = { type = CONDITION_FIRE, totalDamage = 20, interval = 9000 } },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -70, maxDamage = -180, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	{ name = "drunk", interval = 2000, chance = 10, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_TELEPORT, target = false, duration = 2000 },
	{ name = "combat", interval = 4000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -180, maxDamage = -350, range = 7, radius = 4, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_GROUNDSHAKER, target = true },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_FIREDAMAGE, minDamage = -50, maxDamage = -250, range = 7, radius = 4, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_FIREAREA, target = true },
}

monster.defenses = {
	defense = 20,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 80, maxDamage = 95, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
