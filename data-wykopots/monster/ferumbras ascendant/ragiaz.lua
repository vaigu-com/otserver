local mType = Game.createMonsterType("Ragiaz")
local monster = {}

monster.description = "a ragiaz"
monster.experience = 30000
monster.outfit = {
	lookType = 862,
	lookHead = 0,
	lookBody = 57,
	lookLegs = 76,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1180,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 445000
monster.maxHealth = 445000
monster.race = "undead"
monster.corpse = 22495
monster.speed = 242
monster.manaCost = 200

monster.changeTarget = {
	interval = 2000,
	chance = 10,
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
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.events = {
	"RagiazDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Ragiaz power revives his minion!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 90000, maxCount = 200 },
	{ name = "platinum coin", chance = 99000, maxCount = 30 },
	{ id = 22516, chance = 100000 },
	{ id = 22758, chance = 4000 },
	{ id = 3324, chance = 16000 },
	{ id = 22866, chance = 3500 },
	{ id = 7426, chance = 5000 },
	{ id = 22726, chance = 3500 },
	{ id = 7428, chance = 7500 },
	{ id = 5741, chance = 6500 },
	{ id = 8027, chance = 18500 },
	{ name = "golden legs", chance = 12000 },
	{ id = 7420, chance = 1000 },
	{ id = 3038, chance = 8500 },
	{ id = 3037, chance = 8500 },
	{ id = 3039, chance = 8500 },
	{ id = 3041, chance = 8500 },
	{ id = 3036, chance = 8500 },
	{ id = 3098, chance = 8500 },
	{ name = "demonic essence", chance = 50000 },
	{ id = 281, chance = 9500 },
	{ id = 9057, chance = 9500, maxCount = 5 },
	{ id = 3033, chance = 9500, maxCount = 5 },
	{ id = 3029, chance = 9500, maxCount = 5 },
	{ id = 16126, chance = 4500, maxCount = 6 },
	{ id = 16127, chance = 4500, maxCount = 6 },
	{ id = 16125, chance = 4500, maxCount = 5 },
	{ id = 7643, chance = 85000, maxCount = 10 },
	{ name = "great mana potion", chance = 45000, maxCount = 10 },
	{ id = 7642, chance = 45000, maxCount = 10 },
	{ name = "great health potion", chance = 45000, maxCount = 10 },
	{ name = "flask of demonic blood", chance = 25000, maxCount = 5 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -350, range = 7, radius = 4, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_SMALLCLOUDS, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -1200, length = 10, spread = 3, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -1300, length = 10, spread = 0, effect = CONST_ME_BLOCKHIT, target = false },
	{ name = "effect", interval = 2000, chance = 20, radius = 5, effect = CONST_ME_POFF, target = true },
}

monster.defenses = {
	defense = 160,
	armor = 160,
	{ name = "combat", interval = 3000, chance = 22, type = COMBAT_HEALING, minDamage = 200, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
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
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
