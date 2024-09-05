local mType = Game.createMonsterType("Drillworm")
local monster = {}

monster.description = "drillworm"
monster.experience = 1100
monster.outfit = {
	lookType = 527,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 878
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Drillworm Caves, Lower Spike and in the Lost Dwarf version of the Forsaken Mine.",
}

monster.health = 1500
monster.maxHealth = 1500
monster.race = "venom"
monster.corpse = 17425
monster.speed = 110
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20,
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
	{ text = "Knarrrk!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 150 },
	{ id = 3492, chance = 4580, maxCount = 5 },
	{ id = 16142, chance = 4870, maxCount = 2 },
	{ id = 12600, chance = 12130 },
	{ id = 10305, chance = 15000 },
	{ id = 3456, chance = 5280 },
	{ id = 5880, chance = 1550 },
	{ id = 814, chance = 2490 },
	{ id = 3415, chance = 2240 },
	{ id = 7452, chance = 520 },
	{ id = 10422, chance = 700 },
	{ id = 16135, chance = 7280 },
	{ id = 16133, chance = 5400 },
	{ id = 16122, chance = 10080 },
	{ id = 16123, chance = 10060 },
	{ id = 16124, chance = 10010 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300, condition = { type = CONDITION_POISON, totalDamage = 100, interval = 4000 } },
	{ name = "speed", interval = 2000, chance = 12, speedChange = -600, length = 8, spread = 0, effect = CONST_ME_MAGIC_RED, target = false, duration = 15000 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -280, length = 8, spread = 0, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -150, range = 6, radius = 3, effect = CONST_ME_POISONAREA, target = true },
}

monster.defenses = {
	defense = 41,
	armor = 41,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 16 },
	{ type = COMBAT_HOLYDAMAGE, percent = 25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
