local mType = Game.createMonsterType("Cliff Strider")
local monster = {}

monster.description = "a cliff strider"
monster.experience = 5700
monster.outfit = {
	lookType = 497,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 889
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

monster.health = 9400
monster.maxHealth = 9400
monster.race = "undead"
monster.corpse = 16075
monster.speed = 123
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 8,
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
	canPushCreatures = false,
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
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
	{ text = "Knorrrr", yell = false },
	{ text = "Grwahr", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "platinum coin", chance = 100000, maxCount = 10 },
	{ name = "great mana potion", chance = 30950, maxCount = 4 },
	{ id = 7643, chance = 25260, maxCount = 2 },
	{ name = "soul orb", chance = 17080 },
	{ id = 16135, chance = 18000, maxCount = 2 },
	{ id = 16134, chance = 15630 },
	{ id = 16133, chance = 15110 },
	{ id = 5880, chance = 14490 },
	{ id = 10310, chance = 11280 },
	{ id = 16141, chance = 9090, maxCount = 8 },
	{ id = 3027, chance = 9090 },
	{ id = 16124, chance = 7970, maxCount = 2 },
	{ id = 3026, chance = 9630, maxCount = 3 },
	{ id = 16125, chance = 8070 },
	{ id = 16119, chance = 6520 },
	{ id = 3039, chance = 6110 },
	{ id = 9028, chance = 2690 },
	{ id = 16096, chance = 2000 },
	{ id = 5904, chance = 1450 },
	{ id = 7437, chance = 1350 },
	{ id = 16118, chance = 1240 },
	{ id = 7452, chance = 1040 },
	{ id = 16163, chance = 600 },
	{ id = 3281, chance = 620 },
	{ id = 3391, chance = 410 },
	{ id = 9067, chance = 720 },
	{ id = 16160, chance = 560 },
	{ id = 3371, chance = 1000 },
	{ id = 3041, chance = 830 },
	{ id = 3381, chance = 500 },
	{ name = "steel boots", chance = 130 },
	{ id = 3332, chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 95, attack = 95 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -800, radius = 4, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_STONES, target = true },
	{ name = "cliff strider skill reducer", interval = 2000, chance = 10, target = false },
	{ name = "cliff strider electrify", interval = 2000, chance = 15, range = 1, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -1000, length = 6, spread = 0, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -300, radius = 4, effect = CONST_ME_YELLOWENERGY, target = false },
}

monster.defenses = {
	defense = 89,
	armor = 89,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 35 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
