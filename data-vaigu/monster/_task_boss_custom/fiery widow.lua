local mType = Game.createMonsterType("Fiery Widow")
local monster = {}

monster.description = "a fiery widow"
monster.experience = 3450
monster.outfit = {
	lookType = 347,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 2850
monster.maxHealth = 2850
monster.race = "fire"
monster.corpse = 10393
monster.speed = 110
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 100,
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
}

monster.loot = {
	{ name = "platinum coin", chance = 76000, minCount = 2, maxCount = 7 },
	{ id = 3030, chance = 68000, maxCount = 4 },
	{ id = 3732, chance = 3208 },
	{ id = 10412, chance = 35000 },
	{ id = 10406, chance = 21010 },
	{ id = 9636, chance = 85070 },
	{ id = 3071, chance = 27450 },
	{ id = 3280, chance = 17140 },
	{ id = 817, chance = 32300 },
	{ id = 818, chance = 12600 },
	{ id = 3428, chance = 4600 },
	{ id = 12669, chance = 9500 },
	{ id = 10201, chance = 500 },
	{ id = 3564, chance = 2500 },
	{ id = 8898, chance = 12500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 60, condition = { type = CONDITION_FIRE, totalDamage = 30, interval = 3000 } },
	{ name = "firefield", interval = 2000, chance = 10, range = 7, radius = 3, shootEffect = CONST_ANI_FIRE, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -40, maxDamage = -170, radius = 3, effect = CONST_ME_MAGIC_RED, target = true },
	{ name = "combat", interval = 2000, chance = 24, type = COMBAT_FIREDAMAGE, minDamage = -60, maxDamage = -170, range = 7, shootEffect = CONST_ANI_FIRE, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -92, maxDamage = -350, length = 8, spread = 0, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "hellfire fighter soulfire", interval = 2000, chance = 15, target = false },
}

monster.defenses = {
	defense = 40,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 70, maxDamage = 100, effect = CONST_ME_SOUND_WHITE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 820, effect = CONST_ME_SOUND_YELLOW, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 80 },
	{ type = COMBAT_FIREDAMAGE, percent = 70 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -12 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 70 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
