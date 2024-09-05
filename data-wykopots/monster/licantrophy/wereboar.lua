local mType = Game.createMonsterType("Wereboar")
local monster = {}

monster.description = "a wereboar"
monster.experience = 2000
monster.outfit = {
	lookType = 721,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1143
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
monster.corpse = 22066
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 15,
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
	runHealth = 175,
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
	{ text = "SNUFFLE", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 80000, maxCount = 75 },
	{ name = "platinum coin", chance = 100000, maxCount = 3 },
	{ id = 3725, chance = 7000 },
	{ id = 7643, chance = 1960 },
	{ id = 236, chance = 5260 },
	{ id = 22053, chance = 14300 },
	{ id = 22087, chance = 1640 },
	{ id = 22054, chance = 14800 },
	{ id = 7439, chance = 890 },
	{ id = 7432, chance = 700 },
	{ id = 3081, chance = 920 },
	{ id = 7419, chance = 110 },
	{ id = 22085, chance = 380 },
	{ id = 22102, chance = 160 },
	{ id = 22060, chance = 700 },
	{ id = 22083, chance = 370 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -315 },
	{ name = "melee", interval = 2000, chance = 5, minDamage = 0, maxDamage = -415 },
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 15, minDamage = -300, maxDamage = -500, length = 3, spread = 0, effect = CONST_ME_EXPLOSIONAREA, target = false },
	--{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -150, length = 3, spread = 0, effect = CONST_ME_EXPLOSIONHIT, target = false}, --explo beam blood
	{ name = "wereboar skill reducer", interval = 2000, chance = 7, range = 5, target = true }, --red star ball target mlvl&melee&dist 20-30%
}

monster.defenses = {
	defense = 32,
	armor = 32,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_SOUND_PURPLE, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
