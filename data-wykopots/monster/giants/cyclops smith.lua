local mType = Game.createMonsterType("Cyclops Smith")
local monster = {}

monster.description = "a cyclops smith"
monster.experience = 255
monster.outfit = {
	lookType = 277,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 389
monster.Bestiary = {
	class = "Giant",
	race = BESTY_RACE_GIANT,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Cyclopolis second floor and below, Mistrock, Mount Sternum, \z
		Cyclops Camp second floor and in the Cyclops version of the Forsaken Mine."
		}
		
monster.health = 435
monster.maxHealth = 435
monster.race = "blood"
monster.corpse = 656
monster.speed = 102
monster.manaCost = 695

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
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Outis emoi g' onoma.", yell = false},
	{text = "Whack da humy!", yell = false},
	{text = "Ai humy phary ty kaynon", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 82920, maxCount = 70},
	{id = 3577, chance = 49950},
	{id = 3413, chance = 6190},
	{id = 3305, chance = 5200},
	{id = 3410, chance = 2000},
	{id = 3266, chance = 5450},
	{id = 3330, chance = 2000},
	{id = 3275, chance = 880},
	{id = 3384, chance = 200},
	{id = 7398, chance = 140},
	{id = 236, chance = 390},
	{id = 3093, chance = 90},
	{id = 7452, chance = 150},
	{id = 9657, chance = 10280}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 50, attack = 50},
	{name ="combat", interval = 2000, chance = 11, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -75, range = 7, shootEffect = CONST_ANI_WHIRLWINDCLUB, target = false},
	{name ="drunk", interval = 2000, chance = 8, shootEffect = CONST_ANI_WHIRLWINDCLUB, effect = CONST_ME_STUN, target = false, duration = 3000}
}

monster.defenses = {
	defense = 29,
	armor = 29
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = -10},
	{type = COMBAT_FIREDAMAGE, percent = 10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 20},
	{type = COMBAT_DEATHDAMAGE , percent = -5}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = false},
	{type = "bleed", condition = false}
}

mType:register(monster)
