local mType = Game.createMonsterType("Ogre Brute")
local monster = {}

monster.description = "an ogre brute"
monster.experience = 800
monster.outfit = {
	lookType = 857,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1161
monster.Bestiary = {
	class = "Giant",
	race = BESTY_RACE_GIANT,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Krailos Steppe.",
}

monster.health = 1000
monster.maxHealth = 1000
monster.race = "blood"
monster.corpse = 22143
monster.speed = 102
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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
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
	{ id = 3577, chance = 6200 },
	{ id = 3030, chance = 2500, maxCount = 2 },
	{ id = 3026, chance = 2400 },
	{ id = 11447, chance = 6200 },
	{ id = 1781, chance = 4990, maxCount = 2 },
	{ id = 3598, chance = 6200, maxCount = 7 },
	{ id = 22188, chance = 18720 },
	{ id = 22189, chance = 14310 },
	{ id = 22193, chance = 1870, maxCount = 2 },
	{ id = 22194, chance = 1580, maxCount = 2 },
	{ id = 3050, chance = 1580 },
	{ id = 22191, chance = 4130 },
	{ id = 236, chance = 12430, maxCount = 3 },
	{ id = 7428, chance = 240 },
	{ id = 22171, chance = 830 },
	{ id = 3465, chance = 340 },
	{ id = 8906, chance = 190 },
	{ id = 22192, chance = 230 },
	{ name = "butcher's axe", chance = 50 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400, condition = { type = CONDITION_FIRE, totalDamage = 6, interval = 9000 } },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = 0, maxDamage = -100, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = -300, range = 7, effect = CONST_ME_MAGIC_RED, target = true, duration = 10000 },
	{ name = "drunk", interval = 2000, chance = 10, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_TELEPORT, target = false },
}

monster.defenses = {
	defense = 41,
	armor = 41,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 80, maxDamage = 95, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
