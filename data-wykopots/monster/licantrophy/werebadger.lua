local mType = Game.createMonsterType("Werebadger")
local monster = {}

monster.description = "a werebadger"
monster.experience = 1600
monster.outfit = {
	lookType = 729,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1144
monster.Bestiary = {
	class = "Lycanthrope",
	race = BESTY_RACE_LYCANTHROPE,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Grimvale: -1 floor from ground level, also seen on surface during full moon (12th-14th of every month). \z
		Also in the were-beasts cave south-west of Edron and in the Last Sanctum."
		}
		
monster.health = 1700
monster.maxHealth = 1700
monster.race = "blood"
monster.corpse = 22067
monster.speed = 130
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
	runHealth = 275,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = false,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "SNUFFLE", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 80000, maxCount = 75},
	{name = "platinum coin", chance = 100000, maxCount = 3},
	{id = 8017, chance = 25000},
	{id = 3725, chance = 7200},
	{id = 268, chance = 5150},
	{id = 237, chance = 3580},
	{id = 3741, chance = 4700},
	{id = 22051, chance = 14500},
	{id = 22055, chance = 15260},
	{id = 22086, chance = 820},
	{id = 3055, chance = 550},
	{id = 3098, chance = 810},
	{id = 8082, chance = 450},
	{id = 8094, chance = 400},
	{id = 22083, chance = 370},
	{id = 22060, chance = 560},
	{id = 22101, chance = 170}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -180, condition = {type = CONDITION_POISON, totalDamage = 140, interval = 4000}},
	{name ="combat", interval = 2000, chance = 8, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -100, radius = 5, effect = CONST_ME_MAGIC_GREEN, target = false},
	{name ="combat", interval = 2000, chance = 8, type = COMBAT_DEATHDAMAGE, minDamage = -185, maxDamage = -240, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -60, maxDamage = -85, range = 4, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 4000, chance = 10, speedChange = -500, radius = 5, effect = CONST_ME_POFF, target = true, duration = 4000},
	{name ="werebadger curse", interval = 2000, chance = 15, target = false}
}

monster.defenses = {
	defense = 31,
	armor = 31,
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 50, maxDamage = 120, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="invisible", interval = 2000, chance = 15, duration = 3000, effect = CONST_ME_MAGIC_BLUE},
	{name ="werebadger summon", interval = 2000, chance = 12, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 5},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 50},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -5},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 40}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
