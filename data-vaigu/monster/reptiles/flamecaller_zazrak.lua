local mType = Game.createMonsterType("Flamecaller Zazrak")
local monster = {}

monster.description = "a flamecaller zazrak"
monster.experience = 3031
monster.outfit = {
	lookType = 339,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 637,
	bossRace = RARITY_NEMESIS,
}

monster.health = 2690
monster.maxHealth = 2690
monster.race = "blood"
monster.corpse = 10363
monster.speed = 128
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
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
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 50,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 3,
	summons = {
		{ name = "Dragon Hatchling", chance = 20, interval = 2000, count = 2 },
		{ name = "lizard legionnaire", chance = 20, interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I ssssmell warm blood!", yell = true },
}

monster.loot = {
	{ name = "small amethyst", chance = 54900, maxCount = 3 },
	{ name = "yellow gem", chance = 21000 },
	{ id = 3052, chance = 17770 }, -- life ring
	{ name = "terra rod", chance = 1001 },
	{ name = "wand of inferno", chance = 11480 },
	{ name = "lizard leather", chance = 33980 },
	{ name = "lizard scale", chance = 21130 },
	{ name = "strong mana potion", chance = 12110 },
	{ name = "great mana potion", chance = 7940 },
	{ name = "focus cape", chance = 1660 },
	{ name = "zaoan shoes", chance = 450 },
	{ name = "zaoan robe", chance = 3300 },
	{ name = "dragon priest's wandtip", chance = 29910 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -100 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -125, maxDamage = -500, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = true },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -320, maxDamage = -400, range = 7, radius = 1, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true },
}

monster.defenses = {
	defense = 15,
	armor = 22,
	mitigation = 0.78,
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_HEALING, minDamage = 200, maxDamage = 400, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 25, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 85 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
