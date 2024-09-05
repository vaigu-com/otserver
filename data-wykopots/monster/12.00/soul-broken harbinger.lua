local mType = Game.createMonsterType("Soul-Broken Harbinger")
local monster = {}

monster.description = "a Soul-Broken Harbinger"
monster.experience = 5800
monster.outfit = {
	lookType = 1137,
	lookHead = 124,
	lookBody = 31,
	lookLegs = 17,
	lookFeet = 81,
	lookAddons = 3,
	lookMount = 0,
}

monster.raceId = 1734
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Court of Winter.",
}

monster.health = 6300
monster.maxHealth = 6300
monster.race = "undead"
monster.corpse = 30134
monster.speed = 210
monster.manaCost = 0

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
	{ text = "Huuu huuuu huuuu!", yell = false },
	{ text = "I bring grave news!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 12 },
	{ id = 30058, chance = 14700, maxCount = 3 },
	{ name = "dream essence egg", chance = 13140 },
	{ name = "elvish talisman", chance = 10700 },
	{ name = "knight legs", chance = 2170 },
	{ name = "glacier kilt", chance = 4270 },
	{ name = "glacier shoes", chance = 2750 },
	{ name = "ice rapier", chance = 5440 },
	{ name = "spellbook of mind control", chance = 1030 },
	{ name = "crown shield", chance = 1440 },
	{ name = "wood cape", chance = 1550 },
	{ id = 23529, chance = 2270 },
	{ name = "tower shield", chance = 1890 },
	{ id = 23543, chance = 960 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ICEDAMAGE, minDamage = -170, maxDamage = -300, range = 6, radius = 3, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_ICEATTACK, target = true },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ICEDAMAGE, minDamage = -200, maxDamage = -290, radius = 3, effect = CONST_ME_ICETORNADO, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ICEDAMAGE, minDamage = -200, maxDamage = -300, range = 7, radius = 4, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_ICEDAMAGE, minDamage = -120, maxDamage = -180, length = 4, spread = 0, effect = CONST_ME_GIANTICE, target = false },
	{ name = "icicle rune", interval = 2000, chance = 18, minDamage = -140, maxDamage = -200, range = 7, target = false },
}

monster.defenses = {
	defense = 76,
	armor = 76,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_ICEDAMAGE, percent = 70 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 55 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
