local mType = Game.createMonsterType("Bullwark")
local monster = {}

monster.description = "Bullwark"
monster.experience = 16725
monster.outfit = {
	lookType = 607,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 65000
monster.maxHealth = 65000
monster.race = "blood"
monster.corpse = 5962
monster.speed = 110
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
		{ name = "Moohtant", chance = 10, interval = 2000, count = 4 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "MOOOOH!", yell = false },
	{ text = "Grrrr.", yell = false },
	{ text = "Raaaargh!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 195 },
	{ name = "platinum coin", chance = 58000, maxCount = 2 },
	{ name = "great health potion", chance = 7300, maxCount = 3 },
	{ name = "great mana potion", chance = 7300, maxCount = 3 },
	{ id = 3577, chance = 6400 },
	{ id = 3030, chance = 4600, maxCount = 2 },
	{ id = 5878, chance = 4200 },
	{ id = 3028, chance = 4000, maxCount = 2 },
	{ id = 3098, chance = 2000 },
	{ id = 5911, chance = 1700 },
	{ id = 3039, chance = 880 },
	{ id = 3037, chance = 730 },
	{ id = 7452, chance = 440 },
	{ id = 7427, chance = 290 },
	{ name = "gold ingot", chance = 290 },
	{ id = 7401, chance = 290 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1300 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -200, radius = 3, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -225, range = 7, radius = 4, effect = CONST_ME_MAGIC_RED, target = true },
}

monster.defenses = {
	defense = 45,
	armor = 40,
	{ name = "combat", interval = 4000, chance = 15, type = COMBAT_HEALING, minDamage = 2000, maxDamage = 4000, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 1 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 1 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 1 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 1 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
