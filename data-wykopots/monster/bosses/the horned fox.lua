local mType = Game.createMonsterType("The Horned Fox")
local monster = {}

monster.description = "the Horned Fox"
monster.experience = 200
monster.outfit = {
	lookType = 202,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 265
monster.maxHealth = 265
monster.race = "blood"
monster.corpse = 5983
monster.speed = 105
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
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

monster.summon = {
	maxSummons = 6,
	summons = {
		{ name = "minotaur archer", chance = 13, interval = 1000, count = 3 },
		{ name = "minotaur guard", chance = 13, interval = 1000, count = 3 },
		{ name = "minotaur mage", chance = 13, interval = 1000, count = 3 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You will never get me!", yell = false },
	{ text = "I'll be back!", yell = false },
	{ text = "Catch me, if you can!", yell = false },
	{ text = "Help me, boys!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 30 },
	{ id = 3298, chance = 50000, maxCount = 2 },
	{ id = 3307, chance = 10000 },
	{ id = 3410, chance = 5000 },
	{ id = 3578, chance = 20000 },
	{ id = 3557, chance = 1818 },
	{ id = 3301, chance = 2857 },
	{ id = 3492, chance = 50000, maxCount = 10 },
	{ id = 5804, chance = 100000 },
	{ id = 3073, chance = 1333 },
	{ id = 3091, chance = 2000 },
	{ id = 3577, chance = 33333, maxCount = 2 },
	{ id = 3267, chance = 6666 },
	{ id = 3369, chance = 1000 },
	{ id = 3285, chance = 10000 },
	{ id = 3563, chance = 2500 },
	{ id = 3372, chance = 2857 },
	{ id = 3357, chance = 1818 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 54, attack = 38 },
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -50, maxDamage = -120, range = 7, shootEffect = CONST_ANI_BOLT, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 1000, chance = 17, minDamage = -50, maxDamage = -120, range = 7, shootEffect = CONST_ANI_BOLT, target = false },
}

monster.defenses = {
	defense = 16,
	armor = 17,
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_HEALING, minDamage = 25, maxDamage = 75, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "invisible", interval = 1000, chance = 10, duration = 2000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
