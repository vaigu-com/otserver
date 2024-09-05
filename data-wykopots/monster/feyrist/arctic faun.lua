local mType = Game.createMonsterType("Arctic Faun")
local monster = {}

monster.description = "a arctic faun"
monster.experience = 300
monster.outfit = {
	lookType = 980,
	lookHead = 85,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1626
-- monster.Bestiary = {
-- class = "Fey",
-- race = BESTY_RACE_FEY,
-- toKill = 1000,
-- FirstUnlock = 50,
-- SecondUnlock = 500,
-- CharmsPoints = 25,
-- Stars = 3,
-- Occurrence = 1,
-- Locations = "Arctic Faun's Island."
-- }

monster.health = 300
monster.maxHealth = 300
monster.race = "blood"
monster.corpse = 28810
monster.speed = 105
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
	{ text = "Wine, women and song!", yell = false },
	{ text = "Dance with me!", yell = false },
	{ text = "In vino veritas! Hahaha!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 104 },
	{ name = "rainbow quartz", chance = 5360 },
	{ name = "wood cape", chance = 1170 },
	{ name = "leaf legs", chance = 370 },
	{ name = "small stone", chance = 5360, maxCount = 2 },
	{ name = "shimmering beetles", chance = 9460 },
	{ name = "cookie", chance = 5870, maxCount = 4 },
	{ name = "panpipes", chance = 5210 },
	{ name = "leaf star", chance = 7340, maxCount = 3 },
	{ name = "grapes", chance = 4400 },
	{ name = "strong health potion", chance = 13000, maxCount = 2 },
	{ name = "goat grass", chance = 7850 },
	{ name = "great health potion", chance = 2930 },
	{ name = "dandelion seeds", chance = 14750 },
	{ id = 25691, chance = 10560 },
	{ id = 5792, chance = 90 },
	{ name = "wooden spellbook", chance = 200 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -100 },
	{ name = "icicle rune", interval = 2000, chance = 26, minDamage = -20, maxDamage = -60, range = 7, target = true },
}

monster.defenses = {
	defense = 30,
	armor = 30,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 75, maxDamage = 90, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 70 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 80 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
