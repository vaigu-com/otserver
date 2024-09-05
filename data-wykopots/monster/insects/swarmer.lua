local mType = Game.createMonsterType("Swarmer")
local monster = {}

monster.description = "a swarmer"
monster.experience = 350
monster.outfit = {
	lookType = 460,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 790
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "The Hive, Hive Outpost.",
}

monster.health = 460
monster.maxHealth = 460
monster.race = "venom"
monster.corpse = 13973
monster.speed = 128
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 2,
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 50,
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
	{ text = "Flzlzlzlzlzlzlz!", yell = false },
	{ text = "Rzlrzlrzlrzlrzlrzl!", yell = false },
}

monster.loot = {
	{ id = 14083, chance = 12210 },
	{ name = "gold coin", chance = 99990, maxCount = 75 },
	{ id = 14076, chance = 15300 },
	{ id = 3326, chance = 430 },
	{ id = 3032, chance = 960 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 30, attack = 40, condition = { type = CONDITION_POISON, totalDamage = 115, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_LIFEDRAIN, minDamage = -50, maxDamage = -110, range = 7, shootEffect = CONST_ANI_DEATH, target = true },
}

monster.defenses = {
	defense = 29,
	armor = 29,
	{ name = "speed", interval = 2000, chance = 11, speedChange = 744, effect = CONST_ME_POFF, target = false, duration = 7000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 75 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -8 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -3 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
