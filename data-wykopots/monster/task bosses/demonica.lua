local mType = Game.createMonsterType("Demonica")
local monster = {}

monster.description = "a demonica"
monster.experience = 16000
monster.outfit = {
	lookType = 35,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 23200
monster.maxHealth = 23200
monster.race = "fire"
monster.corpse = 5995
monster.speed = 205
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20,
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
		{ name = "fire elemental", chance = 20, interval = 2000, count = 2 },
		{ name = "demon", chance = 10, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Your soul will be mine!", yell = false },
	{ text = "MUHAHAHAHA!", yell = false },
	{ text = "CHAMEK ATH UTHUL ARAK!", yell = false },
	{ text = "I SMELL FEEEEAAAAAR!", yell = false },
	{ text = "Your resistance is futile!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, minCount = 5, maxCount = 15 },
	{ id = 3032, chance = 26130, maxCount = 3 },
	{ id = 3320, chance = 90990 },
	{ id = 3281, chance = 33000 },
	{ id = 3420, chance = 7400 },
	{ id = 5954, chance = 19740 },
	{ name = "golden legs", chance = 430 },
	{ id = 3414, chance = 5800 },
	{ id = 3048, chance = 76800 },
	{ id = 3366, chance = 1100 },
	{ id = 7393, chance = 900 },
	{ id = 7382, chance = 1300 },
	{ name = "demonic essence", chance = 90920 },
	{ id = 3030, chance = 26060, maxCount = 15 },
	{ id = 3033, chance = 26950, maxCount = 15 },
	{ id = 9057, chance = 26230, maxCount = 15 },
	{ id = 3039, chance = 29020 },
	{ id = 8023, chance = 18111 },
	{ id = 8058, chance = 8882 },
	{ id = 7431, chance = 14000 },
	{ id = 3309, chance = 13000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 70, attack = 130 },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -120, range = 7, target = false },
	{ name = "combat", interval = 4000, chance = 24, type = COMBAT_FIREDAMAGE, minDamage = -450, maxDamage = -600, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = false },
	{ name = "firefield", interval = 2000, chance = 14, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -380, maxDamage = -500, length = 7, spread = 3, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "energy strike", interval = 2000, chance = 10, minDamage = -250, maxDamage = -300, range = 1, target = false },
	{ name = "demon paralyze", interval = 2000, chance = 16, range = 7, target = false },
}

monster.defenses = {
	defense = 43,
	armor = 33,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 180, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 12, speedChange = 500, effect = CONST_ME_MAGIC_RED, target = false, duration = 2000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 50 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
