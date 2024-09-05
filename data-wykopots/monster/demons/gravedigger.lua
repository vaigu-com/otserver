local mType = Game.createMonsterType("Gravedigger")
local monster = {}

monster.description = "a gravedigger"
monster.experience = 950
monster.outfit = {
	lookType = 558,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 975
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 250,
	FirstUnlock = 10,
	SecondUnlock = 100,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Around the higher level areas of Drefia, \z
		including the Drefia Grim Reaper Dungeons and the Drefia Vampire Crypt."
		}
		
monster.health = 1500
monster.maxHealth = 1500
monster.race = "blood"
monster.corpse = 18962
monster.speed = 120
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
	runHealth = 200,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
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
	{text = "High Five!", yell = false},
	{text = "scrabble", yell = false},
	{text = "Put it there!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 100000, maxCount = 150},
	{name = "platinum coin", chance = 24470},
	{id = 10316, chance = 9570},
	{id = 3155, chance = 7300, maxCount = 9},
	{id = 11493, chance = 6000},
	{id = 3071, chance = 5590},
	{id = 11484, chance = 6650},
	{id = 236, chance = 2260, maxCount = 2},
	{id = 237, chance = 3600, maxCount = 2},
	{id = 3037, chance = 800},
	{id = 6299, chance = 800},
	{id = 3324, chance = 130},
	{id = 9692, chance = 100},
	{id = 5668, chance = 100},
	{id = 5925, chance = 50}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 118, attack = 50, condition = {type = CONDITION_POISON, totalDamage = 140, interval = 4000}},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -40, maxDamage = -250, range = 1, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -175, maxDamage = -300, range = 1, shootEffect = CONST_ANI_DEATH, target = false},
	{name ="drunk", interval = 2000, chance = 10, radius = 5, effect = CONST_ME_SMALLCLOUDS, target = false, duration = 4000}
}

monster.defenses = {
	defense = 58,
	armor = 58,
	{name ="invisible", interval = 2000, chance = 9, duration = 4000, effect = CONST_ME_MAGIC_RED},
	{name ="combat", interval = 2000, chance = 11, type = COMBAT_HEALING, minDamage = 150, maxDamage = 420, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 7, speedChange = 880, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 100},
	{type = COMBAT_EARTHDAMAGE, percent = -5},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 100}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
