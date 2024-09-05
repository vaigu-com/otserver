local mType = Game.createMonsterType("Swan Maiden")
local monster = {}

monster.description = "a swan maiden"
monster.experience = 700
monster.outfit = {
	lookType = 138,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 114,
	lookFeet = 97,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1437
monster.Bestiary = {
	class = "Fey",
	race = BESTY_RACE_FEY,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 1,
	Locations = "Feyrist Meadows.",
}

monster.health = 800
monster.maxHealth = 800
monster.race = "blood"
monster.corpse = 25831
monster.speed = 117
monster.manaCost = 450

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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 3,
	runHealth = 40,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.light = {
	level = 3,
	color = 143,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Are you stalking me? You will bitterly regret this!", yell = false },
	{ text = "Nightmarish monster! This dream is not meant for you!", yell = false },
	{ text = "You won't steal my robe! Back off!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 59000, maxCount = 112 },
	{ name = "small enchanted emerald", chance = 2450, maxCount = 2 },
	{ name = "green mushroom", chance = 1750 },
	{ name = "white pearl", chance = 1830, maxCount = 2 },
	{ name = "opal", chance = 1890, maxCount = 2 },
	{ name = "strong mana potion", chance = 930 },
	{ name = "clerical mace", chance = 1270 },
	{ name = "great mana potion", chance = 3360 },
	{ name = "colourful snail shell", chance = 15230 },
	{ name = "diamond sceptre", chance = 420 },
	{ name = "coral brooch", chance = 1720 },
	{ name = "flower wreath", chance = 450 },
	{ name = "powder herb", chance = 4770 },
	{ name = "silver brooch", chance = 2990 },
	{ name = "summer dress", chance = 390 },
	{ name = "wild flowers", chance = 20330 },
	{ name = "boots of haste", chance = 520 },
	{ name = "butterfly ring", chance = 420 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -150 },
	{ name = "heavy magic missile rune", interval = 2000, chance = 30, minDamage = -0, maxDamage = -150, range = 7, target = true },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_MANADRAIN, minDamage = -0, maxDamage = -150, range = 5, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "swan maiden paralyze", interval = 3000, chance = 18, target = false },
}

monster.defenses = {
	defense = 54,
	armor = 54,
	{ name = "combat", interval = 2000, chance = 19, type = COMBAT_HEALING, minDamage = 60, maxDamage = 80, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
