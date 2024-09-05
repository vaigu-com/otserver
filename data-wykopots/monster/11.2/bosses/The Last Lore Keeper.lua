local mType = Game.createMonsterType("The Last Lore Keeper")
local monster = {}

monster.description = "The Last Lore Keeper"
monster.experience = 45000
monster.outfit = {
	lookType = 939,
	lookHead = 0,
	lookBody = 98,
	lookLegs = 86,
	lookFeet = 94,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 55000
monster.maxHealth = 55000
monster.race = "undead"
monster.corpse = 6068
monster.speed = 200
monster.manaCost = 0

monster.changeTarget = {
	interval = 10000,
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
	staticAttackChance = 98,
	targetDistance = 1,
	runHealth = 0,
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

monster.summon = {
	maxSummons = 5,
	summons = {
		{ name = "Sword Of Vengeance", chance = 100, interval = 3000, count = 3 },
		{ name = "Sword Of Vengeance", chance = 100, interval = 7000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "This place is sacred!", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "platinum coin", chance = 21790, maxCount = 15 },
	{ id = 16119, chance = 9660, maxCount = 5 },
	{ id = 16120, chance = 9660, maxCount = 5 },
	{ id = 3032, chance = 9660, maxCount = 5 },
	{ id = 22721, chance = 5 },
	{ id = 23375, chance = 10000, maxCount = 5 },
	{ id = 5880, chance = 10000, maxCount = 5 },
	{ id = 7642, chance = 18250, maxCount = 3 },
	{ id = 5999, chance = 5909, maxCount = 2 },
	{ id = 9632, chance = 20000 },
	{ id = 20079, chance = 16000 },
	{ id = 281, chance = 7000 },
	{ id = 3360, chance = 20000 },
	{ id = 9660, chance = 60000 },
	{ id = 22193, chance = 16033 },
	{ id = 24942, chance = 6000 },
	{ id = 5887, chance = 6000 },
	{ id = 23534, chance = 6000 },
	{ id = 3324, chance = 6000 },
	{ id = 3037, chance = 5000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -999, maxDamage = -1000 },
	{ name = "combat", interval = 1000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -600, maxDamage = -900, radius = 7, effect = CONST_ME_POISONAREA, target = false },
	{ name = "poisonfield", interval = 2000, chance = 10, range = 7, radius = 4, shootEffect = CONST_ANI_EARTH, target = true },
	{ name = "combat", interval = 3000, chance = 35, type = COMBAT_ENERGYDAMAGE, minDamage = 0, maxDamage = -1600, range = 7, radius = 7, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "energyfield", interval = 2000, chance = 10, range = 7, radius = 4, shootEffect = CONST_ANI_ENERGY, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_HEALING, minDamage = 300, maxDamage = 800, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
