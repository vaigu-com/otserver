local mType = Game.createMonsterType("Minotaur Guard Raid")
local monster = {}

monster.name = "Minotaur Guard"
monster.description = "a minotaur guard"
monster.experience = 160
monster.outfit = {
	lookType = 29,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 29
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Ancient Temple, Mintwallin, Minotaur Pyramid, Maze of Lost Souls, Folda, Cyclopolis, \z
		Deeper Fibula Dungeon (level 50+ to open the door), Hero Cave, underground of Elvenbane, \z
		Plains of Havoc, Kazordoon Minotaur Cave, Foreigner Quarter."
		}
		
monster.health = 185
monster.maxHealth = 185
monster.race = "blood"
monster.corpse = 5983
monster.speed = 95
monster.manaCost = 550

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = true,
	attackable = true,
	hostile = true,
	convinceable = true,
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
	{text = "Kirll Karrrl!", yell = false},
	{text = "Kaplar!", yell = false}
}

monster.loot = {
	{name = "silver raid token", chance = 800},
	{name = "gold coin", chance = 59640, maxCount = 20},
	{id = 3483, chance = 480},
	{id = 3359, chance = 4390},
	{id = 3358, chance = 2980},
	{id = 3413, chance = 2150},
	{id = 5878, chance = 1000},
	{id = 3275, chance = 400},
	{id = 266, chance = 400},
	{id = 7401, chance = 80},
	{id = 11472, chance = 8330, maxCount = 2},
	{id = 11482, chance = 5040}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 30, attack = 50}
}

monster.defenses = {
	defense = 15,
	armor = 15
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 20},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = 10},
	{type = COMBAT_DEATHDAMAGE , percent = -10}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = false},
	{type = "bleed", condition = false}
}

mType:register(monster)
