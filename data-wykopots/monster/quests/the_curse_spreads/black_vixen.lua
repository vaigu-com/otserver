local mType = Game.createMonsterType("Black Vixen")
local monster = {}

monster.description = "a black vixen"
monster.experience = 3200
monster.outfit = {
	lookType = 1038,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1559,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 3200
monster.maxHealth = 3200
monster.race = "blood"
monster.corpse = 27714
monster.speed = 100
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
	targetDistance = 3,
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
		{ name = "werefox", chance = 20, interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You are not clever enough to defeat me!", yell = false },
	{ text = "The slyness of foxes will deceive the unwary!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 70000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 10 },
	{ name = "assassin star", chance = 70000, maxCount = 10 },
	{ name = "black pearl", chance = 650000, maxCount = 2 },
	{ name = "great mana potion", chance = 40000, maxCount = 2 },
	{ name = "great spirit potion", chance = 40000, maxCount = 2 },
	{ name = "small enchanted emerald", chance = 15000, maxCount = 2 },
	{ name = "ultimate mana potion", chance = 11000, maxCount = 2 },
	{ name = "ultimate spirit potion", chance = 11000, maxCount = 2 },
	{ name = "fox paw", chance = 100000, maxCount = 2 },
	{ name = "moonlight rod", chance = 6000 },
	{ id = 3049, chance = 7000 }, -- stealth ring
	{ name = "werefox tail", chance = 100000 },
	{ name = "green gem", chance = 20000 },
	{ name = "troll green", chance = 7000 },
	{ name = "werewolf amulet", chance = 3200 },
	{ name = "composite hornbow", chance = 900 },
	{ name = "sai", chance = 8000 },
	{ name = "silver token", chance = 2000 },
	{ id = 27706, chance = 5000 },
	{ name = "foxtail", chance = 100 },
	{ name = "wolf backpack", chance = 100 },
	{ name = "silver token", chance = 2000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -290 },
	{ name = "combat", interval = 1000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 100, maxDamage = 720, range = 7, shootEffect = CONST_ANI_THROWINGSTAR, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -600, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
	{ name = "combat", interval = 1000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -700, length = 5, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "outfit", interval = 1000, chance = 1, radius = 1, target = true, duration = 2000, outfitMonster = "werewolf" },
}

monster.defenses = {
	defense = 45,
	armor = 40,
	{ name = "combat", interval = 4000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 345, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 15, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
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
