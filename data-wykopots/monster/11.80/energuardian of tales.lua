local mType = Game.createMonsterType("Energuardian of Tales")
local monster = {}

monster.description = "an energuardian of tales"
monster.experience = 11475
monster.outfit = {
	lookType = 1063,
	lookHead = 67,
	lookBody = 104,
	lookLegs = 62,
	lookFeet = 93,
	lookAddons = 3,
	lookMount = 0,
}

-- monster.raceId = 1666
-- monster.Bestiary = {
-- class = "Magical",
-- race = BESTY_RACE_MAGICAL,
-- toKill = 2500,
-- FirstUnlock = 100,
-- SecondUnlock = 1000,
-- CharmsPoints = 50,
-- Stars = 4,
-- Occurrence = 0,
-- Locations = "The Secret Library."
-- }

monster.health = 14000
monster.maxHealth = 14000
monster.race = "undead"
monster.corpse = 28874
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
	{ text = "Let the energy flow!", yell = false },
	{ text = "Die, enervating mortal!", yell = false },
}

monster.loot = {
	{ name = "book page", chance = 51350, maxCount = 6 },
	{ name = "small amethyst", chance = 49400, maxCount = 8 },
	{ name = "glowing rune", chance = 15470, maxCount = 6 },
	{ name = "flash arrow", chance = 5850, maxCount = 15 },
	{ name = "spellbook of warding", chance = 9750 },
	{ name = "great mana potion", chance = 9750 },
	{ name = "ultimate health potion", chance = 9750 },
	{ name = "wand of starstorm", chance = 7150 },
	{ name = "lightning legs", chance = 5850 },
	{ name = "might ring", chance = 2600 },
	{ name = "lightning pendant", chance = 2405 },
	{ name = "platinum amulet", chance = 1625 },
	{ name = "wand of defiance", chance = 780 },
	{ name = "spellweaver's robe", chance = 780 },
	{ name = "shockwave amulet", chance = 325 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -800, maxDamage = -1100, length = 6, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -700, maxDamage = -900, range = 2, radius = 3, effect = CONST_ME_ENERGYAREA, target = true },
	{ name = "energy strike", interval = 2000, chance = 25, minDamage = -700, maxDamage = -850, range = 7, target = false },
}

monster.defenses = {
	defense = 77,
	armor = 77,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = -12 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
