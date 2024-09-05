local mType = Game.createMonsterType("Flameborn")
local monster = {}

monster.description = "Flameborn"
monster.experience = 2550
monster.outfit = {
	lookType = 322,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3500
monster.maxHealth = 3500
monster.race = "fire"
monster.corpse = 9009
monster.speed = 130
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 15,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Your fragile bones are like toothpicks to me.", yell = false },
	{ text = "You little weasel will not live to see another day.", yell = false },
	{ text = "I'm just a messenger of what's yet to come.", yell = false },
	{ text = "HRAAAAAAAAAAAAAAAARRRR", yell = true },
	{ text = "I'm taking you down with me!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000 },
	{ name = "platinum coin", chance = 100000, maxCount = 13 },
	{ name = "great health potion", chance = 75810 },
	{ id = 10304, chance = 100000 },
	{ name = "assassin star", chance = 19350, maxCount = 5 },
	{ id = 7643, chance = 77420 },
	{ name = "demonic essence", chance = 35480 },
	{ id = 3724, chance = 67740, maxCount = 2 },
	{ id = 9057, chance = 43550, maxCount = 4 },
	{ id = 3371, chance = 67740 },
	{ id = 3369, chance = 20970 },
	{ id = 7452, chance = 6450 },
	{ id = 7439, chance = 37100 },
	{ id = 9056, chance = 20970 },
	{ id = 9034, chance = 1610 },
	{ id = 7421, chance = 3230 },
	{ id = 12311, chance = 4840 },
	{ id = 3419, chance = 29030 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "fireball rune", interval = 2000, chance = 20, minDamage = -150, maxDamage = -175, target = false },
	{ name = "hellspawn soulfire", interval = 2000, chance = 10, range = 5, target = false },
}

monster.defenses = {
	defense = 40,
	armor = 40,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 120, maxDamage = 230, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 270, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 80 },
	{ type = COMBAT_FIREDAMAGE, percent = 40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
