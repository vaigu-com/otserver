local mType = Game.createMonsterType("Water Elemental")
local monster = {}

monster.description = "a water elemental"
monster.experience = 650
monster.outfit = {
	lookType = 286,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 236
monster.Bestiary = {
	class = "Elemental",
	race = BESTY_RACE_ELEMENTAL,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Water Elemental Cave in Port Hope, Water Elemental Dungeon, Deeper Banuta, Malada, Ramoa, \z
		Talahu, Folda (7 spawn on the 3rd floor), Water Elemental Cave in Outlaw Camp (only during the Down the \z
		Drain Mini World Change), Krailos Steppe underwater cave."
		}
		
monster.health = 550
monster.maxHealth = 550
monster.race = "undead"
monster.corpse = 9582
monster.speed = 115
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
	illusionable = true,
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
}

monster.loot = {
	{name = "gold coin", chance = 99000, maxCount = 100},
	{name = "platinum coin", chance = 25300},
	{id = 3578, chance = 20000},
	{id = 3032, chance = 2380, maxCount = 2},
	{id = 3028, chance = 2510},
	{id = 236, chance = 10000},
	{id = 237, chance = 10280},
	{id = 3051, chance = 1000},
	{id = 3052, chance = 1160},
	{id = 7158, chance = 1020},
	{id = 7159, chance = 1050}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 45, attack = 60, condition = {type = CONDITION_POISON, totalDamage = 60, interval = 4000}},
	{name ="combat", interval = 2000, chance = 17, type = COMBAT_DROWNDAMAGE, minDamage = -125, maxDamage = -235, radius = 2, shootEffect = CONST_ANI_SNOWBALL, effect = CONST_ME_LOSEENERGY, target = true},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -85, maxDamage = -150, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_LOSEENERGY, target = true},
	-- poison
	{name ="condition", type = CONDITION_POISON, interval = 2000, chance = 12, minDamage = -200, maxDamage = -260, radius = 5, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false}
}

monster.defenses = {
	defense = 37,
	armor = 37,
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 30, maxDamage = 50, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 35},
	{type = COMBAT_ENERGYDAMAGE, percent = -25},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = 50},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
