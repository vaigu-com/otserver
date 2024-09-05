local mType = Game.createMonsterType("Nieumarly Krol Krypty")
local monster = {}

monster.description = "Nieumarly Krol Krypty"
monster.experience = 500000
monster.outfit = {
	lookType = 12,
	lookHead = 1,
	lookBody = 95,
	lookLegs = 90,
	lookFeet = 90,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 60000
monster.maxHealth = 60000
monster.race = "undead"
monster.corpse = 6068
monster.speed = 300
monster.manaCost = 0

monster.changeTarget = {}

monster.strategiesTarget = {
	nearest = 100,
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
	canPushCreatures = false,
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 300,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {
	"NieumarlyKrolKryptyKill",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "GRRR", yell = true },
	{ text = "GRROARR", yell = true },
}

monster.loot = {
	{ id = 3025, chance = 13500 }, -- ancient amulet
	{ id = 3116, chance = 19000 }, -- big bone
	{ name = "black pearl", chance = 15000, maxCount = 35 },
	{ name = "boots of haste", chance = 14000 },
	{ id = 3076, chance = 22500 }, -- crystal ball
	{ name = "crystal necklace", chance = 21500 },
	{ id = 3007, chance = 15500 }, -- crystal ring
	{ name = "demon shield", chance = 15500 },
	{ name = "devil helmet", chance = 11000 },
	{ name = "dragon hammer", chance = 34500 },
	{ id = 3051, chance = 13500 }, -- energy ring
	{ name = "fire axe", chance = 17000 },
	{ name = "giant sword", chance = 12500 },
	{ name = "platinum coin", chance = 69900, maxCount = 100 },
	{ name = "platinum coin", chance = 68800, maxCount = 100 },
	{ name = "crystal coin", chance = 100000, maxCount = 85 },
	{ name = "gold ring", chance = 28000 },
	{ name = "golden legs", chance = 15000 },
	{ name = "giant ruby", chance = 31500 },
	{ name = "giant sapphire", chance = 31500 },
	{ name = "giant emerald", chance = 31500 },
	{ name = "ice rapier", chance = 27500 },
	{ name = "magic plate armor", chance = 13000 },
	{ name = "mastermind shield", chance = 17500 },
	{ name = "purple tome", chance = 12600 },
	{ name = "ring of the sky", chance = 13500 },
	{ name = "silver dagger", chance = 15500 },
	{ name = "skull staff", chance = 25000 },
	{ name = "talon", chance = 14000, maxCount = 27 },
	{ name = "teddy bear", chance = 10500 },
	{ name = "thunder hammer", chance = 3500 },
	{ id = 3002, chance = 5100 }, -- voodoo doll
	{ name = "white pearl", chance = 12500, maxCount = 35 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "nieumarly krol anti tank stacks", interval = 1000, chance = 1000, range = 7, target = true },
	{
		name = "nieumarly krol death lasers",
		interval = 8000,
		chance = 100,
		target = false,
		range = 7,
	},
	{
		name = "nieumarly krol soak bomb",
		interval = 15000,
		chance = 100,
		minDamage = 0,
		maxDamage = 0,
		target = false,
	},
	{
		name = "nieumarly krol summon laga dyga",
		interval = 8000,
		chance = 100,
		minDamage = 0,
		maxDamage = 0,
		target = false,
	},
}

monster.defenses = {
	defense = 40,
	armor = 40,
	{
		name = "combat",
		interval = 2000,
		chance = 15,
		type = COMBAT_HEALING,
		minDamage = 120,
		maxDamage = 225,
		effect = CONST_ME_MAGIC_GREEN,
		target = false,
	},
	{
		name = "speed",
		interval = 2000,
		chance = 15,
		speedChange = 400,
		range = 7,
		effect = CONST_ME_SOUND_PURPLE,
		target = false,
		duration = 5000,
	},
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 65 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
