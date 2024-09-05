local mType = Game.createMonsterType("Instable Breach Brood")
local monster = {}

monster.description = "a instable breach brood"
monster.experience = 1100
monster.outfit = {
	lookType = 878,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1265
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

monster.health = 2200
monster.maxHealth = 2200
monster.race = "undead"
monster.corpse = 23553
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5,
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
	{ text = "Hisss!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 50000, maxCount = 100 },
	{ name = "platinum coin", chance = 50000, maxCount = 2 },
	{ id = 23506, chance = 2000 },
	{ id = 23521, chance = 2000 },
	{ id = 23545, chance = 2000 },
	{ name = "great health potion", chance = 3000 },
	{ id = 7642, chance = 3000 },
	{ id = 16121, chance = 1500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 90 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -168, maxDamage = -300, range = 6, radius = 4, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_PURPLEENERGY, target = true },
	{ name = "energy strike", interval = 2000, chance = 30, minDamage = -50, maxDamage = -180, range = 1, target = false },
	-- energy damage
	{ name = "condition", type = CONDITION_ENERGY, interval = 1000, chance = 15, radius = 3, effect = CONST_ME_YELLOWENERGY, target = false },
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 90, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -40 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -30 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
