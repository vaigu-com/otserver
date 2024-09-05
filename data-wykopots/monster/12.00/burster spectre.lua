local mType = Game.createMonsterType("Burster Spectre")
local monster = {}

monster.description = "a Burster Spectre"
monster.experience = 6000
monster.outfit = {
	lookType = 1122,
	lookHead = 7,
	lookBody = 19,
	lookLegs = 86,
	lookFeet = 19,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1726
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Haunted Tomb west of Darashia, Buried Cathedral.",
}

monster.health = 6500
monster.maxHealth = 6500
monster.race = "undead"
monster.corpse = 30163
monster.speed = 200
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
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
	{ text = "We came tooo thiiiiss wooorld to... get youuu!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 7 },
	{ name = "great spirit potion", chance = 31300, maxCount = 3 },
	{ name = "protection amulet", chance = 10300 },
	{ name = "life crystal", chance = 9900 },
	{ name = "wand of voodoo", chance = 4550 },
	{ name = "wand of cosmic energy", chance = 3960 },
	{ name = "dragon necklace", chance = 2620 },
	{ name = "stone skin amulet", chance = 2940 },
	{ id = 30082, chance = 2000 }, -- blue ectoplasm
	{ name = "glacier amulet", chance = 2370 },
	{ name = "orb", chance = 1860 },
	{ name = "hailstorm rod", chance = 1160 },
	{ name = "hexagonal ruby", chance = 940 },
	{ name = "elven amulet", chance = 560 },
	{ name = "garlic necklace", chance = 490 },
	{ name = "platinum amulet", chance = 2050 },
	{ name = "mind stone", chance = 280 },
	{ name = "glacial rod", chance = 1160 },
	{ name = "shockwave amulet", chance = 390 },
	{ name = "strange symbol", chance = 260 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -400, radius = 5, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_ICEDAMAGE, minDamage = -250, maxDamage = -350, radius = 3, effect = CONST_ME_ICEAREA, target = true },
	{ name = "icicle rune", interval = 2000, chance = 16, minDamage = -250, maxDamage = -350, range = 6, target = true },
	{ name = "burster spectre wave", interval = 2000, chance = 12, minDamage = -200, maxDamage = -380, effect = CONST_ME_ICEATTACK, target = false },
}

monster.defenses = {
	defense = 70,
	armor = 70,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_ICEDAMAGE, percent = 133 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 70 },
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
