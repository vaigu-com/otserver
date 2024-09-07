local mType = Game.createMonsterType("Petrus Ciemiezca")
local monster = {}

monster.description = "a Petrus Ciemiezca"
monster.experience = 3717
monster.outfit = {
	lookType = 130,
	lookHead = 77,
	lookBody = 123,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 1,
	lookMount = 0,
}

monster.health = 1500
monster.maxHealth = 1500
monster.race = "blood"
monster.corpse = 18246
monster.speed = 230
monster.manaCost = 0

monster.changeTarget = {
	interval = 3717,
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
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 100,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {
	"petrusDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 1,
	summons = {
		{ name = "energy elemental", chance = 10, interval = 2000, count = 1 },
	},
}

monster.voices = {}

monster.loot = {
	{ name = "red tome", chance = 300 },
	{ name = "candlestick", chance = 21465 },
	{ name = "piggy bank", chance = 60 },
	{ name = "small sapphire", chance = 1435 },
	{ name = "gold coin", chance = 29340, maxCount = 80 },
	{ name = "talon", chance = 1395 },
	{ name = "stone skin amulet", chance = 330 },
	{ name = "poison dagger", chance = 248 },
	{ name = "cherry", chance = 16720, maxCount = 4 },
	{ name = "bread", chance = 8172 },
	{ name = "dark mushroom", chance = 4181 },
	{ name = "assassin star", chance = 1589, maxCount = 4 },
	{ name = "assassin star", chance = 1559, maxCount = 4 },
	{ name = "great mana potion", chance = 4749 },
	{ name = "great health potion", chance = 5189 },
	{ name = "lightning robe", chance = 1000 },
	{ name = "luminous orb", chance = 510 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -10 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_ENERGYDAMAGE, minDamage = -90, maxDamage = -110, range = 7, shootEffect = CONST_ANI_ENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -60, range = 7, target = false },
	{ name = "energyfield", interval = 2000, chance = 30, range = 7, radius = 2, shootEffect = CONST_ANI_ENERGY, target = true },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -50, maxDamage = -130, length = 8, spread = 3, effect = CONST_ME_BIGCLOUDS, target = false },
	{ name = "speed", interval = 2000, chance = 25, speedChange = -600, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 17720 },
}

monster.defenses = {
	defense = 20,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 80, type = COMBAT_HEALING, minDamage = 20, maxDamage = 50, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
