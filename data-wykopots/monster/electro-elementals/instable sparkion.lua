local mType = Game.createMonsterType("Instable Sparkion")
local monster = {}

monster.description = "an instable sparkion"
monster.experience = 1350
monster.outfit = {
	lookType = 877,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1264
-- monster.Bestiary = {
-- class = "Extra Dimensional",
-- race = BESTY_RACE_EXTRA_DIMENSIONAL,
-- toKill = 1000,
-- FirstUnlock = 50,
-- SecondUnlock = 500,
-- CharmsPoints = 25,
-- Stars = 3,
-- Occurrence = 0,
-- Locations = "Otherworld."
-- }

monster.health = 1900
monster.maxHealth = 1900
monster.race = "venom"
monster.corpse = 23388
monster.speed = 140
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 85,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
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
	{ text = "Zzing!", yell = false },
	{ text = "Frizzle!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 50000, maxCount = 100 },
	{ name = "platinum coin", chance = 50000, maxCount = 2 },
	{ id = 23504, chance = 5000 },
	{ id = 23503, chance = 3000 },
	{ name = "great health potion", chance = 3000 },
	{ id = 7642, chance = 3000 },
	{ id = 23505, chance = 2000 },
	{ id = 23535, chance = 2000 },
	{ id = 16125, chance = 1500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 60, attack = 120 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -125, maxDamage = -350, range = 7, radius = 2, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -100, maxDamage = -190, range = 7, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "energy elemental electrify", interval = 2000, chance = 30, target = false },
}

monster.defenses = {
	defense = 37,
	armor = 37,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 50, maxDamage = 80, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 400, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
