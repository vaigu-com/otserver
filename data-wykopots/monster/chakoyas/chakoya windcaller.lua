local mType = Game.createMonsterType("Chakoya Windcaller")
local monster = {}

monster.description = "a chakoya windcaller"
monster.experience = 48
monster.outfit = {
	lookType = 260,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 329
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Inukaya, Chyllfroest, Chakoya Iceberg.",
}

monster.health = 84
monster.maxHealth = 84
monster.race = "blood"
monster.corpse = 7320
monster.speed = 100
monster.manaCost = 305

monster.changeTarget = {
	interval = 60000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 0,
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
	{ text = "Mupi! Si siyoqua jinuma!", yell = false },
	{ text = "Siqsiq ji jusipa!", yell = false },
	{ text = "Jagura taluka taqua!", yell = false },
	{ text = "Quatu nguraka!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 72000, maxCount = 27 },
	{ id = 3578, chance = 29000, maxCount = 3 },
	{ id = 3441, chance = 950 },
	{ id = 7159, chance = 60 },
	{ id = 7158, chance = 60 },
	{ id = 3580, chance = 60 },
	{ id = 3354, chance = 3250 },
	{ id = 20356, chance = 440 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 12, attack = 20 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -16, maxDamage = -32, range = 7, shootEffect = CONST_ANI_ICE, target = false },
	-- freeze
	{ name = "condition", type = CONDITION_FREEZING, interval = 2000, chance = 10, minDamage = -130, maxDamage = -160, radius = 3, effect = CONST_ME_ICEAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -9, maxDamage = -30, length = 5, spread = 2, effect = CONST_ME_ICEAREA, target = false },
}

monster.defenses = {
	defense = 10,
	armor = 10,
	{ name = "invisible", interval = 2000, chance = 15, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 50 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
