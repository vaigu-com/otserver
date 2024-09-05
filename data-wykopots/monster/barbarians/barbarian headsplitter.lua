local mType = Game.createMonsterType("Barbarian Headsplitter")
local monster = {}

monster.description = "a barbarian headsplitter"
monster.experience = 85
monster.outfit = {
	lookType = 253,
	lookHead = 115,
	lookBody = 105,
	lookLegs = 119,
	lookFeet = 132,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 333
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Krimhorn, Bittermor, Ragnir, and Fenrock.",
}

monster.health = 100
monster.maxHealth = 100
monster.race = "blood"
monster.corpse = 18062
monster.speed = 84
monster.manaCost = 450

monster.changeTarget = {
	interval = 60000,
	chance = 0,
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
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
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
	{ text = "I will regain my honor with your blood!", yell = false },
	{ text = "Surrender is not option!", yell = false },
	{ text = "Its you or me!", yell = false },
	{ text = "Die! Die! Die!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 74000, maxCount = 30 },
	{ id = 2920, chance = 61500 },
	{ id = 3291, chance = 15500 },
	{ id = 3354, chance = 20360 },
	{ id = 3377, chance = 4090 },
	{ id = 3367, chance = 5080 },
	{ id = 3207, chance = 3270 },
	{ id = 5913, chance = 950 },
	{ id = 266, chance = 560 },
	{ id = 3052, chance = 230 },
	{ id = 7461, chance = 110 },
	{ id = 7457, chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 40, attack = 20 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -60, range = 7, radius = 1, shootEffect = CONST_ANI_WHIRLWINDAXE, target = true },
}

monster.defenses = {
	defense = 7,
	armor = 7,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
