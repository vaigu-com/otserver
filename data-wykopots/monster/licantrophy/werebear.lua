local mType = Game.createMonsterType("Werebear")
local monster = {}

monster.description = "a werebear"
monster.experience = 2000
monster.outfit = {
	lookType = 720,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1142
monster.Bestiary = {
	class = "Lycanthrope",
	race = BESTY_RACE_LYCANTHROPE,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Grimvale underground, were-beasts cave south-west of Edron and in the Last Sanctum east of Cormaya.",
}

monster.health = 2200
monster.maxHealth = 2200
monster.race = "blood"
monster.corpse = 22010
monster.speed = 110
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 12,
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
	runHealth = 205,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = false,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "GROOOWL", yell = false },
	{ text = "GRRR", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 80000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 3 },
	{ name = "great health potion", chance = 4800 },
	{ id = 7643, chance = 1950 },
	{ id = 5896, chance = 3000 },
	{ name = "ham", chance = 12000, maxCount = 2 },
	{ id = 5902, chance = 2530 },
	{ id = 22057, chance = 15000 },
	{ id = 7439, chance = 1110 },
	{ id = 22056, chance = 15300 },
	{ id = 3081, chance = 870 },
	{ id = 7419, chance = 140 },
	{ id = 22085, chance = 510 },
	{ id = 7432, chance = 860 },
	{ id = 22060, chance = 920 },
	{ id = 7383, chance = 550 },
	{ id = 7452, chance = 650 },
	{ id = 3053, chance = 670 },
	{ id = 22103, chance = 190 },
	{ id = 22083, chance = 350 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -270 },
	{ name = "melee", interval = 2000, chance = 10, minDamage = 0, maxDamage = -270 },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_PHYSICALDAMAGE, minDamage = -110, maxDamage = -260, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false }, -- explo box
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 8, minDamage = -300, maxDamage = -500, length = 3, spread = 1, effect = CONST_ME_MAGIC_RED, target = false }, --star con wave
}

monster.defenses = {
	defense = 38,
	armor = 38,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 45 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
