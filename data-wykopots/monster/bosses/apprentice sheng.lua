local mType = Game.createMonsterType("Apprentice Sheng")
local monster = {}

monster.description = "apprentice sheng"
monster.experience = 100
monster.outfit = {
	lookType = 23,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 95
monster.maxHealth = 95
monster.race = "blood"
monster.corpse = 5981
monster.speed = 85
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
	canPushCreatures = false,
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

monster.summons = {
	maxSummons = 2,
	summons = {
		{ name = "Hyena", chance = 100, interval = 10500, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I will protect the secrets of my master!", yell = false },
	{ text = "This isle will become ours alone!", yell = false },
	{ text = "Kaplar!", yell = false },
}

monster.loot = {
	{ id = 3492, chance = 50000, maxCount = 10 },
	{ name = "gold coin", chance = 100000, maxCount = 20 },
	{ id = 2920, chance = 10000 },
	{ id = 3355, chance = 8000 },
	{ id = 3559, chance = 8000 },
	{ id = 5878, chance = 100000 },
	{ id = 3292, chance = 10000 },
	{ id = 3250, chance = 20000, maxCount = 5 },
	{ id = 3998, chance = 10000 },
	{ id = 3198, chance = 2857 },
	{ id = 7425, chance = 1000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 15, attack = 10 },
	{ name = "combat", interval = 1000, chance = 14, type = COMBAT_ENERGYDAMAGE, minDamage = -15, maxDamage = -25, range = 7, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -15, maxDamage = -45, range = 7, radius = 1, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "energyfield", interval = 1000, chance = 8, range = 7, radius = 1, shootEffect = CONST_ANI_ENERGY, target = true },
	{ name = "combat", interval = 10500, chance = 100, type = COMBAT_PHYSICALDAMAGE, radius = 3, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 13,
	armor = 12,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
