local mType = Game.createMonsterType("Zamulosh")
local monster = {}

monster.description = "a zamulosh"
monster.experience = 30000
monster.outfit = {
	lookType = 862,
	lookHead = 17,
	lookBody = 12,
	lookLegs = 73,
	lookFeet = 92,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1181,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 250000
monster.maxHealth = 250000
monster.race = "undead"
monster.corpse = 22495
monster.speed = 262
monster.manaCost = 200

monster.changeTarget = {
	interval = 4000,
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
	staticAttackChance = 60,
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
	"ZamuloshDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 5,
	summons = {
		{ name = "Zamulosh Summom", chance = 25, interval = 1000, count = 5 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I AM ZAMULOSH!", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 9000, maxCount = 200 },
	{ name = "platinum coin", chance = 99000, maxCount = 25 },
	{ id = 22516, chance = 99900 },
	{ id = 22755, chance = 500 },
	{ id = 10438, chance = 6000 },
	{ id = 22867, chance = 3500 },
	{ id = 22726, chance = 3500 },
	{ id = 8050, chance = 9000 },
	{ id = 3333, chance = 20000 },
	{ id = 22762, chance = 500 },
	{ id = 3053, chance = 25000 },
	{ id = 3049, chance = 9000 },
	{ id = 3098, chance = 9000 },
	{ name = "demonic essence", chance = 9000 },
	{ id = 3037, chance = 15000 },
	{ id = 3038, chance = 12000 },
	{ id = 3041, chance = 10500 },
	{ id = 3030, chance = 28500, maxCount = 5 },
	{ id = 3029, chance = 29500, maxCount = 5 },
	{ id = 3033, chance = 29500, maxCount = 5 },
	{ id = 7643, chance = 58500, maxCount = 10 },
	{ name = "great mana potion", chance = 59500, maxCount = 10 },
	{ id = 7642, chance = 59500, maxCount = 10 },
	{ id = 16122, chance = 17500, maxCount = 6 },
	{ id = 16123, chance = 13500, maxCount = 6 },
	{ id = 16124, chance = 17500, maxCount = 6 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 100, attack = 90 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -1000, length = 8, spread = 0, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -450, radius = 6, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -550, length = 8, spread = 3, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 160,
	armor = 160,
	{ name = "invisible", interval = 1000, chance = 23, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
