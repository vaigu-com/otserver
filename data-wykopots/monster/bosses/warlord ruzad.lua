local mType = Game.createMonsterType("Warlord Ruzad")
local monster = {}

monster.description = "the warlord ruzad"
monster.experience = 1700
monster.outfit = {
	lookType = 2,
	lookHead = 20,
	lookBody = 30,
	lookLegs = 40,
	lookFeet = 50,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 1950
monster.maxHealth = 1950
monster.race = "blood"
monster.corpse = 6008
monster.speed = 135
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	maxSummons = 3,
	summons = {
		{ name = "Orc Berserker", chance = 30, interval = 2000, count = 3 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "gold coin", chance = 50000, maxCount = 59 },
	{ id = 3577, chance = 20000, maxCount = 3 },
	{ id = 3578, chance = 6667 },
	{ id = 3280, chance = 8970 },
	{ id = 3357, chance = 7333 },
	{ id = 3287, chance = 6666, maxCount = 18 },
	{ id = 3316, chance = 13000 },
	{ id = 3372, chance = 3333 },
	{ id = 3084, chance = 9000 },
	{ id = 3265, chance = 18180 },
	{ id = 3391, chance = 6670 },
	{ id = 3063, chance = 5506 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 65, attack = 80 },
}

monster.defenses = {
	defense = 35,
	armor = 32,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 80 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
