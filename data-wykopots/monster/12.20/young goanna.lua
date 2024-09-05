local mType = Game.createMonsterType("Young Goanna")
local monster = {}

monster.description = "a young goanna"
monster.experience = 6100
monster.outfit = {
	lookType = 1196,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1817
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

monster.health = 6200
monster.maxHealth = 6200
monster.race = "blood"
monster.corpse = 31409
monster.speed = 190
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
	{ name = "envenomed arrow", chance = 68000, maxCount = 35 },
	{ name = "terra rod", chance = 8600 },
	{ name = "blue crystal shard", chance = 8600 },
	{ name = "goanna meat", chance = 8800 },
	{ name = "blue goanna scale", chance = 8000 },
	{ name = "goanna claw", chance = 3600 },
	{ name = "serpent sword", chance = 3200 },
	{ name = "leaf star", chance = 4800, maxCount = 3 },
	{ name = "small enchanted emerald", chance = 4500 },
	{ name = "onyx chip", chance = 4000 },
	{ name = "violet gem", chance = 3600 },
	{ name = "rainbow quartz", maxCount = 3, chance = 3500 },
	{ name = "green crystal shard", chance = 3500 },
	{ name = "yellow gem", chance = 2300 },
	{ name = "blue gem", chance = 1400 },
	{ name = "blue crystal splinter", chance = 800 },
	{ name = "silver amulet", chance = 2200 },
	{ name = "springsprout rod", chance = 3500 },
	{ name = "scared frog", chance = 2300 },
	{ name = "terra amulet", chance = 1400 },
	{ name = "lizard heart", chance = 400 },
	{ name = "sacred tree amulet", chance = 850 },
	{ name = "small tortoise", chance = 600 },
	{ name = "fur armor", chance = 150 },
	{ name = "wooden spellbook", chance = 210 },
	{ name = "terra hood", chance = 1000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400, condition = { type = CONDITION_POISON, totalDamage = 15, interval = 4000 } }, -- melee
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_EARTHDAMAGE, minDamage = -350, maxDamage = -500, range = 4, radius = 1, shootEffect = CONST_ANI_POISON, target = true }, --terra strike
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -450, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false }, -- groundshaker box
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -450, length = 2, spread = 0, effect = CONST_ME_GREEN_RINGS, target = false }, -- tiny poison beam
	-- groundshaker box
}

monster.defenses = {
	defense = 78,
	armor = 78,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 250, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
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
