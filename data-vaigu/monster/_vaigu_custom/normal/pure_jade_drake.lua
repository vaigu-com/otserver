local mType = Game.createMonsterType("Pure Jade Drake")
local monster = {}

monster.description = "a pure jade drake"
monster.experience = 18300
monster.outfit = {
	lookType = 947,
	lookHead = 63,
	lookBody = 25,
	lookLegs = 81,
	lookFeet = 83,
	lookAddons = 1,
	lookMount = 0,
}

monster.health = 19700
monster.maxHealth = 19700
monster.race = "energy"
monster.corpse = 25065
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
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
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {
	"FirstDragonDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "Crystal Coin", chance = 23440, minCount = 1, maxCount = 2 },
	{ name = "Great Spirit Potion", chance = 20760 },
	{ name = "Small Diamond", chance = 6020, minCount = 1, maxCount = 3 },
	{ name = "Rusted Armor", chance = 5580 },
	{ name = "Green Crystal Fragment", chance = 4290 },
	{ name = "Terra Boots", chance = 4290 },
	{ name = "Protection Amulet", chance = 2270 },
	{ name = "Violet Gem", chance = 1250 },
	{ name = "Gold Ring", chance = 600 },
	{ name = "Green Gem", chance = 420 },
	{ name = "Ring of the Sky", chance = 210 },
	{ name = "great spirit potion", chance = 31180, maxCount = 5 },
	{ name = "sacred tree amulet", chance = 3590 },
	{ name = "underworld rod", chance = 3030 },
	{ id = 281, chance = 2690 }, -- giant shimmering pearl
	{ name = "titan axe", chance = 2500 },
	{ name = "terra amulet", chance = 1900 },
	{ name = "mercenary sword", chance = 1900 },
	{ name = "war axe", chance = 1560 },
	{ name = "giant sword", chance = 1540 },
	{ name = "fur armor", chance = 990 },
	{ name = "wood cape", chance = 920 },
	{ name = "stone skin amulet", chance = 740 },
	{ name = "terra mantle", chance = 510 },
	{ name = "rubber cap", chance = 430 },
	{ name = "bag you desire", chance = 15 },
	{ id = 18327, chance = 5 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -850 },
	{ name = "melee", interval = 2000, chance = 4, minDamage = 0, maxDamage = -190, condition = { type = CONDITION_FIRE, totalDamage = 11500, interval = 1000 } },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -310, maxDamage = -395, range = 5, radius = 5, effect = CONST_ME_FIREAREA, target = true },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -600, radius = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 10000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -110, maxDamage = -695, length = 9, spread = 3, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -210, maxDamage = -595, radius = 7, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -150, maxDamage = -280, radius = 6, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 64,
	armor = 52,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 4500, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
