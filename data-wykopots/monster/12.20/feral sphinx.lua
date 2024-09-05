local mType = Game.createMonsterType("Feral Sphinx")
local monster = {}

monster.description = "a feral sphinx"
monster.experience = 8800
monster.outfit = {
	lookType = 1188,
	lookHead = 57,
	lookBody = 75,
	lookLegs = 38,
	lookFeet = 86,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1807
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Kilmaresh, south of Issavi.",
}

monster.health = 9800
monster.maxHealth = 9800
monster.race = "blood"
monster.corpse = 31658
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
	{ name = "platinum coin", chance = 100000, maxCount = 3 },
	{ name = "green crystal shard", chance = 8600 },
	{ id = 3039, chance = 8300 },
	{ name = "cyan crystal fragment", chance = 7600 },
	{ name = "small sapphire", maxCount = 2, chance = 5900 },
	{ name = "blue gem", chance = 5500 },
	{ name = "green gem", chance = 2800 },
	{ name = "small enchanted emerald", maxCount = 2, chance = 1200 },
	{ name = "sphinx feather", chance = 5900 },
	{ name = "sphinx tiara", chance = 5300 },
	{ name = "dragon necklace", chance = 5900 },
	{ name = "magma amulet", chance = 5900 },
	{ name = "magma legs", chance = 900 },
	{ name = "magma monocle", chance = 1400 },
	{ name = "wand of draconia", chance = 2900 },
	{ name = "wand of inferno", chance = 5400 },
	{ name = "magma boots", chance = 1250 },
	{ name = "fire axe", chance = 3700 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "fire wave", interval = 2000, chance = 14, minDamage = -350, maxDamage = -500, target = false }, -- fire wave
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_HOLYDAMAGE, minDamage = -100, maxDamage = -460, length = 4, spread = 0, effect = CONST_ME_HOLYAREA, target = false }, --holy beam
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ENERGYDAMAGE, minDamage = -300, maxDamage = -500, radius = 4, effect = CONST_ME_ENERGYAREA, target = false }, -- energy ball
	{ name = "fireball rune", interval = 2000, chance = 14, minDamage = -350, maxDamage = -550, range = 5, target = true }, -- fire strike
}

monster.defenses = {
	defense = 90,
	armor = 90,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = -15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
