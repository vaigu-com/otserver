local mType = Game.createMonsterType("Terrorsleep")
local monster = {}

monster.description = "Terrorsleep"
monster.experience = 6900
monster.outfit = {
	lookType = 593,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1016
-- monster.Bestiary = {
-- class = "Magical",
-- race = BESTY_RACE_MAGICAL,
-- toKill = 2500,
-- FirstUnlock = 100,
-- SecondUnlock = 1000,
-- CharmsPoints = 50,
-- Stars = 4,
-- Occurrence = 0,
-- Locations = "Roshamuul Mines, Roshamuul Cistern."
-- }

monster.health = 7200
monster.maxHealth = 7200
monster.race = "blood"
monster.corpse = 20163
monster.speed = 180
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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
	{ text = "Aktat Roshok! Marruk!", yell = false },
	{ text = "I will eat you in your sleep.", yell = false },
	{ text = "I am the darkness around you...", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 8 },
	{ id = 3032, chance = 14000 },
	{ id = 3030, chance = 9600, maxCount = 3 },
	{ id = 3033, chance = 17000, maxCount = 3 },
	{ id = 3281, chance = 1960 },
	{ id = 3369, chance = 2220 },
	{ id = 3370, chance = 2300 },
	{ id = 3567, chance = 1600 },
	{ id = 5896, chance = 1200 },
	{ id = 20062, chance = 830 },
	{ id = 5909, chance = 4520 },
	{ id = 5911, chance = 1130 },
	{ name = "great mana potion", chance = 36000, maxCount = 2 },
	{ id = 7643, chance = 26000 },
	{ id = 9057, chance = 17000, maxCount = 2 },
	{ id = 16119, chance = 6000 },
	{ id = 16124, chance = 13000 },
	{ id = 16125, chance = 17000 },
	{ id = 20203, chance = 13500 },
	{ id = 20204, chance = 18000 },
	{ id = 20029, chance = 2130 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 90 },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 20, minDamage = -1000, maxDamage = -1500, radius = 7, effect = CONST_ME_YELLOW_RINGS, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -300, radius = 5, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "feversleep skill reducer", interval = 2000, chance = 10, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -350, maxDamage = -500, length = 6, spread = 0, effect = CONST_ME_YELLOWENERGY, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -450, radius = 1, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 80,
	armor = 80,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 350, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 15, effect = CONST_ME_HITAREA },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 35 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 55 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
