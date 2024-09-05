local mType = Game.createMonsterType("True Midnight Asura")
local monster = {}

monster.description = "a true midnight asura"
monster.experience = 7200
monster.outfit = {
	lookType = 1068,
	lookHead = 52,
	lookBody = 76,
	lookLegs = 52,
	lookFeet = 0,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1621
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Asura Palace.",
}

monster.health = 9000
monster.maxHealth = 9000
monster.race = "blood"
monster.corpse = 28618
monster.speed = 170
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
	targetDistance = 1,
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
	{ text = "Ah, the sweet music of a beating heart!", yell = false },
	{ text = "Death and Darkness", yell = false },
	{ text = "Embrace the night!", yell = false },
	{ text = "May night fall upon you!", yell = false },
}

monster.loot = {
	{ id = 3043, chance = 4440 },
	{ name = "platinum coin", chance = 80000, maxCount = 8 },
	{ name = "assassin star", chance = 8432, maxCount = 5 },
	{ id = 3027, chance = 7552 },
	{ name = "flask of demonic blood", chance = 16000 },
	{ name = "demonic essence", chance = 12592 },
	{ id = 3028, chance = 13208, maxCount = 3 },
	{ id = 3032, chance = 6576, maxCount = 3 },
	{ id = 3030, chance = 6920, maxCount = 3 },
	{ id = 3029, chance = 8304, maxCount = 3 },
	{ id = 9057, chance = 6976, maxCount = 3 },
	{ name = "small enchanted amethyst", chance = 11200, maxCount = 3 },
	{ name = "great health potion", chance = 9528, maxCount = 2 },
	{ id = 3026, chance = 6520, maxCount = 2 },
	{ id = 7404, chance = 1440 },
	{ id = 3041, chance = 1496 },
	{ id = 3567, chance = 400 },
	{ name = "gold ingot", chance = 1560 },
	{ id = 21974, chance = 17072 },
	{ id = 3007, chance = 752 },
	{ id = 3069, chance = 2080 },
	{ id = 21981, chance = 1672 },
	{ id = 21975, chance = 16264 },
	{ id = 8061, chance = 1152 },
	{ id = 3017, chance = 7496 },
	{ id = 3054, chance = 1560 },
	{ name = "soul orb", chance = 16552 },
	{ id = 8074, chance = 1040 },
	{ id = 3403, chance = 2424 },
	{ id = 8082, chance = 696 },
	{ id = 3037, chance = 920 },
	{ name = "royal star", chance = 3288, maxCount = 3 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -280, length = 4, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -240, length = 7, spread = 0, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -700, length = 7, spread = 0, effect = CONST_ME_POFF, target = false },
	{ name = "drunk", interval = 2000, chance = 12, range = 6, radius = 3, effect = CONST_ME_STUN, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -650, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 75,
	armor = 75,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
	{ name = "invisible", interval = 2000, chance = 20, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
