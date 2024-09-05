local mType = Game.createMonsterType("Diremaw")
local monster = {}

monster.description = "a diremaw"
monster.experience = 2500
monster.outfit = {
	lookType = 1034,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1532
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Gnome Deep Hub (north and south tasking areas), Warzone 6.",
}

monster.health = 3600
monster.maxHealth = 3600
monster.race = "blood"
monster.corpse = 27494
monster.speed = 150
monster.manaCost = 450

monster.changeTarget = {
	interval = 2000,
	chance = 11,
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
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
	{ text = "uuaarrrrrrrrr", yell = false },
	{ text = "clic clic clic", yell = false },
}

monster.loot = {
	{ name = "small emerald", chance = 5250, maxCount = 2 },
	{ name = "small enchanted emerald", chance = 2460, maxCount = 2 },
	{ name = "onyx chip", chance = 8650, maxCount = 3 },
	{ name = "diremaw brainpan", chance = 26160 },
	{ name = "diremaw legs", chance = 9360 },
	{ name = "poisonous slime", chance = 13360 },
	{ name = "blue crystal shard", chance = 12150 },
	{ name = "violet crystal shard", chance = 8100 },
	{ name = "green crystal shard", chance = 7280 },
	{ name = "small enchanted amethyst", chance = 3640 },
	{ id = 281, chance = 3340 },
	{ name = "gold ingot", chance = 2630 },
	{ name = "suspicious device", chance = 1970 },
	{ name = "mushroom backpack", chance = 220 },
	{ name = "mycological bow", chance = 110 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "stalagmite rune", interval = 2000, chance = 15, minDamage = -150, maxDamage = -200, range = 7, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -300, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -250, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POFF, target = true },
}

monster.defenses = {
	defense = 71,
	armor = 71,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
