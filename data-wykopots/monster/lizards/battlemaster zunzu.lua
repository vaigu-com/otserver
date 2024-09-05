local mType = Game.createMonsterType("Battlemaster Zunzu")
local monster = {}

monster.description = "a battlemaster zunzu"
monster.experience = 6500
monster.outfit = {
	lookType = 343,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 5000
monster.maxHealth = 5000
monster.race = "blood"
monster.corpse = 10364
monster.speed = 210
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 150,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "silver raid token", chance = 100000, minCount = 3, maxCount = 5 },
	{ name = "platinum coin", chance = 89000, maxCount = 9 },
	{ id = 10289, chance = 100000 },
	{ id = 10414, chance = 100000 },
	{ id = 10386, chance = 20150 },
	{ id = 10413, chance = 11250 },
	{ id = 236, chance = 2875, maxCount = 2 },
	{ id = 5881, chance = 8000 },
	{ name = "great health potion", chance = 2775, maxCount = 2 },
	{ id = 10387, chance = 3625 },
	{ id = 5876, chance = 18025 },
	{ id = 10384, chance = 2050 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 65, attack = 80 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -115, maxDamage = -350, range = 1, radius = 1, effect = CONST_ME_POISONAREA, target = true },
}

monster.defenses = {
	defense = 35,
	armor = 45,
	{ name = "combat", interval = 1000, chance = 18, type = COMBAT_HEALING, minDamage = 200, maxDamage = 400, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
