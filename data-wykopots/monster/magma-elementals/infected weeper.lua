local mType = Game.createMonsterType("Infected Weeper")
local monster = {}

monster.description = "an infected weeper"
monster.experience = 4800
monster.outfit = {
	lookType = 489,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 897
-- monster.Bestiary = {
-- class = "Construct",
-- race = BESTY_RACE_CONSTRUCT,
-- toKill = 2500,
-- FirstUnlock = 100,
-- SecondUnlock = 1000,
-- CharmsPoints = 50,
-- Stars = 4,
-- Occurrence = 1,
-- Locations = "Warzone 2."
-- }

monster.health = 6800
monster.maxHealth = 6800
monster.race = "fire"
monster.corpse = 15906
monster.speed = 170
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 80,
	random = 20,
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
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 3,
	summons = {
		{ name = "Parasite", chance = 10, interval = 2000, count = 3 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Moooaaan!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 198 },
	{ name = "platinum coin", chance = 100000, maxCount = 7 },
	{ id = 7920, chance = 1450 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200 },
	{ name = "soulfire rune", interval = 2000, chance = 100, radius = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -800, length = 8, spread = 0, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "combat", interval = 3000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -350, radius = 4, effect = CONST_ME_MAGIC_RED, target = true },
	{ name = "speed", interval = 2000, chance = 10, speedChange = -300, length = 5, spread = 5, effect = CONST_ME_BLOCKHIT, target = false, duration = 10000 },
}

monster.defenses = {
	defense = 76,
	armor = 76,
	{ name = "invisible", interval = 2000, chance = 10, duration = 4000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
