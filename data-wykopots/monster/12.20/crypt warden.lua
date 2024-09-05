local mType = Game.createMonsterType("Crypt Warden")
local monster = {}

monster.description = "a crypt warden"
monster.experience = 8400
monster.outfit = {
	lookType = 1190,
	lookHead = 98,
	lookBody = 21,
	lookLegs = 0,
	lookFeet = 19,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1805
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Kilmaresh Catacombs.",
}

monster.health = 8300
monster.maxHealth = 8300
monster.race = "blood"
monster.corpse = 31650
monster.speed = 145
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
	staticAttackChance = 90,
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
	{ name = "platinum coin", chance = 100000, maxCount = 3 },
	{ name = "cyan crystal fragment", chance = 19700 },
	{ name = "lamassu horn", chance = 10800 },
	{ name = "small amethyst", chance = 10000 },
	{ name = "lamassu hoof", chance = 10000 },
	{ name = "gold ingot", chance = 6800 },
	{ name = "green crystal fragment", chance = 3900 },
	{ name = "green gem", chance = 3900 },
	{ name = "elven amulet", chance = 810 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 }, --mele
	{ name = "crypt warden ring", interval = 2000, chance = 14, minDamage = -250, maxDamage = -350, target = false }, --circle
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -350, radius = 2, effect = CONST_ME_GROUNDSHAKER, target = false }, -- cross
	{ name = "earthx", interval = 2000, chance = 10, minDamage = -250, maxDamage = -350, target = false }, -- x cross
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HOLYDAMAGE, minDamage = -300, maxDamage = -500, length = 5, spread = 0, effect = CONST_ME_HOLYAREA, target = false }, -- holybeam
}

monster.defenses = {
	defense = 84,
	armor = 84,
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
	{ type = COMBAT_HOLYDAMAGE, percent = 25 },
	{ type = COMBAT_DEATHDAMAGE, percent = -35 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
