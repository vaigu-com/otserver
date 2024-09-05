local mType = Game.createMonsterType("Renegade Knight")
local monster = {}

monster.description = "a renegade knight"
monster.experience = 1200
monster.outfit = {
	lookType = 268,
	lookHead = 97,
	lookBody = 132,
	lookLegs = 76,
	lookFeet = 98,
	lookAddons = 2,
	lookMount = 0,
}

monster.raceId = 1146
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Old Fortress (north of Edron), Old Masonry, Forbidden Temple (Carlin).",
}

monster.health = 1450
monster.maxHealth = 1450
monster.race = "blood"
monster.corpse = 22020
monster.speed = 135
monster.manaCost = 390

monster.changeTarget = {
	interval = 4000,
	chance = 20,
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
	canWalkOnEnergy = true,
	canWalkOnFire = false,
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
	{ text = "I'll teach you a lesson!", yell = false },
	{ text = "Your abilities are no match for mine!", yell = false },
	{ text = "Take this!", yell = false },
	{ text = "Let's see how good you are!", yell = false },
	{ text = "Feel my steel!", yell = false },
	{ text = "A challenge at last!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "platinum coin", chance = 25000, maxCount = 2 },
	{ name = "great health potion", chance = 7150 },
	{ id = 3577, chance = 10000, maxCount = 2 },
	{ id = 3030, chance = 3450 },
	{ id = 3381, chance = 580 },
	{ id = 3385, chance = 480 },
	{ id = 3419, chance = 200 },
	{ id = 3382, chance = 520 },
	{ id = 3280, chance = 510 },
	{ id = 3279, chance = 1000 },
	{ id = 3265, chance = 4720 },
	{ id = 11510, chance = 5910 },
	{ id = 11450, chance = 1560 },
	{ id = 2995, chance = 90 },
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -125, radius = 3, effect = CONST_ME_BLOCKHIT, target = false },
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -245 },
}

monster.defenses = {
	defense = 50,
	armor = 38,
	{ name = "combat", interval = 4000, chance = 20, type = COMBAT_HEALING, minDamage = 200, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 35 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
