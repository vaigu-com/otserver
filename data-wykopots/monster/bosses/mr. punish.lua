local mType = Game.createMonsterType("Mr. Punish")
local monster = {}

monster.description = "a mr. punish"
monster.experience = 5500
monster.outfit = {
	lookType = 234,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 12000
monster.maxHealth = 12000
monster.race = "undead"
monster.corpse = 6330
monster.speed = 235
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
	canPushCreatures = false,
	staticAttackChance = 50,
	targetDistance = 1,
	runHealth = 2000,
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
}

monster.loot = {
	{ id = 6537, chance = 100000 },
	{ name = "gold coin", chance = 100000 },
	{ id = 6499, chance = 92000 },
	{ name = "soul orb", chance = 92000 },
	{ name = "double axe", chance = 23000 },
	{ name = "jewelled backpack", chance = 23000 },
	{ name = "assassin star", chance = 15000, maxCount = 20 },
	{ name = "gold ingot", chance = 15000 },
	{ name = "great health potion", chance = 15000 },
	{ name = "platinum coin", chance = 15000, maxCount = 5 },
	{ id = 6491, chance = 8000 },
	{ name = "cat's paw", chance = 8000 },
	{ name = "great mana potion", chance = 8000 },
	{ name = "ravager's axe", chance = 8000 },
	{ name = "small diamond", chance = 8000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -660, maxDamage = -1280 },
}

monster.defenses = {
	defense = 72,
	armor = 64,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
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
