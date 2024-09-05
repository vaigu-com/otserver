local mType = Game.createMonsterType("Minion of Gaz'haragoth")
local monster = {}

monster.description = "Minion of Gaz'haragoth"
monster.experience = 570
monster.outfit = {
	lookType = 590,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 9400
monster.maxHealth = 9400
monster.race = "blood"
monster.corpse = 20215
monster.speed = 135
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
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
}

monster.loot = {
	{ name = "gold coin", chance = 30000, maxCount = 100 },
	{ name = "platinum coin", chance = 33333, maxCount = 10 },
	{ name = "great mana potion", chance = 3100, maxCount = 4 },
	{ id = 5880, chance = 2195, maxCount = 2 },
	{ id = 7643, chance = 2195, maxCount = 2 },
	{ id = 16141, chance = 366, maxCount = 8 },
	{ id = 3027, chance = 866 },
	{ id = 3026, chance = 866 },
	{ id = 16096, chance = 1766 },
	{ id = 16118, chance = 1066 },
	{ id = 3371, chance = 444 },
	{ id = 9067, chance = 1066 },
	{ id = 3281, chance = 422 },
	{ id = 10310, chance = 1032 },
	{ id = 5904, chance = 632 },
	{ id = 3381, chance = 632 },
	{ id = 16163, chance = 603 },
	{ id = 16160, chance = 603 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 10, attack = 30 },
	{ name = "combat", interval = 1800, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -30, maxDamage = -65, length = 7, spread = 0, effect = CONST_ME_STONES, target = false },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_EARTHDAMAGE, minDamage = -25, maxDamage = -59, radius = 6, effect = CONST_ME_BIGPLANTS, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 55,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
