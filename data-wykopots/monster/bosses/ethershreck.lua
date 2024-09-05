local mType = Game.createMonsterType("Ethershreck")
local monster = {}

monster.description = "Ethershreck"
monster.experience = 7500
monster.outfit = {
	lookType = 351,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 12500
monster.maxHealth = 12500
monster.race = "undead"
monster.corpse = 10445
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
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
	staticAttackChance = 70,
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
	{ text = "EMBRACE MY GIFTS!", yell = true },
	{ text = "I WILL FEAST ON YOUR SOUL!", yell = true },
}

monster.loot = {
	{ id = 10449, chance = 100000 },
	{ name = "gold coin", chance = 100000, maxCount = 230 },
	{ name = "platinum coin", chance = 100000, maxCount = 15 },
	{ id = 10450, chance = 100000 },
	{ name = "demonic essence", chance = 97000 },
	{ id = 281, chance = 45000 },
	{ id = 282, chance = 45000 },
	{ id = 9057, chance = 97000, maxCount = 10 },
	{ id = 10406, chance = 76000 },
	{ id = 7643, chance = 60000 },
	{ id = 10310, chance = 45000 },
	{ id = 10451, chance = 37000 },
	{ name = "great health potion", chance = 34000, maxCount = 3 },
	{ id = 10386, chance = 30000 },
	{ name = "great mana potion", chance = 26000, maxCount = 3 },
	{ id = 7642, chance = 26000, maxCount = 3 },
	{ id = 10438, chance = 21000 },
	{ id = 10387, chance = 15000 },
	{ id = 10384, chance = 13000 },
	{ id = 10385, chance = 13000 },
	{ id = 10389, chance = 10000 },
	{ id = 10388, chance = 8700 },
	{ id = 12801, chance = 2170 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 124, attack = 90 },
	{ name = "ghastly dragon curse", interval = 2000, chance = 5, range = 5, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -920, maxDamage = -1280, range = 5, effect = CONST_ME_BATS, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -180, maxDamage = -330, range = 7, effect = CONST_ME_MAGIC_RED, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -220, maxDamage = -350, length = 8, spread = 3, effect = CONST_ME_LOSEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -210, maxDamage = -280, radius = 4, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -300, range = 7, effect = CONST_ME_SMALLCLOUDS, target = true, duration = 30000 },
}

monster.defenses = {
	defense = 35,
	armor = 35,
	{ name = "combat", interval = 4000, chance = 10, type = COMBAT_HEALING, minDamage = 215, maxDamage = 300, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = -15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
