local mType = Game.createMonsterType("Lizard Templar Raid")
local monster = {}

monster.name = "Lizard Templar"
monster.description = "a lizard templar"
monster.experience = 155
monster.outfit = {
	lookType = 113,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 113
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Chor, the lizard city south-east from Port Hope. They can also be found in Yalahar's \z
		Foreigner Quarter and in Zzaion."
		}
		
monster.health = 410
monster.maxHealth = 410
monster.race = "blood"
monster.corpse = 4239
monster.speed = 87
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 0
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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
	{text = "Hissss!", yell = false}
}

monster.loot = {
	{name = "silver raid token", chance = 800},
	{name = "gold coin", chance = 84000, maxCount = 60},
	{id = 3294, chance = 9500},
	{id = 3351, chance = 2000},
	{id = 3264, chance = 4000},
	{id = 3282, chance = 1990},
	{id = 3357, chance = 1000},
	{id = 5876, chance = 880},
	{id = 3345, chance = 500},
	{id = 3032, chance = 250},
	{id = 266, chance = 890},
	{id = 5881, chance = 990},
	{id = 3445, chance = 110}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 30, attack = 35}
}

monster.defenses = {
	defense = 26,
	armor = 26
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = false},
	{type = "bleed", condition = false}
}

mType:register(monster)
