local mType = Game.createMonsterType("Dryad")
local monster = {}

monster.description = "a dryad"
monster.experience = 190
monster.outfit = {
	lookType = 137,
	lookHead = 80,
	lookBody = 101,
	lookLegs = 6,
	lookFeet = 100,
	lookAddons = 3,
	lookMount = 0
}

monster.raceId = 383
monster.Bestiary = {
	class = "Fey",
	race = BESTY_RACE_FEY,
	toKill = 5,
	FirstUnlock = 2,
	SecondUnlock = 3,
	CharmsPoints = 50,
	Stars = 3,
	Occurrence = 3,
	Locations = "Dryads appear in forest areas of Edron, Port Hope, Carlin and Cormaya during raids in June. \z
		There are 5 total waves, the initial one with the raid message and the rest every 15 minutes during next hour."
		}
		
monster.health = 310
monster.maxHealth = 310
monster.race = "blood"
monster.corpse = 18106
monster.speed = 115
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
	runHealth = 30,
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
	{text = "Feel the wrath of mother World!", yell = false},
	{text = "Defiler of nature!", yell = false}
}

monster.loot = {
	{name = "silver raid token", chance = 800},
	{id = 3723, chance = 55000, maxCount = 2},
	{name = "gold coin", chance = 40000, maxCount = 30},
	{id = 647, chance = 11000, maxCount = 3},
	{id = 9014, chance = 1280},
	{id = 9017, chance = 1200},
	{id = 9015, chance = 1100},
	{id = 9013, chance = 970},
	{id = 3726, chance = 780, maxCount = 2},
	{id = 12311, chance = 210},
	{id = 3033, chance = 300}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -90},
	{name ="combat", interval = 2500, chance = 9, type = COMBAT_EARTHDAMAGE, minDamage = -20, maxDamage = -30, radius = 4, effect = CONST_ME_BIGPLANTS, target = false},
	{name ="speed", interval = 1000, chance = 6, speedChange = -200, range = 7, radius = 7, effect = CONST_ME_POFF, target = false, duration = 20000},
	{name ="drunk", interval = 1000, chance = 12, range = 7, effect = CONST_ME_HEARTS, target = false, duration = 20000}
}

monster.defenses = {
	defense = 15,
	armor = 15,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 15, maxDamage = 60, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="invisible", interval = 2000, chance = 10, duration = 5000, effect = CONST_ME_MAGIC_BLUE}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 30},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -20},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 1},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
