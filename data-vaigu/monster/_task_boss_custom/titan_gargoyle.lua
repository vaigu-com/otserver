local mType = Game.createMonsterType("Titan Gargoyle")
local monster = {}

monster.description = "a titan gargoyle"
monster.experience = 5000
monster.outfit = {
	lookType = 601,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3800
monster.maxHealth = 3800
monster.race = "venom"
monster.corpse = 20976
monster.speed = 175
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
	illusionable = true,
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
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "clonk", yell = false },
	{ text = "*stomp*", yell = false },
}

monster.loot = {
	{ id = 21193, chance = 37160 }, -- metal jaw
	{ id = 3035, chance = 43280, maxCount = 2 }, -- platinum coin
	{ id = 237, chance = 9700, maxCount = 2 }, -- strong mana potion
	{ id = 21171, chance = 8490 }, -- metal bat
	{ id = 8082, chance = 7490 }, -- underworld rod
	{ id = 3051, chance = 2240 }, -- energy ring
	{ id = 3052, chance = 22750 }, -- life ring
	{ id = 10310, chance = 22240 }, -- shiny stone
	{ id = 21169, chance = 21490 }, -- metal spats
	{ id = 21168, chance = 21490 }, -- alloy legs
	{ id = 8896, chance = 32990 }, -- slightly rusted armor
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 94, attack = 60 },
	{
		name = "combat",
		interval = 2000,
		chance = 10,
		type = COMBAT_DEATHDAMAGE,
		minDamage = -125,
		maxDamage = -430,
		length = 8,
		spread = 0,
		effect = CONST_ME_YELLOWENERGY,
		target = false,
	},
	{
		name = "combat",
		interval = 2000,
		chance = 9,
		type = COMBAT_LIFEDRAIN,
		minDamage = -85,
		maxDamage = -350,
		range = 7,
		radius = 3,
		shootEffect = CONST_ANI_SUDDENDEATH,
		effect = CONST_ME_MORTAREA,
		target = true,
	},
	{ name = "metal gargoyle curse", interval = 2000, chance = 23, target = false },
}

monster.defenses = {
	defense = 62,
	armor = 90,
	mitigation = 1.87,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 90 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
