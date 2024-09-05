local mType = Game.createMonsterType("Cursed Book")
local monster = {}

monster.description = "a cursed book"
monster.experience = 13345
monster.outfit = {
	lookType = 1061,
	lookHead = 79,
	lookBody = 62,
	lookLegs = 93,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1655
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

monster.health = 20000
monster.maxHealth = 20000
monster.race = "undead"
monster.corpse = 28590
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
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
	{ text = "All indruders must be cursed!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 65000, maxCount = 10 },
	{ name = "small diamond", chance = 39000, maxCount = 8 },
	{ name = "small topaz", chance = 22750, maxCount = 5 },
	{ name = "silken bookmark", chance = 26000 },
	{ name = "book page", chance = 45500 },
	{ name = "small stone", chance = 18200, maxCount = 10 },
	{ name = "protection amulet", chance = 5850 },
	{ name = "diamond sceptre", chance = 5200 },
	{ name = "terra boots", chance = 3640 },
	{ name = "terra hood", chance = 2100 },
	{ name = "terra legs", chance = 455 },
	{ name = "terra mantle", chance = 780 },
	{ name = "terra amulet", chance = 3900 },
	{ name = "stone skin amulet", chance = 2275 },
	{ name = "springsprout rod", chance = 975 },
	{ name = "sacred tree amulet", chance = 1300 },
	{ name = "swamplair armor", chance = 260 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_EARTHDAMAGE, minDamage = -800, maxDamage = -950, length = 6, spread = 0, effect = CONST_ME_GREEN_RINGS, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_EARTHDAMAGE, minDamage = -700, maxDamage = -900, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "terra strike", interval = 2000, chance = 22, minDamage = -700, maxDamage = -850, range = 7, target = false },
}

monster.defenses = {
	defense = 82,
	armor = 82,
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 150, maxDamage = 350, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
