local mType = Game.createMonsterType("Cublarc the Plunderer")
local monster = {}

monster.description = "an cublarc the plunderer"
monster.experience = 400
monster.outfit = {
	lookType = 342,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}
monster.bosstiary = {
	bossRaceId = 634,
	bossRace = RARITY_NEMESIS,
}

monster.health = 400
monster.maxHealth = 400
monster.race = "blood"
monster.corpse = 10334
monster.speed = 195
monster.manaCost = 490

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 4,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Grrrrrr", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 55000, maxCount = 90 },
	{ name = "obsidian lance", chance = 1110 },
	{ name = "orcish axe", chance = 1320 },
	{ name = "crossbow", chance = 440 },
	{ name = "bow", chance = 5210 },
	{ name = "meat", chance = 24600 },
	{ name = "silkweaver bow", chance = 2770 },
	{ name = "orc tooth", chance = 5890 },
	{ name = "shaggy tail", chance = 20090 },
	{ name = "broken crossbow", chance = 14830 },
	{ name = "orc leather", chance = 9800 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -140 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -140, range = 7, shootEffect = CONST_ANI_ONYXARROW, target = false },
}

monster.defenses = {
	defense = 35,
	armor = 26,
	mitigation = 1.23,
	{ name = "speed", interval = 2000, chance = 20, speedChange = 350, effect = CONST_ME_MAGIC_RED, target = false, duration = 8000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
