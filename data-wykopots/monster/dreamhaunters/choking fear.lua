local mType = Game.createMonsterType("Choking Fear")
local monster = {}

monster.description = "Choking Fear"
monster.experience = 4700
monster.outfit = {
	lookType = 586,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1015
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "All over the surface of Upper Roshamuul and Nightmare Isles.",
}

monster.health = 5800
monster.maxHealth = 5800
monster.race = "undead"
monster.corpse = 20159
monster.speed = 190
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
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
	{ text = "Ah, sweet air... don't you miss it?", yell = false },
	{ text = "Murr tat muuza!", yell = false },
	{ text = "kchh", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 75000, maxCount = 9 },
	{ id = 3051, chance = 2250 },
	{ id = 3052, chance = 4200 },
	{ id = 3098, chance = 3000 },
	{ id = 5913, chance = 4500 },
	{ id = 5914, chance = 2625 },
	{ name = "great mana potion", chance = 20000, maxCount = 3 },
	{ id = 813, chance = 540 },
	{ id = 7642, chance = 20000, maxCount = 3 },
	{ id = 7643, chance = 19000, maxCount = 3 },
	{ id = 8074, chance = 540 },
	{ id = 16121, chance = 1155 },
	{ id = 16123, chance = 39375, maxCount = 2 },
	{ id = 16124, chance = 7500, maxCount = 3 },
	{ id = 20062, chance = 600 },
	{ id = 20202, chance = 10635 },
	{ id = 20206, chance = 10635 },
	{ id = 3344, chance = 2617 },
	{ id = 3415, chance = 1155 },
	{ id = 8084, chance = 552 },
	{ id = 7451, chance = 816 },
	{ id = 8082, chance = 600 },
	{ id = 10389, chance = 877 },
	{ id = 811, chance = 472 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -450, condition = { type = CONDITION_POISON, totalDamage = 600, interval = 4000 } }, --mele
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 9, minDamage = -700, maxDamage = -900, length = 5, spread = 3, effect = CONST_ME_HITBYPOISON, target = false }, -- poison wave
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -250, maxDamage = -500, radius = 4, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true }, --death ball
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_LIFEDRAIN, minDamage = -400, maxDamage = -500, radius = 1, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_SLEEP, target = true }, --sleeping strike
	{ name = "speed", interval = 2000, chance = 8, speedChange = -700, radius = 1, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_SLEEP, target = true, duration = 15000 }, --paral
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -25, maxDamage = -100, radius = 4, effect = CONST_ME_SLEEP, target = false }, --manadrain
	{ name = "choking fear drown", interval = 2000, chance = 10, target = false }, -- drown
}

monster.defenses = {
	defense = 67,
	armor = 67,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 80, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 55 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
