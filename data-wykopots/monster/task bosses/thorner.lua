local mType = Game.createMonsterType("Thorner")
local monster = {}

monster.description = "a thorner"
monster.experience = 1500
monster.outfit = {
	lookType = 198,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3000
monster.maxHealth = 3000
monster.race = "blood"
monster.corpse = 6073
monster.speed = 50
monster.manaCost = 0

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
	illusionable = false,
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
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, minCount = 5, maxCount = 8 },
	{ id = 5678, chance = 45000, maxCount = 6 },
	{ id = 9643, chance = 100000, minCount = 3, maxCount = 6 },
	{ id = 3026, chance = 16000 },
	{ id = 5899, chance = 100000, minCount = 4, maxCount = 6 },
	{ id = 3027, chance = 16000 },
	{ id = 6131, chance = 29000 },
	{ id = 3065, chance = 15000 },
	{ id = 830, chance = 75090 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 45, attack = 70, condition = { type = CONDITION_POISON, totalDamage = 90, interval = 4000 } },
	{ name = "serpent spawn paralyze", interval = 2000, chance = 17, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_EARTHDAMAGE, minDamage = -66, maxDamage = -170, length = 8, spread = 3, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 2000, chance = 27, type = COMBAT_PHYSICALDAMAGE, minDamage = -50, maxDamage = -150, range = 7, radius = 2, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POFF, target = true },
}

monster.defenses = {
	defense = 40,
	armor = 40,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 45 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
