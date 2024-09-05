local mType = Game.createMonsterType("Lamassu")
local monster = {}

monster.description = "a lamassu"
monster.experience = 9000
monster.outfit = {
	lookType = 1190,
	lookHead = 31,
	lookBody = 21,
	lookLegs = 0,
	lookFeet = 19,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1806
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Kilmaresh.",
}

monster.health = 8700
monster.maxHealth = 8700
monster.race = "blood"
monster.corpse = 31394
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 50,
	health = 10,
	damage = 10,
	random = 30,
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
}

monster.loot = {
	{ name = "platinum coin", chance = 100000 },
	{ name = "lamassu horn", chance = 13400, maxCount = 5 },
	{ name = "red crystal fragment", chance = 9700 },
	{ name = "terra amulet", chance = 8000 },
	{ name = "lamassu hoof", chance = 8000 },
	{ name = "violet crystal shard", chance = 11000 },
	{ name = "blue crystal shard", chance = 11000 },
	{ name = "red crystal fragment", chance = 9500 },
	{ id = 3039, chance = 15000 },
	{ name = "opal", chance = 8000 },
	{ name = "small emerald", chance = 6000 },
	{ name = "onyx chip", chance = 5000 },
	{ name = "green crystal fragment", chance = 4000 },
	{ name = "green crystal splinter", chance = 4000 },
	{ name = "terra hood", chance = 5900 },
	{ name = "rainbow quartz", maxCount = 2, chance = 3000 },
	{ name = "sacred tree amulet", chance = 2200 },
	{ name = "elven amulet", chance = 1600 },
	{ name = "blue gem", chance = 1400 },
	{ name = "green crystal shard", chance = 1400 },
	{ name = "violet gem", chance = 2000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HOLYDAMAGE, minDamage = -300, maxDamage = -500, radius = 3, effect = CONST_ME_HOLYAREA, target = false }, --box
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HOLYDAMAGE, minDamage = -400, maxDamage = -500, radius = 4, effect = CONST_ME_HOLYAREA, target = false }, --ball
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -400, range = 5, radius = 3, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_SMALLPLANTS, target = true },
}

monster.defenses = {
	defense = 82,
	armor = 82,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = -30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
