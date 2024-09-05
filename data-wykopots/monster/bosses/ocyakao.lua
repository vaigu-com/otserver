local mType = Game.createMonsterType("Ocyakao")
local monster = {}

monster.description = "Ocyakao"
monster.experience = 490
monster.outfit = {
	lookType = 259,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 700
monster.maxHealth = 700
monster.race = "blood"
monster.corpse = 7320
monster.speed = 88
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 4,
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
	canPushCreatures = false,
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
	{ text = "Chiqui!", yell = false },
	{ text = "Quatu nguraka!", yell = false },
	{ text = "Jinuma jamjam!", yell = false },
	{ text = "Chikuva!", yell = false },
	{ text = "Kiyosa sipaju!", yell = false },
	{ text = "Suvituka siq chuqua!", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 100000 },
	{ name = "gold coin", chance = 100000, minCount = 65, maxCount = 65 },
	{ id = 3578, chance = 100000, maxCount = 5 },
	{ id = 3286, chance = 25000 },
	{ id = 3026, chance = 100000 },
	{ id = 5909, chance = 100000 },
	{ id = 3441, chance = 25000 },
	{ id = 7381, chance = 12000 },
	{ id = 7441, chance = 100000 },
	{ id = 19369, chance = 15000 },
	{ id = 3580, chance = 115000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 58, attack = 50 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -70, range = 7, radius = 1, shootEffect = CONST_ANI_SMALLSTONE, effect = CONST_ME_STUN, target = true },
	-- bleed
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 30, minDamage = -160, maxDamage = -160, range = 7, radius = 7, shootEffect = CONST_ANI_SNOWBALL, effect = CONST_ME_ICEATTACK, target = true },
	{ name = "effect", interval = 2000, chance = 30, range = 7, radius = 7, shootEffect = CONST_ANI_SNOWBALL, effect = CONST_ME_ICEAREA, target = true },
}

monster.defenses = {
	defense = 30,
	armor = 30,
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_HEALING, minDamage = 50, maxDamage = 60, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
