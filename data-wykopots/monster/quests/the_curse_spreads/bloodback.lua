local mType = Game.createMonsterType("Bloodback")
local monster = {}

monster.description = "a Bloodback"
monster.experience = 4000
monster.outfit = {
	lookType = 1039,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1560,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 5200
monster.maxHealth = 5200
monster.race = "blood"
monster.corpse = 27718
monster.speed = 125
monster.manaCost = 0

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

monster.events = {
	"WereBossDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 1,
	summons = {
		{ name = "Wereboar", chance = 20, interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You will DIE!", yell = false },
	{ text = "The ruthlessness of boars will stamp down the careless!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 70000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 10 },
	{ name = "great health potion", chance = 16000, maxCount = 10 },
	{ name = "red crystal fragment", chance = 18000, maxCount = 2 },
	{ name = "small enchanted ruby", chance = 50000, maxCount = 3 },
	{ name = "furry club", chance = 25000 },
	{ id = 3039, chance = 20000 },
	{ name = "spiked squelcher", chance = 4500 },
	{ name = "stone skin amulet", chance = 19000 },
	{ name = "wereboar hooves", chance = 100000, maxCount = 2 },
	{ name = "wereboar loincloth", chance = 30000, maxCount = 2 },
	{ name = "wereboar tusks", chance = 100000, maxCount = 2 },
	{ name = "werewolf amulet", chance = 3000 },
	{ name = "dreaded cleaver", chance = 5600 },
	{ name = "fur armor", chance = 5200 },
	{ name = "fur boots", chance = 410 },
	{ id = 22102, chance = 2800 },
	{ name = "silver token", chance = 2500 },
	{ name = "wolf backpack", chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -290 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -100, maxDamage = -420, range = 7, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -600, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -200, length = 5, spread = 0, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 45,
	armor = 40,
	{ name = "combat", interval = 4000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 345, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 85 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
