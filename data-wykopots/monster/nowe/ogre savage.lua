local mType = Game.createMonsterType("Ogre Savage")
local monster = {}

monster.description = "a ogre savage"
monster.experience = 950
monster.outfit = {
	lookType = 858,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1162
monster.Bestiary = {
	class = "Giant",
	race = BESTY_RACE_GIANT,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Krailos Steppe.",
}

monster.health = 1400
monster.maxHealth = 1400
monster.race = "blood"
monster.corpse = 22147
monster.speed = 110
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
	{ text = "Must! Chop! Food! Raahh!", yell = false },
	{ text = "You tasty!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 154 },
	{ id = 22193, chance = 3200, maxCount = 2 },
	{ id = 22194, chance = 1890, maxCount = 3 },
	{ id = 3598, chance = 2200, maxCount = 7 },
	{ id = 8016, chance = 3680, maxCount = 2 },
	{ id = 9057, chance = 2260, maxCount = 2 },
	{ id = 3030, chance = 2540, maxCount = 2 },
	{ id = 7439, chance = 190 },
	{ id = 3078, chance = 6600 },
	{ id = 22188, chance = 19600 },
	{ id = 22172, chance = 1410 },
	{ id = 22189, chance = 15550 },
	{ id = 22191, chance = 9050 },
	{ id = 236, chance = 14900, maxCount = 2 },
	{ id = 3279, chance = 1320 },
	{ id = 22192, chance = 380 },
	{ id = 7419, chance = 90 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300, condition = { type = CONDITION_FIRE, totalDamage = 6, interval = 9000 } },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = 0, maxDamage = -100, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -300, range = 7, effect = CONST_ME_MAGIC_RED, target = true, duration = 10000 },
	-- bleed
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 15, minDamage = -250, maxDamage = -500, radius = 3, target = true },
}

monster.defenses = {
	defense = 32,
	armor = 32,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 80, maxDamage = 95, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = 300, effect = CONST_ME_MAGIC_RED, target = false, duration = 3000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
