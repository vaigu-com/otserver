local mType = Game.createMonsterType("Ice Dragon")
local monster = {}

monster.description = "an ice dragon"
monster.experience = 2300
monster.outfit = {
	lookType = 947,
	lookHead = 9,
	lookBody = 9,
	lookLegs = 9,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1380
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 2,
	Locations = "The First Dragon's Lair.",
}

monster.health = 2500
monster.maxHealth = 2500
monster.race = "undead"
monster.corpse = 25185
monster.speed = 106
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5,
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
	runHealth = 350,
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
	{ name = "gold coin", chance = 95000, maxCount = 216 },
	{ name = "shiver arrow", chance = 8000, maxCount = 10 },
	{ name = "great mana potion", chance = 5000, maxCount = 2 },
	{ name = "dragon ham", chance = 80000 },
	{ name = "dragon blood", chance = 19000 },
	{ name = "dragon tongue", chance = 11500 },
	{ name = "small sapphire", chance = 5200 },
	{ id = 3051, chance = 5000 }, -- energy ring
	{ id = 7441, chance = 4300 },
	{ name = "hailstorm rod", chance = 2200 },
	{ name = "golden mug", chance = 2200 },
	{ name = "glacier mask", chance = 1200 },
	{ name = "shard", chance = 1200 },
	{ name = "glacier amulet", chance = 540 },
	{ name = "life crystal", chance = 540 },
	{ name = "dragon scale mail", chance = 330 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -120, maxDamage = -220 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -70, maxDamage = -90, radius = 4, effect = CONST_ME_ICETORNADO, target = false }, --ice ball
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_ICEDAMAGE, minDamage = -70, maxDamage = -90, range = 7, effect = CONST_ME_ICETORNADO, target = true }, --ice strike
	{ name = "speed", interval = 2000, chance = 12, speedChange = -600, range = 5, radius = 5, effect = CONST_ME_ICEATTACK, target = false, duration = 20000 }, --paral ball
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_LIFEDRAIN, minDamage = -85, maxDamage = -180, length = 8, spread = 3, effect = CONST_ME_POFF, target = false }, --ice wave
}

monster.defenses = {
	defense = 35,
	armor = 22,
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = -30 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
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
