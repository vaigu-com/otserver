local mType = Game.createMonsterType("Pirate Buccaneer")
local monster = {}

monster.description = "a pirate buccaneer"
monster.experience = 250
monster.outfit = {
	lookType = 97,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 249
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Nargor, Tyrsung (on the ship), Yalahar (Foreign Quarter), Krailos Steppe.",
}

monster.health = 425
monster.maxHealth = 425
monster.race = "blood"
monster.corpse = 18190
monster.speed = 109
monster.manaCost = 595

monster.changeTarget = {
	interval = 4000,
	chance = 15,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 50,
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
	{ text = "Give up!", yell = false },
	{ text = "Hiyaa", yell = false },
	{ text = "Plundeeeeer!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 67740, maxCount = 60 },
	{ id = 3298, chance = 9000, maxCount = 5 },
	{ id = 3273, chance = 10100 },
	{ id = 3123, chance = 9900 },
	{ id = 2920, chance = 10190 },
	{ id = 3413, chance = 3850 },
	{ id = 5090, chance = 1000 },
	{ id = 6095, chance = 1200 },
	{ id = 3357, chance = 1130 },
	{ id = 6126, chance = 510 },
	{ id = 6098, chance = 420 },
	{ id = 236, chance = 670 },
	{ id = 6097, chance = 450 },
	{ id = 5926, chance = 480 },
	{ id = 5792, chance = 80 },
	{ id = 10302, chance = 9780 },
	{ id = 5552, chance = 120 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 30, attack = 80 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -100, range = 4, shootEffect = CONST_ANI_THROWINGKNIFE, target = false },
}

monster.defenses = {
	defense = 16,
	armor = 16,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
