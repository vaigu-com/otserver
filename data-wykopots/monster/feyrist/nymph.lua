local mType = Game.createMonsterType("Nymph")
local monster = {}

monster.description = "a nymph"
monster.experience = 850
monster.outfit = {
	lookType = 989,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1485
monster.Bestiary = {
	class = "Fey",
	race = BESTY_RACE_FEY,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Feyrist.",
}

monster.health = 900
monster.maxHealth = 900
monster.race = "blood"
monster.corpse = 25807
monster.speed = 114
monster.manaCost = 450

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 20,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 4,
	color = 133,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Looking at a nymph, can blind you. Be careful, mortal being!", yell = false },
	{ text = "Come here, sweetheart! I won't hurt you! *giggle*", yell = false },
	{ text = "Are you one of these evil nightmare creatures? Leave this realm alone!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 65000, maxCount = 110 },
	{ id = 3659, chance = 540 },
	{ id = 3079, chance = 320 },
	{ id = 25698, chance = 810 },
	{ id = 25696, chance = 12000 },
	{ id = 25695, chance = 12000 },
	{ id = 25700, chance = 810 },
	{ id = 3010, chance = 1500 },
	{ id = 9013, chance = 550 },
	{ id = 25692, chance = 14890, maxCount = 2 },
	{ name = "great mana potion", chance = 3550 },
	{ id = 8045, chance = 680 },
	{ id = 9302, chance = 1070 },
	{ id = 678, chance = 2000, maxCount = 2 },
	{ id = 9057, chance = 2300, maxCount = 2 },
	{ id = 237, chance = 3550 },
	{ id = 25691, chance = 22000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -180 },
	{ name = "heavy magic missile rune", interval = 2000, chance = 15, minDamage = -85, maxDamage = -150, range = 7, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -100, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_HEARTS, target = true },
}

monster.defenses = {
	defense = 60,
	armor = 60,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 75, maxDamage = 105, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = 250, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 60 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 40 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
