local mType = Game.createMonsterType("Golem Deez")
local monster = {}

monster.description = "a golem deez"
monster.experience = 5400
monster.outfit = {
	lookType = 326,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 6500
monster.maxHealth = 6500
monster.race = "venom"
monster.corpse = 9092
monster.speed = 205
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
}

monster.light = {
	level = 3,
	color = 180,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Klonk klonk klonk", yell = false },
	{ text = "Engaging Enemy!", yell = false },
	{ text = "Threat level processed.", yell = false },
	{ text = "Charging weapon systems!", yell = false },
	{ text = "Termination initialized!", yell = false },
	{ text = "Rrrtttarrrttarrrtta", yell = false },
}

monster.loot = {
	{ id = 7643, chance = 80080 }, -- ultimate health potion
	{ id = 5880, chance = 60920, maxCount = 10 }, -- iron ore
	{ id = 3326, chance = 6400 }, -- epee
	{ id = 3097, chance = 21210 }, -- dwarven ring
	{ id = 9654, chance = 31900 },
	{ id = 3554, chance = 6200 }, -- steel boots
	{ id = 7403, chance = 1500 }, -- berserker
	{ id = 7422, chance = 2200 }, -- jade hammer
	{ id = 7428, chance = 7700 }, -- bonebreaker
	{ id = 3061, chance = 10000 }, -- life crystal
	{ id = 12305, chance = 7000 }, -- tin key
	{ id = 22756, chance = 4000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -750 },
	{
		name = "combat",
		interval = 2000,
		chance = 15,
		type = COMBAT_ENERGYDAMAGE,
		minDamage = -165,
		maxDamage = -420,
		range = 7,
		shootEffect = CONST_ANI_ENERGY,
		target = false,
	},
	{
		name = "outfit",
		interval = 2000,
		chance = 1,
		range = 7,
		target = false,
		duration = 3000,
		outfitMonster = "skeleton",
	},
	{
		name = "combat",
		interval = 2000,
		chance = 10,
		type = COMBAT_ENERGYDAMAGE,
		minDamage = -130,
		maxDamage = -350,
		length = 8,
		spread = 0,
		effect = CONST_ME_BIGCLOUDS,
		target = false,
	},
	{ name = "war golem electrify", interval = 2000, chance = 15, range = 1, target = false },
	{ name = "war golem skill reducer", interval = 2000, chance = 10, target = false },
	{
		name = "combat",
		interval = 2000,
		chance = 10,
		type = COMBAT_LIFEDRAIN,
		minDamage = -300,
		maxDamage = -490,
		length = 8,
		spread = 0,
		effect = CONST_ME_PURPLEENERGY,
		target = false,
	},
}

monster.defenses = {
	defense = 60,
	armor = 55,
	mitigation = 1.18,
	{
		name = "speed",
		interval = 2000,
		chance = 15,
		speedChange = 300,
		effect = CONST_ME_MAGIC_RED,
		target = false,
		duration = 5000,
	},
	{
		name = "combat",
		interval = 2000,
		chance = 15,
		type = COMBAT_HEALING,
		minDamage = 200,
		maxDamage = 250,
		effect = CONST_ME_MAGIC_BLUE,
		target = false,
	},
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 50 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = -20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
