local mType = Game.createMonsterType("Ink Blob")
local monster = {}

monster.description = "a ink blob"
monster.experience = 14450
monster.outfit = {
	lookType = 1064,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1658
-- monster.Bestiary = {
-- class = "Slime",
-- race = BESTY_RACE_SLIME,
-- toKill = 2500,
-- FirstUnlock = 100,
-- SecondUnlock = 1000,
-- CharmsPoints = 50,
-- Stars = 4,
-- Occurrence = 0,
-- Locations = "Secret Library."
-- }

monster.health = 9500
monster.maxHealth = 9500
monster.race = "undead"
monster.corpse = 28602
monster.speed = 190
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
	{ text = "blip, blub", yell = false },
	{ text = "*sluurp!*", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 65000, maxCount = 25 },
	{ name = "small diamond", chance = 53950, maxCount = 7 },
	{ name = "envenomed arrow", chance = 57460, maxCount = 50 },
	{ name = "small topaz", chance = 42048, maxCount = 3 },
	{ id = 28568, chance = 39000 },
	{ name = "poisonous slime", chance = 28600 },
	{ id = 281, chance = 12610, maxCount = 3 },
	{ name = "blue gem", chance = 6311 },
	{ name = "terra hood", chance = 2866 },
	{ name = "terra boots", chance = 2541 },
	{ name = "protection amulet", chance = 1475 },
	{ name = "terra legs", chance = 1150 },
	{ name = "stone skin amulet", chance = 1066 },
	{ name = "sacred tree amulet", chance = 819 },
	{ name = "terra amulet", chance = 656 },
	{ name = "terra mantle", chance = 494 },
	{ name = "clay lump", chance = 325 },
	{ name = "springsprout rod", chance = 325 },
	{ name = "swamplair armor", chance = 84 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700, condition = { type = CONDITION_POISON, totalDamage = 280, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -1200, maxDamage = -1650, length = 7, spread = 3, effect = CONST_ME_LOSEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -700, maxDamage = -1000, radius = 4, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_EARTHDAMAGE, minDamage = -600, maxDamage = -800, radius = 6, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_EARTHDAMAGE, minDamage = -700, maxDamage = -1100, radius = 3, effect = CONST_ME_POISONAREA, target = false },
}

monster.defenses = {
	defense = 70,
	armor = 70,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -8 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
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
