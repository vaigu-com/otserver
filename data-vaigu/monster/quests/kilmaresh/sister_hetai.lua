local mType = Game.createMonsterType("Sister Hetai")
local monster = {}

monster.description = "Sister Hetai"
monster.experience = 20500
monster.outfit = {
	lookType = 1199,
	lookHead = 114,
	lookBody = 19,
	lookLegs = 94,
	lookFeet = 78,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 15000
monster.maxHealth = 15000
monster.race = "blood"
monster.corpse = 31419
monster.speed = 115
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2104,
	bossRace = RARITY_ARCHFOE,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
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
	{ name = "crystal coin", chance = 4323, maxCount = 1 },
	{ name = "sacred tree amulet", chance = 781 },
	{ name = "gold ingot", chance = 1677, maxCount = 5 },
	{ name = "lightning headband", chance = 469 },
	{ name = "violet gem", chance = 469 },
	{ name = "onyx chip", chance = 22417 },
	{ name = "rainbow quartz", chance = 417 },
	{ name = "small diamond", chance = 417 },
	{ name = "lightning pendant", chance = 365 },
	{ name = "small emerald", chance = 365 },
	{ name = "magma coat", chance = 313 },
	{ id = 3098, chance = 77313 }, -- ring of healing
	{ name = "magma boots", chance = 260 },
	{ name = "metal spats", chance = 260 },
	{ id = 3097, chance = 44208 }, -- dwarven ring
	{ name = "golden mask", chance = 3208 },
	{ name = "eye-embroidered veil", chance = 4156 },
	{ id = 23531, chance = 27156 }, -- ring of green plasma
	{ name = "yellow gem", chance = 156 },
	{ name = "lightning legs", chance = 104 },
	{ name = "sea horse figurine", chance = 104 },
	{ name = "tagralt-inlaid scabbard", chance = 52 },
	{ id = 36810, chance = 8156 },
	{ id = 18339, chance = 8156 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -270, maxDamage = -500 },
	{ name = "targetfirering", interval = 2000, chance = 40, minDamage = -500, maxDamage = -650, target = true },
	{ name = "combat", interval = 2000, chance = 70, type = COMBAT_FIREDAMAGE, minDamage = -350, maxDamage = -500, radius = 2, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_EXPLOSIONHIT, target = true },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -500, maxDamage = -750, radius = 4, effect = CONST_ME_ENERGYAREA, target = false },
}

monster.defenses = {
	defense = 60,
	armor = 82,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 80 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -45 },
	{ type = COMBAT_HOLYDAMAGE, percent = 40 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
