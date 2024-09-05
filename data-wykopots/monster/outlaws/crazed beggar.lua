local mType = Game.createMonsterType("Crazed Beggar")
local monster = {}

monster.description = "a crazed beggar"
monster.experience = 35
monster.outfit = {
	lookType = 153,
	lookHead = 59,
	lookBody = 38,
	lookLegs = 38,
	lookFeet = 97,
	lookAddons = 3,
	lookMount = 0,
}

monster.raceId = 525
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 50,
	FirstUnlock = 10,
	SecondUnlock = 25,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Factory, Foreigner, and Trade Quarters in Yalahar.",
}

monster.health = 100
monster.maxHealth = 100
monster.race = "blood"
monster.corpse = 18070
monster.speed = 77
monster.manaCost = 300

monster.changeTarget = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = true,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 10,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Hehehe!", yell = false },
	{ text = "Raahhh!", yell = false },
	{ text = "You are one of THEM! Die!", yell = false },
	{ text = "Wanna buy roses??", yell = false },
	{ text = "They're coming!", yell = false },
	{ text = "Make it stop!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 99000, maxCount = 9 },
	{ id = 19148, chance = 55000 },
	{ id = 3601, chance = 22500 },
	{ id = 3577, chance = 9500 },
	{ id = 3470, chance = 9750 },
	{ id = 3459, chance = 6500 },
	{ id = 3473, chance = 5650 },
	{ id = 3658, chance = 4700 },
	{ id = 2389, chance = 420 },
	{ id = 5552, chance = 420 },
	{ id = 3738, chance = 420 },
	{ id = 8894, chance = 80 },
	{ id = 3097, chance = 120 },
	{ id = 2950, chance = 360 },
	{ id = 6091, chance = 300 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 15, attack = 20 },
}

monster.defenses = {
	defense = 4,
	armor = 4,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
