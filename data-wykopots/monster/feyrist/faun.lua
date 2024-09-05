local mType = Game.createMonsterType("Faun")
local monster = {}

monster.description = "a faun"
monster.experience = 800
monster.outfit = {
	lookType = 980,
	lookHead = 81,
	lookBody = 115,
	lookLegs = 114,
	lookFeet = 81,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1434
monster.Bestiary = {
	class = "Fey",
	race = BESTY_RACE_FEY,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Feyrist (daytime).",
}

monster.health = 900
monster.maxHealth = 900
monster.race = "blood"
monster.corpse = 25815
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
	runHealth = 60,
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
	{ text = "Are you posing a threat to this realm? I suppose so.", yell = false },
	{ text = "In vino veritas! Hahaha!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 154 },
	{ name = "rainbow quartz", chance = 4990 },
	{ name = "wood cape", chance = 1950 },
	{ name = "mandrake", chance = 40 },
	{ name = "leaf legs", chance = 610 },
	{ name = "small stone", chance = 5100 },
	{ name = "small enchanted sapphire", chance = 2350 },
	{ name = "shimmering beetles", chance = 9770 },
	{ name = "cookie", chance = 6050, maxCount = 4 },
	{ name = "panpipes", chance = 5200 },
	{ name = "leaf star", chance = 7500 },
	{ name = "grapes", chance = 5220 },
	{ name = "strong health potion", chance = 12000, maxCount = 2 },
	{ name = "goat grass", chance = 8330 },
	{ name = "great health potion", chance = 3260 },
	{ name = "dandelion seeds", chance = 15600 },
	{ id = 25691, chance = 9240 },
	{ id = 5792, chance = 150 },
	{ name = "wooden spellbook", chance = 400 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "stalagmite rune", interval = 2000, chance = 15, minDamage = -0, maxDamage = -100, range = 7, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -100, range = 7, shootEffect = CONST_ANI_THROWINGSTAR, target = false },
	{ name = "drunk", interval = 3000, chance = 11, radius = 6, effect = CONST_ME_SOUND_PURPLE, target = false, duration = 25000 },
}

monster.defenses = {
	defense = 45,
	armor = 45,
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 75, maxDamage = 90, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = 250, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 70 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
