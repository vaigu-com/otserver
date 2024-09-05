local mType = Game.createMonsterType("Flying Book")
local monster = {}

monster.description = "a flying book"
monster.experience = 200
monster.outfit = {
	lookType = 1060,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1654
-- monster.Bestiary = {
-- class = "Magical",
-- race = BESTY_RACE_MAGICAL,
-- toKill = 1000,
-- FirstUnlock = 50,
-- SecondUnlock = 500,
-- CharmsPoints = 25,
-- Stars = 3,
-- Occurrence = 1,
-- Locations = "Secret Library."
-- }

monster.health = 500
monster.maxHealth = 500
monster.race = "undead"
monster.corpse = 28586
monster.speed = 120
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
	hostile = false,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 500,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {}

monster.attacks = {}

monster.defenses = {
	defense = 45,
	armor = 45,
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_HEALING, minDamage = 30, maxDamage = 100, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 90 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
