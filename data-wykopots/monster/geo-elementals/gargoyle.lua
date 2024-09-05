local mType = Game.createMonsterType("Gargoyle")
local monster = {}

monster.description = "a gargoyle"
monster.experience = 150
monster.outfit = {
	lookType = 95,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 95
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Meriana Gargoyle Cave, Ankrahmun Tombs, Mal'ouquah, Goroma, Deeper Banuta, \z
		Formorgar Mines, Vengoth, Farmine Mines, Upper Spike and Medusa Tower."
		}
		
monster.health = 250
monster.maxHealth = 250
monster.race = "undead"
monster.corpse = 6027
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 30,
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
	{text = "Harrrr Harrrr!", yell = false},
	{text = "Stone sweet stone.", yell = false},
	{text = "Feel my claws, softskin.", yell = false},
	{text = "Chhhhhrrrrk!", yell = false},
	{text = "There is a stone in your shoe!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 88000, maxCount = 30},
	{id = 3413, chance = 1000},
	{id = 8010, chance = 9220, maxCount = 2},
	{id = 3591, chance = 1810, maxCount = 5},
	{id = 3282, chance = 2150},
	{id = 10426, chance = 630},
	{id = 1781, chance = 15800, maxCount = 10},
	{id = 3351, chance = 850},
	{id = 3383, chance = 300},
	{id = 3012, chance = 1480},
	{id = 3093, chance = 210},
	{id = 10310, chance = 210},
	{id = 10278, chance = 12070}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 55, attack = 20}
}

monster.defenses = {
	defense = 30,
	armor = 26,
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 5, maxDamage = 15, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 40},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 10}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = false},
	{type = "bleed", condition = false}
}

mType:register(monster)
