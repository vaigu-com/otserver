local mType = Game.createMonsterType("Adult Goanna")
local monster = {}

monster.description = "an adult goanna"
monster.experience = 6650
monster.outfit = {
	lookType = 1195,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1818
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Kilmaresh Central Steppe, Kilmaresh Southern Steppe, Green Belt.",
}

monster.health = 8300
monster.maxHealth = 8300
monster.race = "blood"
monster.corpse = 31405
monster.speed = 210
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 15,
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
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 3 },
	{ name = "envenomed arrow", chance = 55360, maxCount = 8 },
	{ name = "earth arrow", chance = 15200, maxCount = 29 },
	{ name = "emerald bangle", chance = 12500 },
	{ name = "small enchanted emerald", chance = 10000 },
	{ name = "green crystal splinter", chance = 9100 },
	{ name = "terra rod", chance = 8400 },
	{ name = "goanna meat", chance = 11140 },
	{ name = "blue crystal shard", chance = 8400 },
	{ name = "small sapphire", maxCount = 2, chance = 8400 },
	{ name = "goanna claw", chance = 6490 },
	{ name = "yellow gem", chance = 4400 },
	{ name = "green gem", chance = 3100 },
	{ name = "opal", maxCount = 2, chance = 2800 },
	{ name = "onyx chip", chance = 2700 },
	{ name = "gemmed figurine", chance = 1500 },
	{ name = "white pearl", chance = 1300 },
	{ name = "small amethyst", chance = 1200 },
	{ name = "lizard heart", chance = 900 },
	{ name = "red goanna scale", chance = 8000 },
	{ name = "fur armor", chance = 1300 },
	{ name = "serpent sword", chance = 2800 },
	{ name = "terra amulet", chance = 5800 },
	{ name = "terra hood", chance = 6600 },
	{ name = "wood cape", chance = 1300 },
	{ name = "scared frog", chance = 2500 },
	{ name = "sacred tree amulet", chance = 1000 },
	{ name = "small tortoise", chance = 1100 },
	{ name = "coral brooch", chance = 700 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400, condition = { type = CONDITION_POISON, totalDamage = 19, interval = 4000 } }, -- mele
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -600, range = 3, radius = 1, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_EXPLOSIONHIT, target = true }, -- terra strike
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -380, radius = 5, effect = CONST_ME_GROUNDSHAKER, target = false }, -- groundshaker ball
	{ name = "wave t", interval = 2000, chance = 12, minDamage = -250, maxDamage = -380, target = false }, -- short wave
}

monster.defenses = {
	defense = 84,
	armor = 84,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 250, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 25 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
