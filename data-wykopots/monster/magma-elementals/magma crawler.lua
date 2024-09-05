local mType = Game.createMonsterType("Magma Crawler")
local monster = {}

monster.description = "a magma crawler"
monster.experience = 2700
monster.outfit = {
	lookType = 492,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 885
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Warzone 2.",
}

monster.health = 4800
monster.maxHealth = 4800
monster.race = "fire"
monster.corpse = 15991
monster.speed = 230
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 80,
	random = 20,
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
	targetDistance = 4,
	runHealth = 300,
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
	{ text = "Crrroak!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 199 },
	{ name = "platinum coin", chance = 100000, maxCount = 5 },
	{ id = 16131, chance = 12220 },
	{ id = 16130, chance = 11600 },
	{ id = 3028, chance = 8800, maxCount = 3 },
	{ id = 16123, chance = 8500, maxCount = 2 },
	{ id = 9636, chance = 7810 },
	{ name = "great health potion", chance = 7270 },
	{ id = 16127, chance = 7000 },
	{ name = "great mana potion", chance = 6500 },
	{ id = 15793, chance = 5950, maxCount = 10 },
	{ id = 8093, chance = 4400 },
	{ id = 5880, chance = 4380 },
	{ id = 16119, chance = 3930 },
	{ id = 817, chance = 3120 },
	{ id = 5914, chance = 3000 },
	{ id = 5909, chance = 2310 },
	{ id = 818, chance = 1820 },
	{ id = 12600, chance = 1650 },
	{ id = 3280, chance = 1630 },
	{ id = 3051, chance = 1620 },
	{ id = 3429, chance = 1530 },
	{ id = 3037, chance = 1160 },
	{ id = 5911, chance = 970 },
	{ id = 16115, chance = 670 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "magma crawler soulfire", interval = 2000, chance = 20, target = false },
	{ name = "soulfire rune", interval = 2000, chance = 10, range = 7, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -1200, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -290, maxDamage = -700, radius = 3, effect = CONST_ME_FIREATTACK, target = false },
}

monster.defenses = {
	defense = 84,
	armor = 84,
	{ name = "invisible", interval = 2000, chance = 10, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 25 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
