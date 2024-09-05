local mType = Game.createMonsterType("Lost Basher")
local monster = {}

monster.description = "a lost basher"
monster.experience = 1800
monster.outfit = {
	lookType = 538,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 925
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Caves of the Lost, Lower Spike and in the Lost Dwarf version of the Forsaken Mine.",
}

monster.health = 2600
monster.maxHealth = 2600
monster.race = "blood"
monster.corpse = 17683
monster.speed = 130
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
	{ text = "Yhouuuu!", yell = false },
	{ text = "Whaaarr!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 60000, maxCount = 100 },
	{ name = "platinum coin", chance = 70000 },
	{ id = 3725, chance = 15140, maxCount = 2 },
	{ id = 17856, chance = 7670 },
	{ id = 7643, chance = 98600 },
	{ name = "great mana potion", chance = 11830 },
	{ id = 9057, chance = 10120 },
	{ id = 17857, chance = 9740 },
	{ id = 17829, chance = 970 },
	{ id = 17830, chance = 7670 },
	{ id = 12600, chance = 19880 },
	{ id = 17827, chance = 17380 },
	{ id = 17854, chance = 11870 },
	{ id = 17847, chance = 12500 },
	{ id = 3099, chance = 2560 },
	{ id = 3429, chance = 3710 },
	{ id = 666, chance = 1200 },
	{ id = 5880, chance = 5280 },
	{ id = 3320, chance = 310 },
	{ id = 2995, chance = 4450 },
	{ id = 17826, chance = 14380 },
	{ id = 17828, chance = 1480 },
	{ id = 7452, chance = 310 },
	{ id = 813, chance = 620 },
	{ id = 7427, chance = 160 },
	{ id = 3371, chance = 310 },
	{ id = 3342, chance = 120 },
	{ id = 16119, chance = 1500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -300, radius = 3, shootEffect = CONST_ANI_WHIRLWINDAXE, effect = CONST_ME_EXPLOSIONAREA, target = true },
	{ name = "drunk", interval = 2000, chance = 15, radius = 4, shootEffect = CONST_ANI_WHIRLWINDCLUB, effect = CONST_ME_SOUND_RED, target = true, duration = 5000 },
}

monster.defenses = {
	defense = 57,
	armor = 57,
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_HEALING, minDamage = 250, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 350, radius = 2, effect = CONST_ME_ENERGYHIT, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
