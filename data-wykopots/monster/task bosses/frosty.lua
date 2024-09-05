local mType = Game.createMonsterType("Frosty")
local monster = {}

monster.description = "a frosty"
monster.experience = 7100
monster.outfit = {
	lookType = 248,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 6800
monster.maxHealth = 6800
monster.race = "undead"
monster.corpse = 7091
monster.speed = 145
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 200,
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
	{ text = "YOU WILL FREEZE!", yell = true },
	{ text = "ZCHHHHH!", yell = true },
	{ text = "I am so cool", yell = false },
	{ text = "Chill out!.", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 95000, minCount = 8, maxCount = 12 },
	{ id = 9661, chance = 95500 },
	{ id = 829, chance = 76500 },
	{ id = 762, chance = 87020, maxCount = 40 },
	{ id = 3029, chance = 35400, maxCount = 4 },
	{ id = 7441, chance = 64000, maxCount = 3 },
	{ id = 3051, chance = 25000 },
	{ id = 7290, chance = 95550 },
	{ id = 3061, chance = 75580 },
	{ id = 3386, chance = 910 },
	{ id = 3373, chance = 450 },
	{ id = 3392, chance = 2200 },
	{ id = 3428, chance = 32000 },
	{ id = 7402, chance = 9000 },
	{ id = 3284, chance = 35000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 78, attack = 60 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -175, maxDamage = -380, length = 8, spread = 4, effect = CONST_ME_POFF, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -50, maxDamage = -450, radius = 5, effect = CONST_ME_ICEATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_ICEDAMAGE, minDamage = -10, maxDamage = -240, radius = 3, effect = CONST_ME_ICEAREA, target = true },
	{ name = "frost dragon paralyze 1", interval = 2000, chance = 15, target = false },
}

monster.defenses = {
	defense = 37,
	armor = 29,
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 12, speedChange = 360, effect = CONST_ME_MAGIC_RED, target = false, duration = 3000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 7 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
