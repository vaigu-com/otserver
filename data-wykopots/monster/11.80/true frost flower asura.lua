local mType = Game.createMonsterType("True Frost Flower Asura")
local monster = {}

monster.description = "a true frost flower asura"
monster.experience = 6960
monster.outfit = {
	lookType = 1068,
	lookHead = 86,
	lookBody = 19,
	lookLegs = 86,
	lookFeet = 86,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1622
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Asura Palace's secret basement.",
}

monster.health = 4000
monster.maxHealth = 4000
monster.race = "blood"
monster.corpse = 28667
monster.speed = 150
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
	targetDistance = 5,
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
	{ id = 3043, chance = 3416 },
	{ name = "platinum coin", chance = 80000, maxCount = 8 },
	{ name = "assassin star", chance = 7864, maxCount = 5 },
	{ id = 3027, chance = 9232 },
	{ name = "flask of demonic blood", chance = 15040 },
	{ name = "demonic essence", chance = 14360 },
	{ id = 3028, chance = 11608, maxCount = 3 },
	{ id = 3032, chance = 14400, maxCount = 3 },
	{ id = 3030, chance = 6920, maxCount = 3 },
	{ id = 3029, chance = 7120, maxCount = 3 },
	{ id = 9057, chance = 5200, maxCount = 3 },
	{ name = "small enchanted sapphire", chance = 6840, maxCount = 3 },
	{ name = "great health potion", chance = 15128, maxCount = 2 },
	{ id = 3026, chance = 7880, maxCount = 2 },
	{ id = 7404, chance = 800 },
	{ id = 3041, chance = 2392 },
	{ id = 3567, chance = 480 },
	{ name = "gold ingot", chance = 2000 },
	{ id = 21974, chance = 16000 },
	{ id = 3007, chance = 800 },
	{ id = 8083, chance = 3200 },
	{ id = 21981, chance = 960 },
	{ id = 21975, chance = 16264 },
	{ id = 8061, chance = 1840 },
	{ id = 3017, chance = 7496 },
	{ id = 3054, chance = 1400 },
	{ name = "soul orb", chance = 16552 },
	{ id = 8074, chance = 1040 },
	{ id = 3403, chance = 4424 },
	{ id = 3067, chance = 680 },
	{ id = 3037, chance = 3760 },
	{ name = "royal star", chance = 4408, maxCount = 3 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -560 },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -280, length = 7, spread = 0, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_ICEDAMAGE, minDamage = -300, maxDamage = -600, length = 7, spread = 0, effect = CONST_ME_ICEAREA, target = false },
	{ name = "icicle rune", interval = 2000, chance = 22, minDamage = -500, maxDamage = -650, range = 7, target = true },
	{ name = "ice overlord freeze", interval = 2000, chance = 12, range = 7, target = true },
}

monster.defenses = {
	defense = 72,
	armor = 72,
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
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
