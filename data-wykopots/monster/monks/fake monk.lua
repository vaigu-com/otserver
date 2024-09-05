local mType = Game.createMonsterType("Fake Monk Static")
local monster = {}

monster.name = "Fake Monk"
monster.description = "a monk"
monster.experience = 200
monster.outfit = {
	lookType = 57,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 50000
monster.maxHealth = 50000
monster.race = "blood"
monster.corpse = 18090
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 20,
	damage = 10,
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
	staticAttackChance = 100,
	targetDistance = 1,
	runHealth = 0,
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
	{ text = "Repent Heretic!", yell = false },
	{ text = "A prayer to the almighty one!", yell = false },
	{ text = "I will punish the sinners!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 15000, maxCount = 18 },
	{ id = 3600, chance = 20000 },
	{ id = 2815, chance = 2000 },
	{ id = 2914, chance = 880 },
	{ id = 9646, chance = 4930 },
	{ id = 2885, chance = 820 },
	{ id = 11492, chance = 2950 },
	{ id = 11493, chance = 1001 },
	{ id = 3551, chance = 710 },
	{ id = 3289, chance = 440 },
	{ id = 3061, chance = 1002 },
	{ id = 3077, chance = 2240 },
	{ id = 3050, chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 10, attack = 8 },
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{ name = "combat", interval = 4000, chance = 60, type = COMBAT_HEALING, minDamage = 6000, maxDamage = 12000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "fake monk heal", interval = 1000, chance = 100, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
