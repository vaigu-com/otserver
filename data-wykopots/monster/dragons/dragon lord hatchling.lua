local mType = Game.createMonsterType("Dragon Lord Hatchling")
local monster = {}

monster.description = "a dragon lord hatchling"
monster.experience = 645
monster.outfit = {
	lookType = 272,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 386
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Thais Dragon Lair, Venore Dragon Lair, Edron Dragon Lair by the Fire Axe Quest, \z
		on the way to Pythius the Rotten, Razzachai, Dragonblaze Peaks."
		}
		
monster.health = 750
monster.maxHealth = 750
monster.race = "blood"
monster.corpse = 270
monster.speed = 84
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
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 30,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = false,
	pet = false
}

monster.light = {
	level = 3,
	color = 198
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Fchu?", yell = false},
	{text = "Rooawwrr", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 75000, maxCount = 170},
	{id = 3583, chance = 80000},
	{id = 268, chance = 530},
	{id = 3732, chance = 560},
	{id = 818, chance = 100}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 30, attack = 45},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_FIREDAMAGE, minDamage = -90, maxDamage = -125, length = 8, spread = 3, effect = CONST_ME_FIREAREA, target = false},
	{name ="combat", interval = 2000, chance = 17, type = COMBAT_FIREDAMAGE, minDamage = -55, maxDamage = -105, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
	{name ="combat", interval = 2000, chance = 11, type = COMBAT_FIREDAMAGE, minDamage = -40, maxDamage = -100, range = 7, shootEffect = CONST_ANI_FIRE, target = false},
	{name ="firefield", interval = 2000, chance = 10, range = 7, radius = 3, shootEffect = CONST_ANI_FIRE, target = true}
}

monster.defenses = {
	defense = 29,
	armor = 29,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 26, maxDamage = 48, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -10},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
