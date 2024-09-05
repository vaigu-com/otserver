local mType = Game.createMonsterType("Ironblight")
local monster = {}

monster.description = "ironblight"
monster.experience = 4400
monster.outfit = {
	lookType = 498,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 890
monster.Bestiary = {
	class = "Elemental",
	race = BESTY_RACE_ELEMENTAL,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Warzone 3.",
}

monster.health = 6600
monster.maxHealth = 6600
monster.race = "undead"
monster.corpse = 16079
monster.speed = 143
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 260,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
	{ text = "Clonk!", yell = false },
	{ text = "Yowl!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 199 },
	{ name = "platinum coin", chance = 100000, maxCount = 8 },
	{ id = 3033, chance = 15020, maxCount = 3 },
	{ id = 3032, chance = 10890, maxCount = 3 },
	{ name = "great mana potion", chance = 17640 },
	{ id = 9654, chance = 21230 },
	{ id = 7643, chance = 18330 },
	{ id = 10310, chance = 15230 },
	{ id = 3039, chance = 3510 },
	{ id = 3041, chance = 480 },
	{ id = 16126, chance = 10540 },
	{ id = 16127, chance = 10540 },
	{ id = 16121, chance = 5720 },
	{ id = 16123, chance = 12610, maxCount = 2 },
	{ id = 16138, chance = 18400 },
	{ id = 9028, chance = 4480 },
	{ id = 9067, chance = 2480 },
	{ id = 5904, chance = 830 },
	{ id = 3130, chance = 490 },
	{ id = 3326, chance = 480 },
	{ id = 7437, chance = 960 },
	{ id = 8027, chance = 330 },
	{ id = 16118, chance = 960 },
	{ id = 8084, chance = 1720 },
	{ id = 10451, chance = 410 },
	{ id = 812, chance = 590 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 100 },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -460, maxDamage = -480, radius = 6, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -260, maxDamage = -350, length = 7, spread = 0, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -180, maxDamage = -250, radius = 2, shootEffect = CONST_ANI_GREENSTAR, effect = CONST_ME_BIGPLANTS, target = true },
	{ name = "speed", interval = 2000, chance = 10, speedChange = -800, length = 5, spread = 3, effect = CONST_ME_BLOCKHIT, target = false, duration = 30000 },
}

monster.defenses = {
	defense = 84,
	armor = 84,
	{ name = "invisible", interval = 2000, chance = 20, duration = 7000, effect = CONST_ME_MAGIC_BLUE },
	{ name = "speed", interval = 2000, chance = 10, speedChange = 510, effect = CONST_ME_SMOKE, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 60 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
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
