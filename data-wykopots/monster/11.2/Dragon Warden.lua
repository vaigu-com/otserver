local mType = Game.createMonsterType("Dragon Warden")
local monster = {}

monster.description = "a Dragon Warden"
monster.experience = 1600
monster.outfit = {
	lookType = 947,
	lookHead = 5,
	lookBody = 5,
	lookLegs = 5,
	lookFeet = 5,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 2
monster.maxHealth = 2
monster.race = "blood"
monster.corpse = 25174
monster.speed = 75
monster.manaCost = 290

monster.changeTarget = {
	interval = 5000,
	chance = 0,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = true,
	rewardBoss = false,
	illusionable = true,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 15,
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
}

monster.loot = {
	{ name = "gold coin", chance = 50320, maxCount = 165 },
	{ name = "platinum coin", chance = 50320, maxCount = 2 },
	{ id = 3725, chance = 50320, maxCount = 2 },
	{ id = 3577, chance = 50320, maxCount = 2 },
	{ id = 2991, chance = 11000 },
	{ id = 6569, chance = 11000 },
	{ id = 6570, chance = 11000 },
	{ id = 6571, chance = 11000 },
	{ id = 6393, chance = 11000 },
	{ id = 6574, chance = 11000 },
	{ id = 24384, chance = 11000 },
	{ id = 24390, chance = 11000 },
	{ id = 24936, chance = 11000 },
	{ id = 24937, chance = 11000 },
	{ id = 6576, chance = 11000 },
	{ id = 6279, chance = 11000 },
	{ id = 24383, chance = 11 },
	{ id = 24385, chance = 11 },
	{ id = 5791, chance = 110 },
	{ id = 123, chance = 110 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 10, attack = 10 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -500, range = 7, target = false },
}

monster.defenses = {
	defense = 10,
	armor = 10,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -12 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 1 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
