local mType = Game.createMonsterType("Guzzlemaw")
local monster = {}

monster.description = "Guzzlemaw"
monster.experience = 6050
monster.outfit = {
	lookType = 584,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1013
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Guzzlemaw Valley, and a single spawn in a tower in Upper Roshamuul \z
		(south of the Depot and west of the entrance to Roshamuul Prison)."
		}
		
monster.health = 6400
monster.maxHealth = 6400
monster.race = "blood"
monster.corpse = 20151
monster.speed = 200
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
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
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
	{text = "Gmmmooooh! *chomp*", yell = false},
	{text = "MWAAAH! *gurgle*", yell = false},
	{text = "*chomp* Mmmoh! *chomp*", yell = false}
}

monster.loot = {
	{name = "platinum coin", chance = 80000, maxCount = 8},
	{id = 3104, chance = 1560},
	{id = 3110, chance = 1400},
	{id = 3111, chance = 2600},
	{id = 3114, chance = 2320},
	{id = 3115, chance = 2360},
	{id = 3116, chance = 2600},
	{id = 3265, chance = 1440},
	{id = 3578, chance = 7000, maxCount = 3},
	{name = "ham", chance = 8000},
	{id = 5880, chance = 2376},
	{id = 5895, chance = 5040},
	{id = 5925, chance = 5010},
	{id = 5951, chance = 2520},
	{id = 7404, chance = 736},
	{id = 7407, chance = 1568},
	{id = 7418, chance = 640},
	{name = "great mana potion", chance = 17930, maxCount = 3},
	{name = "great health potion", chance = 17980, maxCount = 2},
	{id = 10389, chance = 1208},
	{id = 16120, chance = 2400},
	{id = 16123, chance = 9664, maxCount = 2},
	{id = 16126, chance = 5640},
	{id = 20131, chance = 5600},
	{id = 20062, chance = 1010},
	{id = 20198, chance = 12000},
	{id = 20199, chance = 10400},
	{id = 3125, chance = 4088}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 95, attack = 95},
	-- bleed
	{name ="condition", type = CONDITION_BLEEDING, interval = 2000, chance = 10, minDamage = -500, maxDamage = -1000, radius = 3, effect = CONST_ME_MAGIC_RED, target = false},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -500, radius = 3, effect = CONST_ME_YELLOWENERGY, target = false},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_LIFEDRAIN, minDamage = -650, maxDamage = -800, length = 5, spread = 3, effect = CONST_ME_EXPLOSIONAREA, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -200, radius = 2, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_STONES, target = true},
	{name ="speed", interval = 2000, chance = 15, speedChange = -800, radius = 6, effect = CONST_ME_MAGIC_RED, target = false, duration = 15000}
}

monster.defenses = {
	defense = 74,
	armor = 74,
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 250, maxDamage = 425, effect = CONST_ME_HITBYPOISON, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = 15},
	{type = COMBAT_EARTHDAMAGE, percent = 15},
	{type = COMBAT_FIREDAMAGE, percent = 5},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 5},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 5}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
