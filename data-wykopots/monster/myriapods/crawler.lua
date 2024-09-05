local mType = Game.createMonsterType("Crawler")
local monster = {}

monster.description = "a crawler"
monster.experience = 1000
monster.outfit = {
	lookType = 456,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 786
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Hive, Hive Outpost.",
}

monster.health = 1450
monster.maxHealth = 1450
monster.race = "venom"
monster.corpse = 13865
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	damage = 30,
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
	runHealth = 40,
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
	{ text = "Chrssschrsss!", yell = false },
	{ text = "Sssschrchrsss!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 190 },
	{ name = "platinum coin", chance = 50000 },
	{ id = 14079, chance = 18640 },
	{ id = 14083, chance = 15240 },
	{ id = 9057, chance = 10360, maxCount = 2 },
	{ name = "great mana potion", chance = 9400 },
	{ name = "great health potion", chance = 6100 },
	{ id = 3279, chance = 2000 },
	{ id = 8084, chance = 670 },
	{ id = 3037, chance = 550 },
	{ id = 14087, chance = 110 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 45, attack = 60, condition = { type = CONDITION_POISON, totalDamage = 100, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_EARTHDAMAGE, minDamage = -90, maxDamage = -180, range = 5, shootEffect = CONST_ANI_POISON, effect = CONST_ME_SMALLPLANTS, target = true },
}

monster.defenses = {
	defense = 38,
	armor = 38,
	{ name = "speed", interval = 2000, chance = 25, speedChange = 924, effect = CONST_ME_BLOCKHIT, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -8 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -7 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
