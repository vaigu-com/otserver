local mType = Game.createMonsterType("Twisted Pooka")
local monster = {}

monster.description = "a twisted pooka"
monster.experience = 600
monster.outfit = {
	lookType = 978,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1436
monster.Bestiary = {
	class = "Fey",
	race = BESTY_RACE_FEY,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Feyrist (nighttime) and its underground (all day).",
}

monster.health = 700
monster.maxHealth = 700
monster.race = "blood"
monster.corpse = 25827
monster.speed = 115
monster.manaCost = 450

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
-- period = RESPAWNPERIOD_DAY,
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
	{ text = "Head off!", yell = false },
}

monster.loot = {
	{ name = "carrot on a stick", chance = 70 },
	{ name = "crystal of focus", chance = 90 },
	{ name = "small stone", chance = 5210, maxCount = 5 },
	{ name = "gold coin", chance = 100000, maxCount = 125 },
	{ id = 3049, chance = 680 }, -- stealth ring
	{ id = 3595, chance = 20500, maxCount = 3 },
	{ name = "strong health potion", chance = 12770 },
	{ name = "orange mushroom", chance = 2820 },
	{ name = "fairy wings", chance = 9570 },
	{ name = "prismatic quartz", chance = 3040 },
	{ name = "shimmering beetles", chance = 10450 },
	{ name = "cookie", chance = 3960, maxCount = 5 },
	{ name = "small enchanted ruby", chance = 3390, maxCount = 2 },
	{ name = "stone herb", chance = 7230 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200, condition = { type = CONDITION_POISON, totalDamage = 160, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 26, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -80, range = 4, shootEffect = CONST_ANI_SMALLSTONE, target = true },
	{ name = "drunk", interval = 3000, chance = 14, length = 5, spread = 2, effect = CONST_ME_STUN, target = false, duration = 12000 },
}

monster.defenses = {
	defense = 41,
	armor = 41,
	{ name = "combat", interval = 2000, chance = 19, type = COMBAT_HEALING, minDamage = 40, maxDamage = 60, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
