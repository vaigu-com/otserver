local mType = Game.createMonsterType("Ripper Spectre")
local monster = {}

monster.description = "a ripper spectre"
monster.experience = 3500
monster.outfit = {
	lookType = 1119,
	lookHead = 101,
	lookBody = 39,
	lookLegs = 61,
	lookFeet = 39,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1724
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Haunted Cellar, Buried Cathedral.",
}

monster.health = 3800
monster.maxHealth = 3800
monster.race = "undead"
monster.corpse = 30026
monster.speed = 190
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
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
	staticAttackChance = 85,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
}

monster.loot = {
	{ name = "platinum coin", chance = 75000, maxCount = 8 },
	{ name = "great spirit potion", chance = 23850, maxCount = 4 },
	{ name = "silver brooch", chance = 3997 },
	{ name = "terra rod", chance = 7290 },
	{ name = "two handed sword", chance = 12000 },
	{ name = "emerald bangle", chance = 4402 },
	{ name = "serpent sword", chance = 870 },
	{ name = "springsprout rod", chance = 2677 },
	{ name = "twin hooks", chance = 3465 },
	{ name = "coral brooch", chance = 1050 },
	{ id = 30083, chance = 1582 }, -- green ectoplasm
	{ name = "assassin dagger", chance = 870 },
	{ name = "spike sword", chance = 360 },
	{ name = "wyvern fang", chance = 165 },
	{ id = 29299, chance = 5000 }, -- golden idol of tukh
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -210, maxDamage = -300, radius = 4, effect = CONST_ME_GREEN_RINGS, target = false }, -- poison ball
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -300, radius = 4, effect = CONST_ME_EXPLOSIONAREA, target = false }, -- explo ball
	{ name = "ripperspectrewave", interval = 2000, chance = 18, minDamage = -120, maxDamage = -250, target = false }, -- t wave
}

monster.defenses = {
	defense = 69,
	armor = 69,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_EARTHDAMAGE, percent = 133 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 70 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
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
