local mType = Game.createMonsterType("Skeleton Elite Warrior")
local monster = {}

monster.description = "a skeleton elite warrior"
monster.experience = 6375
monster.outfit = {
	lookType = 298,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1674
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Deep Desert.",
}

monster.health = 7800
monster.maxHealth = 7800
monster.race = "undead"
monster.corpse = 5972
monster.speed = 155
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
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
	{ name = "platinum coin", chance = 75000, maxCount = 15 },
	{ id = 3115, chance = 37500 },
	{ id = 3723, chance = 25000 },
	{ id = 3725, chance = 1940 },
	{ id = 11481, chance = 12195 },
	{ name = "soul orb", chance = 18375 },
	{ name = "unholy bone", chance = 7410 },
	{ name = "knight axe", chance = 4612 },
	{ name = "mammoth whopper", chance = 3765 },
	{ name = "bone toothpick", chance = 3720 },
	{ name = "skull helmet", chance = 1800 },
	{ name = "ruthless axe", chance = 337 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -550 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -400, maxDamage = -480, range = 6, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -450, radius = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "sudden death rune", interval = 2000, chance = 20, minDamage = -450, maxDamage = -500, range = 7, target = false },
}

monster.defenses = {
	defense = 75,
	armor = 75,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
