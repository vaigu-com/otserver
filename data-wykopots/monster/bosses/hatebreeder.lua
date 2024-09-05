local mType = Game.createMonsterType("Hatebreeder")
local monster = {}

monster.description = "Hatebreeder"
monster.experience = 10000
monster.outfit = {
	lookType = 351,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 18000
monster.maxHealth = 18000
monster.race = "undead"
monster.corpse = 10445
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 3,
}

monster.strategiesTarget = {
	nearest = 60,
	health = 15,
	damage = 15,
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
	runHealth = 366,
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
	{ text = "YOU ARE NOT WELCOME HERE!", yell = true },
}

monster.loot = {
	{ name = "demonic essence", chance = 76920 },
	{ id = 10449, chance = 69230 },
	{ name = "gold coin", chance = 100000, maxCount = 262 },
	{ name = "platinum coin", chance = 30770, maxCount = 2 },
	{ id = 10450, chance = 100000 },
	{ id = 10451, chance = 66000 },
	{ id = 10385, chance = 30000 },
	{ id = 11674, chance = 15000 },
	{ id = 10438, chance = 76920 },
	{ id = 10384, chance = 15380 },
	{ id = 10323, chance = 25000 },
	{ id = 10386, chance = 58000 },
	{ id = 10387, chance = 41540 },
	{ id = 10392, chance = 30770 },
	{ id = 10390, chance = 16150 },
	{ id = 10388, chance = 23080 },
	{ id = 10406, chance = 23080 },
	{ id = 7642, chance = 38460, maxCount = 5 },
	{ id = 7643, chance = 53850, maxCount = 5 },
	{ name = "great health potion", chance = 7690, maxCount = 5 },
	{ name = "great mana potion", chance = 7690, maxCount = 5 },
	{ id = 11692, chance = 10000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 160, attack = 100 },
	{ name = "ghastly dragon wave", interval = 2000, chance = 10, minDamage = -220, maxDamage = -400, target = false },
	{ name = "ghastly dragon curse", interval = 2000, chance = 10, range = 7, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -1600, maxDamage = -2200, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "ghastly dragon paralyze", interval = 2000, chance = 9, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -315, range = 7, effect = CONST_ME_MAGIC_RED, target = true },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_DEATHDAMAGE, minDamage = -350, maxDamage = -505, radius = 4, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 35,
	armor = 45,
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_HEALING, minDamage = 2450, maxDamage = 2535, effect = CONST_ME_MAGIC_GREEN, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
