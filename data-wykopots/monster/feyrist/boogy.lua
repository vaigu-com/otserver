local mType = Game.createMonsterType("Boogy")
local monster = {}

monster.description = "a boogy"
monster.experience = 950
monster.outfit = {
	lookType = 981,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1439
monster.Bestiary = {
	class = "Fey",
	race = BESTY_RACE_FEY,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Feyrist (night time) and its underground (all day).",
}

monster.health = 1300
monster.maxHealth = 1300
monster.race = "blood"
monster.corpse = 25819
monster.speed = 105
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

-- monster.respawnType = {
-- period = RESPAWNPERIOD_NIGHT,
-- underground = true
-- }

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 20,
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
	{ text = "Go to sleep!", yell = false },
	{ text = "Roarrr!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 195 },
	{ id = 24390, chance = 2870, maxCount = 5 },
	{ id = 7439, chance = 960 },
	{ id = 25694, chance = 15300 },
	{ id = 3306, chance = 1100 },
	{ id = 25735, chance = 8300, maxCount = 7 },
	{ id = 5014, chance = 190 },
	{ id = 24962, chance = 3200, maxCount = 2 },
	{ id = 16126, chance = 3700, maxCount = 2 },
	{ id = 25693, chance = 18000 },
	{ id = 3738, chance = 3300 },
	{ id = 677, chance = 2100, maxCount = 3 },
	{ id = 236, chance = 15000 },
	{ id = 814, chance = 3200 },
	{ id = 3727, chance = 4600 },
	{ id = 25699, chance = 400 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 11, minDamage = -100, maxDamage = -300, radius = 5, shootEffect = CONST_ANI_WHIRLWINDCLUB, effect = CONST_ME_DRAWBLOOD, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -150, range = 7, shootEffect = CONST_ANI_LARGEROCK, target = true },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_LIFEDRAIN, minDamage = -0, maxDamage = -100, range = 4, shootEffect = CONST_ANI_WHIRLWINDCLUB, effect = CONST_ME_DRAWBLOOD, target = true },
}

monster.defenses = {
	defense = 35,
	armor = 35,
	{ name = "speed", interval = 2000, chance = 10, speedChange = 200, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_HEALING, minDamage = 20, maxDamage = 120, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 70 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 40 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
