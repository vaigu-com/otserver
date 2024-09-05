local mType = Game.createMonsterType("Armadile")
local monster = {}

monster.description = "a armadile"
monster.experience = 2900
monster.outfit = {
	lookType = 487,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 880
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Warzone 1.",
}

monster.health = 3800
monster.maxHealth = 3800
monster.race = "undead"
monster.corpse = 15868
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 8,
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
	targetDistance = 4,
	runHealth = 300,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Creak!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "platinum coin", chance = 95000, maxCount = 7 },
	{ id = 268, chance = 14285, maxCount = 3 },
	{ name = "great health potion", chance = 15000, maxCount = 2 },
	{ id = 236, chance = 14285, maxCount = 2 },
	{ id = 16138, chance = 14540 },
	{ name = "great mana potion", chance = 15920, maxCount = 2 },
	{ id = 237, chance = 15000, maxCount = 2 },
	{ id = 11447, chance = 12460 },
	{ id = 16143, chance = 10230, maxCount = 10 },
	{ id = 16142, chance = 7692, maxCount = 5 },
	{ id = 12600, chance = 6500 },
	{ id = 16127, chance = 6010, maxCount = 2 },
	{ id = 16122, chance = 3920, maxCount = 2 },
	{ id = 813, chance = 2280 },
	{ id = 7413, chance = 2130 },
	{ id = 7428, chance = 900 },
	{ id = 3053, chance = 1900 },
	{ id = 3428, chance = 1120 },
	{ id = 8050, chance = 450 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 50 },
	{ name = "drunk", interval = 2000, chance = 15, radius = 4, effect = CONST_ME_FIREAREA, target = true, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -430, maxDamage = -550, range = 7, effect = CONST_ME_MAGIC_BLUE, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -200, maxDamage = -400, radius = 4, effect = CONST_ME_POISONAREA, target = false },
}

monster.defenses = {
	defense = 66,
	armor = 66,
	{ name = "invisible", interval = 2000, chance = 15, duration = 5000, effect = CONST_ME_MAGIC_RED },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 1 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 1 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
