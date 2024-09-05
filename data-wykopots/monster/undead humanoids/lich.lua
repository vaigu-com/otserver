local mType = Game.createMonsterType("Lich")
local monster = {}

monster.description = "a lich"
monster.experience = 900
monster.outfit = {
	lookType = 99,
	lookHead = 95,
	lookBody = 116,
	lookLegs = 119,
	lookFeet = 115,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 99
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Ankrahmun Library Tomb, Ancient Ruins Tomb, Oasis Tomb, Mountain Tomb, Drefia, Kharos, \z
		Pits of Inferno, Lich Hell in Ramoa, Cemetery Quarter in Yalahar, underground of Fenrock (on the way to Beregar). \z
		Can also be seen during an undead raid in Darashia or Carlin."
		}
		
monster.health = 880
monster.maxHealth = 880
monster.race = "undead"
monster.corpse = 6028
monster.speed = 105
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
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
	canWalkOnFire = false,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "Bonebeast", chance = 10, interval = 2000, count = 4 }
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Doomed be the living!", yell = false},
	{text = "Death awaits all!", yell = false},
	{text = "Thy living flesh offends me!", yell = false},
	{text = "Death and Decay!", yell = false},
	{text = "You will endure agony beyond thy death!", yell = false},
	{text = "Pain sweet pain!", yell = false},
	{text = "Come to me my children!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 100000, maxCount = 139},
	{name = "platinum coin", chance = 19720},
	{id = 3059, chance = 10000},
	{id = 237, chance = 7860},
	{id = 3027, chance = 4960, maxCount = 2},
	{id = 3026, chance = 5160},
	{id = 3432, chance = 2150},
	{id = 9057, chance = 2480, maxCount = 3},
	{id = 3032, chance = 2460, maxCount = 3},
	{id = 3098, chance = 1400},
	{id = 3373, chance = 800},
	{id = 3037, chance = 690},
	{id = 3324, chance = 330},
	{id = 3055, chance = 390},
	{id = 3435, chance = 360},
	{id = 3062, chance = 500},
	{id = 820, chance = 230},
	{id = 3567, chance = 300},
	{id = 12304, chance = 50}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -75},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -140, maxDamage = -190, length = 7, spread = 0, effect = CONST_ME_MAGIC_RED, target = false},
	-- poison
	{name ="condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -300, maxDamage = -400, length = 7, spread = 0, effect = CONST_ME_HITBYPOISON, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -245, range = 1, effect = CONST_ME_MAGIC_RED, target = true},
	{name ="speed", interval = 2000, chance = 15, speedChange = -300, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 30000},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -130, maxDamage = -195, radius = 3, effect = CONST_ME_MAGIC_RED, target = false}
}

monster.defenses = {
	defense = 60,
	armor = 50,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 80, maxDamage = 100, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 80},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = -10},
	{type = COMBAT_DEATHDAMAGE , percent = 100}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
