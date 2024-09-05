local mType = Game.createMonsterType("The Imperor")
local monster = {}

monster.description = "the imperor"
monster.experience = 8000
monster.outfit = {
	lookType = 237,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 15000
monster.maxHealth = 15000
monster.race = "fire"
monster.corpse = 6363
monster.speed = 165
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 5,
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
	targetDistance = 4,
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
	maxSummons = 2,
	summons = {
		{ name = "diabolic imp", chance = 30, interval = 5500, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Muahaha!", yell = false },
	{ text = "He he he!", yell = false },
}

monster.loot = {
	{ id = 6499, chance = 100000 },
	{ id = 3031, chance = 100000, maxCount = 150 },
	{ id = 6534, chance = 100000 },
	{ id = 3451, chance = 53850 },
	{ id = 3320, chance = 11000 },
	{ id = 3035, chance = 46150, maxCount = 3 },
	{ id = 5944, chance = 100000 },
	{ id = 3382, chance = 30770 },
	{ id = 3364, chance = 7690 },
	{ id = 3019, chance = 15380 },
	{ id = 3442, chance = 7690 },
	{ id = 3415, chance = 15400 },
	{ id = 826, chance = 15380 },
	{ id = 3033, chance = 30770, maxCount = 4 },
	{ id = 3030, chance = 7690, maxCount = 4 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 110, attack = 110 },
	{ name = "combat", interval = 1000, chance = 13, type = COMBAT_FIREDAMAGE, minDamage = -50, maxDamage = -800, range = 1, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -50, maxDamage = -800, range = 7, radius = 6, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -90, maxDamage = -350, length = 4, spread = 2, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
}

monster.defenses = {
	defense = 15,
	armor = 15,
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_HEALING, minDamage = 175, maxDamage = 505, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 12, speedChange = 380, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000 },
	{ name = "invisible", interval = 3000, chance = 20, duration = 5000, effect = CONST_ME_MAGIC_RED },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
