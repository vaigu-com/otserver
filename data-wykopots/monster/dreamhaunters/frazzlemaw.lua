local mType = Game.createMonsterType("Frazzlemaw")
local monster = {}

monster.description = "Frazzlemaw"
monster.experience = 3740
monster.outfit = {
	lookType = 594,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1022
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Lower Roshamuul, Guzzlemaw Valley, the entrance to Upper Roshamuul.",
}

monster.health = 4100
monster.maxHealth = 4100
monster.race = "blood"
monster.corpse = 20233
monster.speed = 200
monster.manaCost = 0

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
	{ text = "Mwaaaahnducate youuuuuu *gurgle*", yell = false },
	{ text = "mwaaah!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 80000, maxCount = 8 },
	{ id = 3104, chance = 1600 },
	{ id = 3110, chance = 2320 },
	{ id = 3111, chance = 2000 },
	{ id = 3114, chance = 4144 },
	{ id = 3115, chance = 2000 },
	{ id = 3116, chance = 2400 },
	{ id = 3265, chance = 1408 },
	{ id = 3578, chance = 5176, maxCount = 3 },
	{ name = "ham", chance = 4800 },
	{ id = 5880, chance = 2408 },
	{ id = 5895, chance = 3984 },
	{ id = 5925, chance = 4024 },
	{ id = 5951, chance = 7920 },
	{ id = 7404, chance = 720 },
	{ id = 7407, chance = 1624 },
	{ id = 7418, chance = 624 },
	{ name = "great mana potion", chance = 14990, maxCount = 3 },
	{ name = "great health potion", chance = 15000, maxCount = 2 },
	{ name = "gold ingot", chance = 2008 },
	{ id = 10389, chance = 1232 },
	{ id = 16120, chance = 2376 },
	{ id = 16123, chance = 12056 },
	{ id = 16126, chance = 4000 },
	{ id = 20131, chance = 4000 },
	{ id = 20062, chance = 510 },
	{ id = 20198, chance = 14536 },
	{ id = 20199, chance = 11992 },
	{ id = 3125, chance = 3536 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 80 },
	-- bleed
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 15, minDamage = -500, maxDamage = -1000, radius = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -1000, length = 5, spread = 0, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -300, radius = 2, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_STONES, target = true },
	{ name = "speed", interval = 2000, chance = 10, speedChange = -600, radius = 5, effect = CONST_ME_MAGIC_RED, target = false, duration = 15000 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -300, radius = 4, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 74,
	armor = 74,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 250, maxDamage = 425, effect = CONST_ME_HITBYPOISON, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
