local mType = Game.createMonsterType("Yielothax")
local monster = {}

monster.description = "Yielothax"
monster.experience = 1250
monster.outfit = {
	lookType = 408,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 717
monster.Bestiary = {
	class = "Extra Dimensional",
	race = BESTY_RACE_EXTRA_DIMENSIONAL,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "In another dimension, through a portal in the Raging Mage tower, southern Zao.",
}

monster.health = 1500
monster.maxHealth = 1500
monster.race = "venom"
monster.corpse = 12595
monster.speed = 150
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
	staticAttackChance = 75,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
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
	{ text = "IIEEH!! Iiih iih ih iiih!!!", yell = true },
	{ text = "Bsssssssm Bssssssm Bsssssssssssm!", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 99810, maxCount = 231 },
	{ id = 236, chance = 20000 },
	{ id = 237, chance = 2070 },
	{ id = 3725, chance = 10000, maxCount = 3 },
	{ id = 3028, chance = 5000, maxCount = 5 },
	{ id = 3048, chance = 4020 },
	{ id = 3034, chance = 990 },
	{ id = 816, chance = 730 },
	{ id = 9304, chance = 530 },
	{ id = 3326, chance = 520 },
	{ id = 7440, chance = 490 },
	{ id = 3073, chance = 470 },
	{ id = 822, chance = 490 },
	{ id = 12805, chance = 320 },
	{ id = 12742, chance = 310 },
	{ id = 12737, chance = 310 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200 },
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 4, minDamage = -40, maxDamage = -50, range = 5, shootEffect = CONST_ANI_POISON, target = true }, -- poison spit
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_LIFEDRAIN, minDamage = -60, maxDamage = -130, length = 4, spread = 0, effect = CONST_ME_ENERGYAREA, target = false }, -- life drain beam
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -250, radius = 3, effect = CONST_ME_HITBYPOISON, target = false }, -- poison berserk
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -75, maxDamage = -120, radius = 3, effect = CONST_ME_HITBYPOISON, target = true }, -- poison ball
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -150, length = 4, spread = 3, effect = CONST_ME_MAGIC_RED, target = false }, -- mana drain wave
}

monster.defenses = {
	defense = 32,
	armor = 32,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 100, maxDamage = 150, effect = CONST_ME_HITBYPOISON, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
