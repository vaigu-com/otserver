local mType = Game.createMonsterType("General Murius")
local monster = {}

monster.description = "General Murius"
monster.experience = 450
monster.outfit = {
	lookType = 611,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 15500
monster.maxHealth = 15500
monster.race = "blood"
monster.corpse = 21091
monster.speed = 105
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5,
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
	maxSummons = 4,
	summons = {
		{ name = "Minotaur Archer", chance = 14, interval = 2000, count = 4 },
		{ name = "Minotaur Guard", chance = 11, interval = 2000, count = 4 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Feel the power of the Mooh'Tah!", yell = false },
	{ text = "You will get what you deserve!", yell = false },
	{ text = "For the king!", yell = false },
	{ text = "Guards!", yell = false },
}

monster.loot = {
	{ name = "golden raid token", chance = 100000 },
	{ name = "gold coin", chance = 80000, maxCount = 90 },
	{ name = "platinum coin", chance = 80000, maxCount = 3 },
	{ id = 5878, chance = 100000 },
	{ id = 11472, chance = 100000 },
	{ id = 7401, chance = 40000 },
	{ id = 3413, chance = 40000 },
	{ id = 3359, chance = 60000 },
	{ id = 3558, chance = 40000 },
	{ id = 3275, chance = 60000 },
	{ id = 7363, chance = 40000, maxCount = 7 },
	{ id = 3450, chance = 30000, maxCount = 7 },
	{ id = 3577, chance = 20000 },
	{ id = 236, chance = 20000 },
	{ id = 3396, chance = 25000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 70, attack = 55 },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -85, range = 7, shootEffect = CONST_ANI_BOLT, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -65, radius = 3, effect = CONST_ME_HITAREA, target = false },
}

monster.defenses = {
	defense = 52,
	armor = 26,
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_HEALING, minDamage = 25, maxDamage = 750, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 6, speedChange = 410, effect = CONST_ME_MAGIC_RED, target = false, duration = 8000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
