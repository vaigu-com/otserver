local mType = Game.createMonsterType("Spiky Carnivor")
local monster = {}

monster.description = "a Spiky Carnivor"
monster.experience = 2500
monster.outfit = {
	lookType = 1139,
	lookHead = 79,
	lookBody = 119,
	lookLegs = 57,
	lookFeet = 86,
	lookAddons = 1,
	lookMount = 0,
}

-- monster.raceId = 1722
-- monster.Bestiary = {
-- class = "Magical",
-- race = BESTY_RACE_MAGICAL,
-- toKill = 2500,
-- FirstUnlock = 100,
-- SecondUnlock = 1000,
-- CharmsPoints = 50,
-- Stars = 4,
-- Occurrence = 0,
-- Locations = "Carnivora's Rocks."
-- }

monster.health = 2800
monster.maxHealth = 2800
monster.race = "blood"
monster.corpse = 30099
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	staticAttackChance = 90,
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
	{ text = "Zuumsh", yell = false },
	{ text = "The lumbering fortress!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 12 },
	{ name = "green glass plate", chance = 15960, maxCount = 3 },
	{ name = "blue crystal splinter", chance = 11630 },
	{ name = "brown crystal splinter", chance = 10390 },
	{ name = "dark armor", chance = 20690 },
	{ name = "guardian shield", chance = 7390 },
	{ name = "rainbow quartz", chance = 3540 },
	{ name = "blue robe", chance = 2130 },
	{ name = "glacier amulet", chance = 2090 },
	{ name = "lightning pendant", chance = 1070 },
	{ name = "prismatic quartz", chance = 2330 },
	{ name = "talon", chance = 3190 },
	{ name = "terra amulet", chance = 2910 },
	{ name = "warrior helmet", chance = 5120 },
	{ name = "shockwave amulet", chance = 460 },
	{ name = "terra mantle", chance = 640 },
	{ name = "buckle", chance = 610 },
	{ name = "doublet", chance = 440 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -250 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -180, maxDamage = -230, radius = 4, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "lumbering carnivor wave", interval = 2000, chance = 18, minDamage = -190, maxDamage = -230, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -110, maxDamage = -170, length = 4, spread = 0, effect = CONST_ME_POISONAREA, target = false },
}

monster.defenses = {
	defense = 71,
	armor = 71,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 40 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
