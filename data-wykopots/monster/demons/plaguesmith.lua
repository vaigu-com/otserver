local mType = Game.createMonsterType("Plaguesmith")
local monster = {}

monster.description = "a plaguesmith"
monster.experience = 4500
monster.outfit = {
	lookType = 247,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 314
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Pits of Inferno, Formorgar Mines, Edron Demon Forge (The Vats, The Foundry), \z
		Magician Quarter, Alchemist Quarter, Roshamuul Prison."
		}
		
monster.health = 8250
monster.maxHealth = 8250
monster.race = "venom"
monster.corpse = 6515
monster.speed = 160
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
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 500,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
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
	{text = "You are looking a bit feverish!", yell = false},
	{text = "You don't look that good!", yell = false},
	{text = "Hachoo!", yell = false},
	{text = "Cough Cough", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 99500, maxCount = 273},
	{id = 19148, chance = 60000},
	{id = 3120, chance = 50000},
	{id = 3282, chance = 29000},
	{id = 3265, chance = 20000},
	{id = 3409, chance = 20000},
	{id = 3110, chance = 20000},
	{id = 3305, chance = 20000},
	{name = "soul orb", chance = 11111},
	{name = "great health potion", chance = 10000},
	{name = "demonic essence", chance = 9033},
	{id = 7365, chance = 7692, maxCount = 4},
	{id = 8896, chance = 540},
	{name = "platinum coin", chance = 7142, maxCount = 2},
	{id = 3371, chance = 6850},
	{id = 3033, chance = 5000, maxCount = 3},
	{id = 3093, chance = 4761},
	{id = 3092, chance = 4347},
	{id = 3279, chance = 2127},
	{id = 3017, chance = 2000},
	{id = 5887, chance = 1234},
	{name = "steel boots", chance = 1223},
	{id = 5889, chance = 1030},
	{id = 5888, chance = 1010},
	{id = 3332, chance = 952},
	{id = 3010, chance = 391},
	{id = 2958, chance = 110}
}

monster.attacks = {
	{name ="melee", interval = 1500, chance = 100, skill = 125, attack = 80, condition = {type = CONDITION_POISON, totalDamage = 200, interval = 4000}},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -60, maxDamage = -114, radius = 4, effect = CONST_ME_POISONAREA, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -350, length = 5, spread = 3, effect = CONST_ME_YELLOW_RINGS, target = false},
	{name ="plaguesmith paralyze", interval = 2000, chance = 10, target = false}
}

monster.defenses = {
	defense = 30,
	armor = 30,
	{name ="combat", interval = 2000, chance = 8, type = COMBAT_HEALING, minDamage = 200, maxDamage = 280, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 14, speedChange = 610, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -10},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 30},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 20},
	{type = COMBAT_HOLYDAMAGE , percent = -10},
	{type = COMBAT_DEATHDAMAGE , percent = 10}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
