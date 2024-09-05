local mType = Game.createMonsterType("Yakchal")
local monster = {}

monster.description = "an yakchal"
monster.experience = 4400
monster.outfit = {
	lookType = 149,
	lookHead = 0,
	lookBody = 47,
	lookLegs = 105,
	lookFeet = 105,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 5000
monster.maxHealth = 5000
monster.race = "blood"
monster.corpse = 18265
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	canPushCreatures = false,
	staticAttackChance = 50,
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
	maxSummons = 4,
	summons = {
		{ name = "Ice Golem", chance = 13, interval = 1000, count = 4 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "So you think you are cool?", yell = false },
	{ text = "I hope it is not too cold for you! HeHeHe.", yell = false },
	{ text = "Freeze!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 10000, maxCount = 88 },
	{ id = 5912, chance = 5000 },
	{ id = 7449, chance = 4000 },
	{ id = 7440, chance = 1500 },
	{ id = 7439, chance = 1500 },
	{ id = 7443, chance = 1500 },
	{ id = 7459, chance = 1000 },
	{ id = 3085, chance = 3250 },
	{ id = 823, chance = 2650 },
	{ id = 3079, chance = 2000 },
	{ id = 824, chance = 3000 },
	{ id = 7410, chance = 1500 },
	{ id = 3324, chance = 4500 },
	{ name = "gold ingot", chance = 5000 },
	{ id = 3333, chance = 4000 },
	{ id = 7290, chance = 1000000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -389 },
	{ name = "outfit", interval = 1000, chance = 10, range = 7, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 8000, outfitItem = 7172 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ICEDAMAGE, minDamage = 0, maxDamage = -430, radius = 4, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 3000, chance = 34, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -310, range = 7, radius = 3, shootEffect = CONST_ANI_SNOWBALL, target = true },
	{ name = "speed", interval = 1000, chance = 10, speedChange = -600, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
}

monster.defenses = {
	defense = 20,
	armor = 15,
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_HEALING, minDamage = 50, maxDamage = 100, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 50 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 26 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
