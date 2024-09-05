local mType = Game.createMonsterType("Spidris")
local monster = {}

monster.description = "a spidris"
monster.experience = 2600
monster.outfit = {
	lookType = 457,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 787
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 2,
	Locations = "Hive, Hive Outpost.",
}

monster.health = 3700
monster.maxHealth = 3700
monster.race = "venom"
monster.corpse = 13870
monster.speed = 195
monster.manaCost = 0

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
	convinceable = false,
	pushable = false,
	rewardBoss = false,
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
	{ text = "Eeeeeeyyyyh!", yell = false },
	{ text = "Iiiiieeeeeeh!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "platinum coin", chance = 45000, maxCount = 4 },
	{ id = 14082, chance = 15060 },
	{ id = 14083, chance = 11800 },
	{ id = 3030, chance = 11900, maxCount = 5 },
	{ name = "great mana potion", chance = 11500, maxCount = 2 },
	{ id = 7643, chance = 6150, maxCount = 2 },
	{ id = 6299, chance = 2530 },
	{ id = 281, chance = 1500 },
	{ id = 7413, chance = 870 },
	{ id = 3036, chance = 840 },
	{ id = 14086, chance = 400 },
	{ id = 14089, chance = 710 },
	{ id = 14088, chance = 670 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 95, attack = 60, condition = { type = CONDITION_POISON, totalDamage = 220, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -310, range = 7, radius = 3, shootEffect = CONST_ANI_GREENSTAR, effect = CONST_ME_GREEN_RINGS, target = true },
}

monster.defenses = {
	defense = 52,
	armor = 52,
	{ name = "speed", interval = 2000, chance = 9, speedChange = 1722, effect = CONST_ME_BLOCKHIT, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -3 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
