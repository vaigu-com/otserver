local mType = Game.createMonsterType("Arachnophobica")
local monster = {}

monster.description = "an arachnophobica"
monster.experience = 4700
monster.outfit = {
	lookType = 1135,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1729
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Buried Cathedral, Haunted Cellar, Court of Summer, Court of Winter, Dream Labyrinth.",
}

monster.health = 5000
monster.maxHealth = 5000
monster.race = "blood"
monster.corpse = 30073
monster.speed = 200
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
	pushable = true,
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
	{ text = "Tip tap tip tap!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 80000, maxCount = 14 },
	{ name = "great spirit potion", chance = 28800, maxCount = 3 },
	{ name = "essence of a bad dream", chance = 7040 },
	{ id = 3051, chance = 4040 }, -- energy ring
	{ name = "silver amulet", chance = 6320 },
	{ id = 3091, chance = 5320 },
	{ name = "spider fangs", chance = 9840 },
	{ name = "mind stone", chance = 4320 },
	{ name = "wand of cosmic energy", chance = 4240 },
	{ name = "magma amulet", chance = 1920 },
	{ name = "elven amulet", chance = 2560, maxCount = 2 },
	{ id = 23544, chance = 1352 },
	{ name = "sacred tree amulet", chance = 1840 },
	{ name = "spider silk", chance = 1200 },
	{ id = 3052, chance = 2528 }, -- life ring
	{ name = "orb", chance = 1760 },
	{ name = "underworld rod", chance = 2720 },
	{ id = 23529, chance = 1200 },
	{ id = 3098, chance = 1296 },
	{ name = "strange talisman", chance = 6168 },
	{ id = 3092, chance = 2496 },
	{ id = 3050, chance = 2704 },
	{ id = 6299, chance = 1841 },
	{ name = "garlic necklace", chance = 1080 },
	{ name = "platinum amulet", chance = 1400 },
	{ id = 23543, chance = 400 },
	{ name = "strange symbol", chance = 512 },
	{ name = "stone skin amulet", chance = 880 },
	{ name = "necklace of the deep", chance = 1120 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "arachnophobicawavedice", interval = 2000, chance = 14, minDamage = -200, maxDamage = -350, target = false },
	{ name = "arachnophobicawaveenergy", interval = 2000, chance = 14, minDamage = -210, maxDamage = -260, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -300, radius = 4, effect = CONST_ME_BLOCKHIT, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -300, range = 6, radius = 4, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_SMALLCLOUDS, target = true },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -300, radius = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "sudden death rune", interval = 2000, chance = 18, minDamage = -200, maxDamage = -300, range = 6, target = true },
}

monster.defenses = {
	defense = 70,
	armor = 70,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 50 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -40 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
