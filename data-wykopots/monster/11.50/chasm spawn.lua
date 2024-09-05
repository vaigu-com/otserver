local mType = Game.createMonsterType("Chasm Spawn")
local monster = {}

monster.description = "a chasm spawn"
monster.experience = 2700
monster.outfit = {
	lookType = 1037,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1546
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Warzone 4.",
}

monster.health = 4500
monster.maxHealth = 4500
monster.race = "venom"
monster.corpse = 27563
monster.speed = 115
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
	staticAttackChance = 85,
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
	{ text = "tzzzz tzzzz tzzzzz", yell = false },
	{ text = "sloap sloap sloap", yell = false },
}

monster.loot = {
	{ name = "chasm spawn tail", chance = 69010 },
	{ name = "chasm spawn head", chance = 29750 },
	{ name = "wood mushroom", chance = 27690, maxCount = 4 },
	{ name = "chasm spawn abdomen", chance = 27270 },
	{ name = "brown mushroom", chance = 21070, maxCount = 5 },
	{ name = "orange mushroom", chance = 12810, maxCount = 3 },
	{ name = "small enchanted amethyst", chance = 8260, maxCount = 3 },
	{ name = "small enchanted emerald", chance = 12810 },
	{ name = "blue crystal shard", chance = 6200 },
	{ name = "violet crystal shard", chance = 5370 },
	{ name = "green crystal shard", chance = 7850 },
	{ name = "suspicious device", chance = 330 },
	{ name = "mushroom backpack", chance = 210 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "combat", interval = 2000, chance = 23, type = COMBAT_PHYSICALDAMAGE, minDamage = -180, maxDamage = -300, range = 7, shootEffect = CONST_ANI_BURSTARROW, target = true },
	{ name = "stalagmite rune", interval = 2000, chance = 15, minDamage = -100, maxDamage = -170, range = 7, target = true },
	{ name = "terra wave", interval = 2000, chance = 12, minDamage = -120, maxDamage = -200, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -200, radius = 4, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -450, length = 6, spread = 0, effect = CONST_ME_STONES, target = false },
}

monster.defenses = {
	defense = 74,
	armor = 74,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
