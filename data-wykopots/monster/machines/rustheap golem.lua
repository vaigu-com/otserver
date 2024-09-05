local mType = Game.createMonsterType("Rustheap Golem")
local monster = {}

monster.description = "a rustheap golem"
monster.experience = 2300
monster.outfit = {
	lookType = 603,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1041
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Workshop Quarter, Glooth Factory, Underground Glooth Factory, \z
		Oramond Dungeon (depending on Magistrate votes), Jaccus Maxxens Dungeon."
		}
		
monster.health = 2800
monster.maxHealth = 2800
monster.race = "venom"
monster.corpse = 20984
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5
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
	{text = "*clatter*", yell = false},
	{text = "*krrk*", yell = false},
	{text = "*frzzp*", yell = false}
}

monster.loot = {
	{id = 953, chance = 2930},
	{id = 9016, chance = 5130},
	{id = 21196, chance = 17160},
	{name = "gold coin", chance = 100000, maxCount = 293},
	{id = 5880, chance = 1430},
	{id = 21755, chance = 3250},
	{name = "platinum coin", chance = 59530, maxCount = 3},
	{id = 3026, chance = 2040},
	{id = 3027, chance = 1940},
	{id = 236, chance = 7810, maxCount = 2},
	{id = 237, chance = 7470, maxCount = 2},
	{id = 3279, chance = 2520},
	{id = 7452, chance = 450},
	{id = 21171, chance = 930},
	{id = 21170, chance = 3380},
	{id = 8896, chance = 3520},
	{id = 8899, chance = 3470},
	{id = 5880, chance = 1430}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400},
	{name ="rustheap golem electrify", interval = 2000, chance = 11, range = 7, target = false},
	{name ="frazzlemaw paralyze", interval = 2000, chance = 9, target = false},
	{name ="rustheap golem wave", interval = 2000, chance = 9, minDamage = 0, maxDamage = -410, target = false}
}

monster.defenses = {
	defense = 46,
	armor = 46,
	{name ="speed", interval = 2000, chance = 11, speedChange = 428, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 6000},
	{name ="combat", interval = 2000, chance = 11, type = COMBAT_HEALING, minDamage = 50, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = -5},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 70},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 10}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
