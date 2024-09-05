local mType = Game.createMonsterType("Guardian of Tales")
local monster = {}

monster.description = "a guardian of tales"
monster.experience = 9204
monster.outfit = {
	lookType = 1063,
	lookHead = 73,
	lookBody = 72,
	lookLegs = 0,
	lookFeet = 79,
	lookAddons = 3,
	lookMount = 0,
}

-- monster.raceId = 1659
-- monster.Bestiary = {
-- class = "Magical",
-- race = BESTY_RACE_MAGICAL,
-- toKill = 2500,
-- FirstUnlock = 100,
-- SecondUnlock = 1000,
-- CharmsPoints = 50,
-- Stars = 4,
-- Occurrence = 1,
-- Locations = "Secret Library."
-- }

monster.health = 15000
monster.maxHealth = 15000
monster.race = "undead"
monster.corpse = 28770
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
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
	{ text = "One upon a time... YOU DIED!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 65000, maxCount = 32 },
	{ name = "glowing rune", chance = 35750, maxCount = 8 },
	{ name = "small diamond", chance = 35750, maxCount = 5 },
	{ name = "book page", chance = 35750, maxCount = 4 },
	{ name = "burnt scroll", chance = 32500 },
	{ name = "wand of inferno", chance = 7800 },
	{ name = "soul orb", chance = 9100 },
	{ name = "piece of hellfire armor", chance = 6760 },
	{ name = "fire axe", chance = 5330 },
	{ name = "magma legs", chance = 975 },
	{ name = "magma coat", chance = 975 },
	{ name = "fire sword", chance = 975 },
	{ name = "spellbook of warding", chance = 975 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_FIREDAMAGE, minDamage = -750, maxDamage = -950, length = 8, spread = 0, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_FIREDAMAGE, minDamage = -700, maxDamage = -950, radius = 3, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "fireball rune", interval = 2000, chance = 22, minDamage = -700, maxDamage = -1000, range = 7, target = false },
}

monster.defenses = {
	defense = 77,
	armor = 77,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -12 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
