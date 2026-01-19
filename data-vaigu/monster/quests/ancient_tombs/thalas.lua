local mType = Game.createMonsterType("Thalas")
local monster = {}

monster.description = "Thalas"
monster.experience = 12950
monster.outfit = {
	lookType = 89,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 4100
monster.maxHealth = 4100
monster.race = "undead"
monster.corpse = 6025
monster.speed = 210
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.bosstiary = {
	bossRaceId = 89,
	bossRace = RARITY_BANE,
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
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

monster.summon = {
	maxSummons = 8,
	summons = {
		{ name = "Slime", chance = 40, interval = 4000, count = 4 },
		{ name = "Blood Beast", chance = 20, interval = 8000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You will become a feast for my maggots!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 50000, maxCount = 80 },
	{ name = "small emerald", chance = 71000, maxCount = 3 },
	{ name = "green gem", chance = 5800 },
	{ id = 3049, chance = 11500 }, -- stealth ring
	{ id = 3053, chance = 47000 }, -- time ring
	{ name = "cobrafang dagger", chance = 90000 },
	{ name = "serpent sword", chance = 85500 },
	{ name = "poison dagger", chance = 71000 },
	{ name = "djinn blade", chance = 4200 },
	{ name = "great health potion", chance = 91500 },
	{ id = 10290, chance = 8280 }, -- Mini Mummy
	{ id = 8898, chance = 2500 }, -- rusted legs
	{ id = 8907, chance = 2500 }, -- rusted helmet
	{ id = 11701, chance = 12500 },
	{ id = 21955, chance = 1500 },
	{ id = 12669, chance = 12500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -450, range = 6, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false },
	{ name = "melee", interval = 3000, chance = 20, minDamage = -150, maxDamage = -450 },
	{ name = "speed", interval = 1000, chance = 6, speedChange = -800, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 1000, chance = 15, minDamage = -34, maxDamage = -45, radius = 5, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 3000, chance = 17, type = COMBAT_EARTHDAMAGE, minDamage = -55, maxDamage = -350, length = 8, spread = 4, effect = CONST_ME_POISONAREA, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -33 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 80 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
