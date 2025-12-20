local mType = Game.createMonsterType("Rotspit")
local monster = {}

monster.description = "a rotspit"
monster.experience = 9100
monster.outfit = {
	lookType = 461,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 854,
	bossRace = RARITY_BANE,
}

monster.health = 6800
monster.maxHealth = 6800
monster.race = "venom"
monster.corpse = 13979
monster.speed = 135
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 40,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Spotz!", yell = false },
}

monster.loot = {
	{ name = "small amethyst", chance = 8000, maxCount = 2 },
	{ name = "platinum coin", chance = 75250 },
	{ name = "green gem", chance = 210 },
	{ id = 3053, chance = 2400 }, -- time ring
	{ id = 22721, chance = 2500 },
	{ name = "platinum amulet", chance = 1260 },
	{ name = "crusader helmet", chance = 8230 },
	{ name = "brown mushroom", chance = 71500, maxCount = 3 },
	{ name = "mastermind potion", chance = 4310 },
	{ name = "crystal sword", chance = 2000 },
	{ name = "great mana potion", chance = 80000 },
	{ name = "great health potion", chance = 50000 },
	{ name = "spitter nose", chance = 38000 },
	{ name = "compound eye", chance = 35000 },
	{ name = "calopteryx cape", chance = 540 },
	{ name = "grasshopper legs", chance = 930 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -250, condition = { type = CONDITION_POISON, totalDamage = 240, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -500, range = 7, radius = 3, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -600, range = 7, shootEffect = CONST_ANI_POISON, target = true, duration = 15000 },
}

monster.defenses = {
	defense = 20,
	armor = 48,
	mitigation = 1.60,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 400, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 25 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
