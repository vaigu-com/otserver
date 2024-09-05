local mType = Game.createMonsterType("Vexclaw")
local monster = {}

monster.description = "vexclaw"
monster.experience = 5680
monster.outfit = {
	lookType = 854,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1197
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "The Dungeons of The Ruthless Seven.",
}

monster.health = 8500
monster.maxHealth = 8500
monster.race = "blood"
monster.corpse = 22776
monster.speed = 135
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20,
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
	{ text = "Weakness must be culled!", yell = false },
	{ text = "Power is miiiiine!", yell = false },
	{ text = "You should consider bargaining for your life!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 87000, maxCount = 9 },
	{ name = "great mana potion", chance = 17503, maxCount = 5 },
	{ id = 7642, chance = 17503, maxCount = 5 },
	{ id = 3731, chance = 14196, maxCount = 6 },
	{ id = 22728, chance = 14091 },
	{ id = 7643, chance = 14000, maxCount = 5 },
	{ name = "demonic essence", chance = 13881 },
	{ id = 3033, chance = 7000, maxCount = 5 },
	{ id = 3030, chance = 7000, maxCount = 5 },
	{ id = 3032, chance = 6790, maxCount = 5 },
	{ id = 9057, chance = 7000, maxCount = 5 },
	{ id = 3039, chance = 3556 },
	{ id = 3037, chance = 3535 },
	{ id = 3284, chance = 3500 },
	{ id = 3320, chance = 2835 },
	{ id = 3048, chance = 1750 },
	{ id = 3051, chance = 1687 },
	{ id = 3281, chance = 1540 },
	{ id = 3098, chance = 980 },
	{ id = 3356, chance = 856 },
	{ id = 22727, chance = 560 },
	{ id = 3055, chance = 490 },
	{ id = 3420, chance = 576 },
	{ id = 22726, chance = 399 },
	{ id = 3414, chance = 357 },
	{ name = "golden legs", chance = 280 },
	{ id = 22867, chance = 280 },
	{ id = 22866, chance = 273 },
	{ id = 3366, chance = 91 },
	{ id = 7382, chance = 63 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_FIREDAMAGE, minDamage = -350, maxDamage = -450, range = 7, radius = 4, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_PHYSICALDAMAGE, minDamage = -150, maxDamage = -350, range = 7, radius = 5, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_GROUNDSHAKER, target = true },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -500, range = 7, radius = 5, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_LIFEDRAIN, minDamage = -650, maxDamage = -900, length = 8, spread = 0, effect = CONST_ME_ICEATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -250, length = 8, spread = 0, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 150, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 75 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
