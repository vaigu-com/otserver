local mType = Game.createMonsterType("Vashresamun")
local monster = {}

monster.description = "Vashresamun"
monster.experience = 12950
monster.outfit = {
	lookType = 85,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 4000
monster.maxHealth = 4000
monster.race = "undead"
monster.corpse = 6025
monster.speed = 170
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.bosstiary = {
	bossRaceId = 85,
	bossRace = RARITY_BANE,
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
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
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "Banshee", chance = 20, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Come my maidens, we have visitors!", yell = false },
	{ text = "Are you enjoying my music?", yell = false },
	{ text = "If music is the food of death, drop dead.", yell = false },
	{ text = "Chakka Chakka!", yell = false },
	{ text = "Heheheheee!", yell = false },
}

monster.loot = {
	{ id = 2950, chance = 7000 }, -- lute
	{ id = 2953, chance = 15000 }, -- panpipes
	{ id = 3007, chance = 15000 }, -- crystal ring
	{ name = "ancient tiara", chance = 4300 },
	{ name = "white pearl", chance = 71000 },
	{ name = "gold coin", chance = 50000, maxCount = 65 },
	{ name = "blue note", chance = 90000 },
	{ name = "crystal mace", chance = 8500 },
	{ name = "blue robe", chance = 12500 },
	{ id = 10290, chance = 5280 }, -- Mini Mummy
	{ id = 8898, chance = 2500 }, -- rusted legs
	{ id = 8907, chance = 2500 }, -- rusted helmet
	{ name = "silver token", chance = 15140 },
}

monster.attacks = {
	{ name = "lleech waveT", interval = 2000, chance = 30, minDamage = -200, maxDamage = -300 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -400, radius = 5, effect = CONST_ME_SOUND_RED, target = false },
	{ name = "melee", interval = 2000, chance = 50, minDamage = 0, maxDamage = -1200, condition = { type = CONDITION_POISON, totalDamage = 120, interval = 2000 } },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -550, radius = 6, effect = CONST_ME_SOUND_PURPLE, target = false },
}

monster.defenses = {
	defense = 35,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 60, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 1000, chance = 12, speedChange = 350, range = 5, effect = CONST_ME_MAGIC_RED, target = false, duration = 10000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
