local mType = Game.createMonsterType("Horadron")
local monster = {}

monster.description = "Horadron"
monster.experience = 18000
monster.outfit = {
	lookType = 12,
	lookHead = 78,
	lookBody = 80,
	lookLegs = 110,
	lookFeet = 77,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 30000
monster.maxHealth = 30000
monster.race = "blood"
monster.corpse = 6068
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 25,
}

monster.strategiesTarget = {
	nearest = 60,
	health = 15,
	damage = 15,
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

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Defiler", chance = 20, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Even I fear the wrath of the princes. And the cold touch of those whom they serve! You are not prepared!", yell = false },
	{ text = "You foolish mortals with you medding you brought the end upon your world!", yell = false },
	{ text = "After all those aeons I smell freedom at last!", yell = false },
}

monster.loot = {
	{ id = 20062, chance = 100000 }, -- cluster
	{ id = 5954, chance = 100000 }, --horn
	{ name = "demonic essence", chance = 100000 },
	{ id = 20063, chance = 63000 }, -- dream matter
	{ id = 20276, chance = 8780 }, -- mask
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ id = 20264, chance = 100000 }, -- dreams
	{ id = 8075, chance = 5130 }, -- lost souls
	{ id = 8073, chance = 35900 }, -- warding
	{ id = 8074, chance = 10260 }, -- mind
	{ id = 3344, chance = 33330 }, -- beastslayer
	{ id = 7456, chance = 12820 }, -- noble
	{ id = 7453, chance = 870 }, -- executioner
	{ name = "vile axe", chance = 2560 },
	{ id = 7412, chance = 2600 }, -- butcher
	{ id = 3360, chance = 1220 }, -- gold arm
	{ id = 3567, chance = 1220 }, -- brobe
	{ id = 3381, chance = 17950 }, -- crown
	{ name = "golden legs", chance = 870 },
	{ id = 3303, chance = 400 }, -- greaet axe
	{ id = 8098, chance = 400 }, -- demonwing
	{ id = 8076, chance = 1700 }, -- prophecies
	{ id = 822, chance = 13050 }, --lightning
	{ id = 3371, chance = 16050 }, -- klegs
	{ id = 3382, chance = 8510 }, -- clegs
	{ name = "steel boots", chance = 12380 },
	{ id = 3028, chance = 17950, maxCount = 25 }, -- diamond
	{ id = 3033, chance = 17030, maxCount = 25 },
	{ id = 3032, chance = 10260, maxCount = 25 },
	{ id = 3029, chance = 28210, maxCount = 25 },
	{ id = 9057, chance = 15380, maxCount = 25 },
	{ id = 3030, chance = 20510, maxCount = 25 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 110, attack = 100 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -900, length = 8, spread = 0, effect = CONST_ME_HITBYPOISON, target = false }, -- beam
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -3000, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_HITBYPOISON, target = true }, -- strike
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -250, radius = 3, effect = CONST_ME_POISONAREA, target = false }, -- berserk
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 25, minDamage = -300, maxDamage = -450, radius = 3, effect = CONST_ME_HITBYPOISON, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_HEALING, minDamage = 400, maxDamage = 700, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
