local mType = Game.createMonsterType("Reptilia")
local monster = {}

monster.description = "a reptilia"
monster.experience = 3515
monster.outfit = {
	lookType = 239,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 2395
monster.maxHealth = 2395
monster.race = "blood"
monster.corpse = 6301
monster.speed = 75
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	runHealth = 100,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
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
	{ text = "Shriiiek", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 290 },
	{ name = "platinum coin", chance = 84900, minCount = 2, maxCount = 3 },
	{ id = 3583, chance = 60500, maxCount = 3 },
	{ id = 3450, chance = 3400, maxCount = 2 },
	{ id = 3029, chance = 85000, maxCount = 3 },
	{ id = 3028, chance = 25001, maxCount = 2 },
	{ id = 236, chance = 2500 },
	{ id = 3071, chance = 55810 },
	{ id = 7408, chance = 75410 },
	{ id = 3010, chance = 5900 },
	{ id = 9644, chance = 95300 },
	{ id = 10386, chance = 7000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 60, condition = { type = CONDITION_POISON, totalDamage = 480, interval = 4000 } },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -440, maxDamage = -640, length = 8, spread = 3, effect = CONST_ME_POISONAREA, target = false },
	{ name = "drunk", interval = 2000, chance = 15, length = 6, spread = 0, effect = CONST_ME_SOUND_RED, target = false, duration = 3000 },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_EARTHDAMAGE, minDamage = -50, maxDamage = -150, range = 7, radius = 1, shootEffect = CONST_ANI_POISON, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_FIREDAMAGE, minDamage = -65, maxDamage = -150, range = 7, radius = 1, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 45, maxDamage = 65, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
