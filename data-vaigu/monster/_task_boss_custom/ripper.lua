local mType = Game.createMonsterType("Ripper")
local monster = {}

monster.description = "a ripper"
monster.experience = 3500
monster.outfit = {
	lookType = 300,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 1900
monster.maxHealth = 1900
monster.race = "undead"
monster.corpse = 8127
monster.speed = 75
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5,
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
	{ text = "Death!", yell = false },
	{ text = "Come a little closer!", yell = false },
	{ text = "The end is near!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 82350, maxCount = 270 },
	{ id = 3115, chance = 49000 },
	{ id = 3492, chance = 25325, maxCount = 12 },
	{ id = 3042, chance = 8210 },
	{ id = 3351, chance = 46000 },
	{ id = 3432, chance = 24220 },
	{ id = 3269, chance = 37500 },
	{ id = 3089, chance = 39000 },
	{ id = 3112, chance = 2000 },
	{ id = 10283, chance = 1000 },
	{ id = 12546, chance = 430 },
	{ id = 3027, chance = 59600, maxCount = 3 },
	{ id = 3072, chance = 79050 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -120 },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = 0, maxDamage = -130, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -100, length = 7, spread = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -25, maxDamage = -80, radius = 4, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 25,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_HEALING, minDamage = 60, maxDamage = 100, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = 540, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 65 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 80 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
