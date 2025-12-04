local mType = Game.createMonsterType("Owin")
local monster = {}

monster.description = "a owin"
monster.experience = 7000
monster.outfit = {
	lookType = 721,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1156,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 8200
monster.maxHealth = 8200
monster.race = "blood"
monster.corpse = 22066
monster.speed = 170
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 275,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "GRUNT", yell = true },
}

monster.loot = {
	{ id = 676, chance = 5000, maxCount = 12 }, -- small enchanted ruby
	{ id = 3725, chance = 50000 }, -- brown mushroom
	{ id = 7643, chance = 42210 }, -- ultimate health potion
	{ id = 22053, chance = 12900 }, -- wereboar hooves
	{ id = 22087, chance = 1950 }, -- wereboar loincloth
	{ id = 22054, chance = 11780 }, -- wereboar tusks
	{ id = 7439, chance = 700 }, -- berserk potion
	{ id = 7432, chance = 360 }, -- furry club
	{ id = 3081, chance = 5830 }, -- stone skin amulet
	{ id = 7419, chance = 1420 }, -- dreaded cleaver
	{ id = 22085, chance = 1200 }, -- fur armor
	{ id = 22102, chance = 7700 }, -- wereboar trophy
	{ id = 22060, chance = 400 }, -- werewolf amulet
	{ id = 22083, chance = 15900 }, -- moonlight crystals
	{ id = 22516, chance = 10600 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 70, attack = 80, condition = { type = CONDITION_POISON, totalDamage = 140, interval = 4000 } },
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -485 },
	{ name = "speed", interval = 4000, chance = 20, radius = 7, effect = CONST_ME_POFF, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -65, maxDamage = -335, radius = 4, effect = CONST_ME_MAGIC_GREEN, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 32,
	mitigation = 0.78,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 50, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 20, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
