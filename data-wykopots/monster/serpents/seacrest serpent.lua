local mType = Game.createMonsterType("Seacrest Serpent")
local monster = {}

monster.description = "a seacrest serpent"
monster.experience = 2600
monster.outfit = {
	lookType = 675,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1096
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 2,
	Locations = "Seacrest Grounds.",
}

monster.health = 3000
monster.maxHealth = 3000
monster.race = "venom"
monster.corpse = 21893
monster.speed = 250
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 9,
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
	staticAttackChance = 90,
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
	{ text = "WARAAAHAAARRRR!", yell = false },
	{ text = "LOOK INTO THE LIGHT...", yell = false },
	{ text = "LEAVE THESE GROUNDS...", yell = false },
	{ text = "THE DARK TIDE WILL SWALLOW YOU...", yell = false },
}

monster.loot = {
	{ id = 3583, chance = 14890 },
	{ id = 21801, chance = 10940 },
	{ id = 762, chance = 7920, maxCount = 19 },
	{ id = 829, chance = 2010 },
	{ id = 21892, chance = 1010 },
	{ name = "platinum coin", chance = 100000, maxCount = 5 },
	{ id = 236, chance = 7950, maxCount = 2 },
	{ id = 237, chance = 7910, maxCount = 2 },
	{ id = 21747, chance = 7200 },
	{ id = 3026, chance = 1920, maxCount = 2 },
	{ id = 3027, chance = 1870, maxCount = 3 },
	{ id = 281, chance = 1530 },
	{ name = "soul orb", chance = 2880 },
	{ id = 3028, chance = 3800, maxCount = 3 },
	{ id = 21800, chance = 16220 },
	{ id = 815, chance = 990 },
	{ id = 823, chance = 2070 },
	{ id = 819, chance = 1990 },
	{ id = 16096, chance = 350 },
	{ id = 8093, chance = 710 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 100, attack = 55 },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -250, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -285, radius = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "seacrest serpent wave", interval = 2000, chance = 12, minDamage = -100, maxDamage = -300, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -300, length = 4, spread = 0, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.defenses = {
	defense = 51,
	armor = 51,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 140, maxDamage = 200, effect = CONST_ME_SOUND_BLUE, target = false },
	{ name = "melee", interval = 2000, chance = 10, minDamage = 0, maxDamage = 0 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
