local mType = Game.createMonsterType("Draken Abomination")
local monster = {}

monster.description = "a draken abomination"
monster.experience = 3800
monster.outfit = {
	lookType = 357,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 673
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Razachai including the Inner Sanctum.",
}

monster.health = 6250
monster.maxHealth = 6250
monster.race = "venom"
monster.corpse = 11667
monster.speed = 115
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
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
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

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Death Blob", chance = 10, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Ugggh!", yell = false },
	{ text = "Gll", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 97000, maxCount = 200 },
	{ name = "platinum coin", chance = 50590, maxCount = 8 },
	{ id = 3577, chance = 50450, maxCount = 4 },
	{ id = 7643, chance = 9400, maxCount = 3 },
	{ name = "great mana potion", chance = 9950, maxCount = 3 },
	{ id = 11671, chance = 12110 },
	{ id = 11672, chance = 6240 },
	{ id = 9057, chance = 2900, maxCount = 4 },
	{ id = 7642, chance = 4905, maxCount = 3 },
	{ id = 830, chance = 8730 },
	{ id = 11673, chance = 10940 },
	{ id = 8094, chance = 1020 },
	{ id = 4033, chance = 570 },
	{ id = 11688, chance = 10 },
	{ id = 11691, chance = 10 },
	{ id = 12549, chance = 320 },
	{ id = 10387, chance = 900 },
	{ id = 10384, chance = 830 },
	{ id = 10385, chance = 680 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 95, attack = 80 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -310, maxDamage = -480, length = 4, spread = 3, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name = "draken abomination curse", interval = 2000, chance = 10, range = 5, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -170, maxDamage = -370, length = 4, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "drunk", interval = 2000, chance = 10, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false, duration = 9000 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, range = 7, radius = 3, effect = CONST_ME_HITBYPOISON, target = false },
}

monster.defenses = {
	defense = 45,
	armor = 45,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 450, maxDamage = 370, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
