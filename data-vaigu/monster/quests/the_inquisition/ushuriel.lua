local mType = Game.createMonsterType("Ushuriel")
local monster = {}

monster.description = "Ushuriel"
monster.experience = 100000
monster.outfit = {
	lookType = 12,
	lookHead = 0,
	lookBody = 57,
	lookLegs = 0,
	lookFeet = 80,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
	"InquisitionBossDeath",
}

monster.health = 31500
monster.maxHealth = 31500
monster.race = "fire"
monster.corpse = 6068
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.bosstiary = {
	bossRaceId = 415,
	bossRace = RARITY_BANE,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
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
	staticAttackChance = 85,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You can't run or hide forever!", yell = false },
	{ text = "I'm the executioner of the Seven!", yell = false },
	{ text = "The final punishment awaits you!", yell = false },
	{ text = "The judgement is guilty! The sentence is death!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 20000, maxCount = 46 },
	{ name = "orb", chance = 16666 },
	{ name = "life crystal", chance = 86666 },
	{ name = "royal helmet", chance = 20000 },
	{ name = "brown mushroom", chance = 50000, maxCount = 50 },
	{ name = "mysterious voodoo skull", chance = 32500 },
	{ name = "skull helmet", chance = 20000 },
	{ name = "iron ore", chance = 33333 },
	{ id = 5884, chance = 4761 }, -- spirit container
	{ name = "flask of warrior's sweat", chance = 55555 },
	{ name = "enchanted chicken wing", chance = 17692 },
	{ name = "huge chunk of crude iron", chance = 14285 },
	{ name = "hardened bone", chance = 25000, maxCount = 20 },
	{ name = "demon horn", chance = 8333, maxCount = 2 },
	{ id = 6103, chance = 12063 }, -- unholy book
	{ name = "demonic essence", chance = 100000 },
	{ name = "thaian sword", chance = 25000 },
	{ name = "runed sword", chance = 16666 },
	{ name = "gold ingot", chance = 16666 },
	{ id = 29415, chance = 14761 },
	{ id = 36730, chance = 23264 },
	{ id = 7455, chance = 3454 },
	{ id = 12308, chance = 2761 },
	
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1088 },
	{ name = "combat", interval = 1000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -500, length = 10, spread = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 1000, chance = 8, type = COMBAT_DEATHDAMAGE, minDamage = -30, maxDamage = -760, radius = 5, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -585, length = 8, spread = 3, effect = CONST_ME_SMALLPLANTS, target = false },
	{ name = "combat", interval = 1000, chance = 8, type = COMBAT_ICEDAMAGE, minDamage = 0, maxDamage = -430, radius = 6, effect = CONST_ME_ICETORNADO, target = false },
	{ name = "drunk", interval = 3000, chance = 11, radius = 6, effect = CONST_ME_SOUND_PURPLE, target = false },
	-- energy damage
	{ name = "condition", type = CONDITION_ENERGY, interval = 2000, chance = 15, minDamage = -250, maxDamage = -250, radius = 4, effect = CONST_ME_ENERGYHIT, target = false },
}

monster.defenses = {
	defense = 45,
	armor = 50,
	{ name = "combat", interval = 1000, chance = 12, type = COMBAT_HEALING, minDamage = 400, maxDamage = 600, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "speed", interval = 1000, chance = 4, speedChange = 400, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 7000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
