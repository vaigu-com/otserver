local mType = Game.createMonsterType("Pixie")
local monster = {}

monster.description = "a pixie"
monster.experience = 700
monster.outfit = {
	lookType = 982,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1438
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

monster.health = 770
monster.maxHealth = 770
monster.race = "blood"
monster.corpse = 25811
monster.speed = 120
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
	targetDistance = 4,
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
	color = 196,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Glamour, glitter, glistening things! Do you have any of those?", yell = false },
	{ text = "Sweet Dreams!", yell = false },
	{ text = "You might be a threat! I'm sorry but I can allow you to linger here.", yell = false },
	{ text = "Let's try a step or two!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 61000, maxCount = 90 },
	{ name = "rainbow quartz", chance = 3130 },
	{ name = "butterfly ring", chance = 760 },
	{ name = "wooden spellbook", chance = 220 },
	{ name = "dream blossom staff", chance = 710 },
	{ id = 3046, chance = 4460 },
	{ name = "green mushroom", chance = 1720 },
	{ name = "small enchanted sapphire", chance = 2070, maxCount = 2 },
	{ name = "colourful snail shell", chance = 9760 },
	{ name = "star herb", chance = 4660 },
	{ name = "leaf star", chance = 9000, maxCount = 5 },
	{ name = "red rose", chance = 3060 },
	{ name = "strong mana potion", chance = 740, maxCount = 2 },
	{ name = "wild flowers", chance = 17700 },
	{ name = "great mana potion", chance = 3230 },
	{ name = "dandelion seeds", chance = 14400 },
	{ id = 25692, chance = 10170 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -100 },
	{ name = "heavy magic missile rune", interval = 2000, chance = 25, minDamage = -50, maxDamage = -100, range = 7, target = true },
	{ name = "speed", interval = 3000, chance = 14, speedChange = -700, length = 4, spread = 3, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 4000 },
	{ name = "pixie skill reducer", interval = 2000, chance = 19, target = false },
}

monster.defenses = {
	defense = 52,
	armor = 52,
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 45, maxDamage = 75, effect = CONST_ME_MAGIC_GREEN, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 60 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 60 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
