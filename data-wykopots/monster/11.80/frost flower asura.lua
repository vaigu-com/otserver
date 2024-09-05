local mType = Game.createMonsterType("Frost Flower Asura")
local monster = {}

monster.description = "a frost flower asura"
monster.experience = 4200
monster.outfit = {
	lookType = 150,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 86,
	lookAddons = 2,
	lookMount = 0,
}

-- monster.raceId = 1619
-- monster.Bestiary = {
-- class = "Demon",
-- race = BESTY_RACE_DEMON,
-- toKill = 1000,
-- FirstUnlock = 50,
-- SecondUnlock = 500,
-- CharmsPoints = 25,
-- Stars = 3,
-- Occurrence = 0,
-- Locations = "Asura Palace."
-- }

monster.health = 3500
monster.maxHealth = 3500
monster.race = "blood"
monster.corpse = 28806
monster.speed = 110
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	staticAttackChance = 80,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Welcome your frosty fate!", yell = false },
	{ text = "May you freeze forever!", yell = false },
	{ text = "Frost and fear!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 6 },
	{ name = "assassin star", chance = 9830, maxCount = 5 },
	{ id = 3027, chance = 5900 },
	{ name = "flask of demonic blood", chance = 18800 },
	{ name = "demonic essence", chance = 15600 },
	{ id = 3028, chance = 7900, maxCount = 3 },
	{ id = 3032, chance = 4660, maxCount = 3 },
	{ id = 3030, chance = 3880, maxCount = 2 },
	{ id = 3029, chance = 8000, maxCount = 3 },
	{ id = 9057, chance = 4340, maxCount = 2 },
	{ name = "great health potion", chance = 12930, maxCount = 2 },
	{ id = 3026, chance = 9230, maxCount = 2 },
	{ id = 3027, chance = 5900, maxCount = 2 },
	{ id = 7404, chance = 460 },
	{ id = 3041, chance = 320 },
	{ id = 3567, chance = 780 },
	{ name = "gold ingot", chance = 270 },
	{ id = 21974, chance = 16000 },
	{ id = 3007, chance = 500 },
	{ id = 8083, chance = 2560 },
	{ id = 21981, chance = 640 },
	{ id = 21975, chance = 15450 },
	{ id = 8061, chance = 180 },
	{ id = 3017, chance = 4620 },
	{ id = 3054, chance = 2060 },
	{ name = "soul orb", chance = 19470 },
	{ id = 8074, chance = 410 },
	{ id = 3403, chance = 361 },
	{ id = 3037, chance = 1460 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_MANADRAIN, minDamage = -70, maxDamage = -130, length = 7, spread = 0, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -150, maxDamage = -350, length = 7, spread = 0, effect = CONST_ME_ICEAREA, target = false },
	{ name = "icicle rune", interval = 2000, chance = 22, minDamage = -150, maxDamage = -250, range = 7, target = true },
	{ name = "ice overlord freeze", interval = 2000, chance = 12, range = 7, target = true },
}

monster.defenses = {
	defense = 56,
	armor = 56,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 80, maxDamage = 180, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
