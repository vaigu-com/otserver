local mType = Game.createMonsterType("Darkfang")
local monster = {}

monster.description = "a darkfang"
monster.experience = 4000
monster.outfit = {
	lookType = 308,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1558,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 4800
monster.maxHealth = 4800
monster.race = "blood"
monster.corpse = 18099
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
	maxSummons = 2,
	summons = {
		{ name = "Gloom Wolf", chance = 20, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "The ferocity of wolves will frighten the fearful! Roarrr!", yell = false },
	{ text = "You are my next meal! Grrr!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 120 },
	{ name = "platinum coin", chance = 100000, maxCount = 10 },
	{ name = "berserk potion", chance = 80000, maxCount = 2 },
	{ name = "black pearl", chance = 80000, maxCount = 5 },
	{ name = "onyx chip", chance = 85000, maxCount = 5 },
	{ name = "small enchanted sapphire", chance = 75000, maxCount = 2 },
	{ name = "ultimate health potion", chance = 100000, maxCount = 2 },
	{ name = "platinum amulet", chance = 4500 },
	{ name = "stone skin amulet", chance = 22000 },
	{ id = 3053, chance = 5200 },
	{ name = "troll green", chance = 25000 },
	{ name = "werewolf fur", chance = 100000 },
	{ name = "werewolf fangs", chance = 100000 },
	{ name = "wolf paw", chance = 100000, maxCount = 2 },
	{ name = "bonebreaker", chance = 11000 },
	{ name = "dreaded cleaver", chance = 8000 },
	{ name = "werewolf amulet", chance = 3600 },
	{ name = "sai", chance = 3600 },
	{ id = 7394, chance = 8000 },
	{ name = "silver token", chance = 3200 },
	{ name = "wolf backpack", chance = 400 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -290 },
	{ name = "werewolf skill reducer", interval = 2000, chance = 15, range = 1, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -300, radius = 8, effect = CONST_ME_SOUND_RED, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = 200, maxDamage = 340, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -600, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
}

monster.defenses = {
	defense = 45,
	armor = 40,
	{ name = "combat", interval = 4000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 345, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
