local mType = Game.createMonsterType("Leviathan")
local monster = {}

monster.description = "a leviathan"
monster.experience = 5000
monster.outfit = {
	lookType = 275,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 6000
monster.maxHealth = 6000
monster.race = "blood"
monster.corpse = 949
monster.speed = 379
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 50,
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
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 600,
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
	{ text = "CHHHRRRR", yell = false },
	{ text = "HISSSS", yell = false },
}

monster.loot = {
	{ id = 9303, chance = 100000 },
	{ name = "platinum coin", chance = 80000, maxCount = 6 },
	{ id = 3029, chance = 52000, maxCount = 3 },
	{ id = 8896, chance = 80000 },
	{ id = 9613, chance = 100000 },
	{ id = 8899, chance = 80000 },
	{ id = 7428, chance = 54000 },
	{ id = 9604, chance = 17700 },
	{ id = 8059, chance = 930 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 75, attack = 70 },
	{ name = "combat", interval = 1000, chance = 8, type = COMBAT_EARTHDAMAGE, minDamage = -130, maxDamage = -460, length = 9, spread = 3, effect = CONST_ME_BIGPLANTS, target = false },
	{ name = "combat", interval = 1000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -365, maxDamage = -491, length = 9, spread = 3, effect = CONST_ME_ICEAREA, target = false },
	{ name = "combat", interval = 1000, chance = 11, type = COMBAT_DROWNDAMAGE, minDamage = -15, maxDamage = -20, radius = 4, effect = CONST_ME_LOSEENERGY, target = true },
}

monster.defenses = {
	defense = 30,
	armor = 20,
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_HEALING, minDamage = 50, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
