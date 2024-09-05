local mType = Game.createMonsterType("Hideous Fungus")
local monster = {}

monster.description = "a hideous fungus"
monster.experience = 2900
monster.outfit = {
	lookType = 499,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 891
monster.Bestiary = {
	class = "Plant",
	race = BESTY_RACE_PLANT,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Warzone 1, Rathleton Sewers, unreachable location in Tiquanda Laboratory.",
}

monster.health = 4600
monster.maxHealth = 4600
monster.race = "venom"
monster.corpse = 16083
monster.speed = 170
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
	targetDistance = 4,
	runHealth = 275,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "humorless fungus", chance = 10, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Munch munch munch!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "platinum coin", chance = 100000, maxCount = 7 },
	{ id = 16140, chance = 14285 },
	{ id = 16143, chance = 14500, maxCount = 15 },
	{ id = 16103, chance = 14500, maxCount = 3 },
	{ id = 268, chance = 9090 },
	{ name = "great mana potion", chance = 7692 },
	{ name = "great health potion", chance = 7220 },
	{ id = 5909, chance = 6430 },
	{ id = 3279, chance = 4010 },
	{ id = 5912, chance = 3700 },
	{ id = 5910, chance = 3003 },
	{ id = 813, chance = 1600 },
	{ id = 814, chance = 2000 },
	{ id = 5911, chance = 1820 },
	{ id = 812, chance = 920 },
	{ id = 811, chance = 800 },
	{ id = 16117, chance = 660 },
	{ id = 16164, chance = 80 },
	{ id = 16099, chance = 20 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 40, attack = 100, condition = { type = CONDITION_POISON, totalDamage = 600, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -430, range = 7, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_SMALLPLANTS, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -250, maxDamage = -550, length = 8, spread = 3, shootEffect = CONST_ANI_SNOWBALL, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = -600, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 60000 },
	{ name = "drunk", interval = 2000, chance = 10, range = 7, radius = 5, shootEffect = CONST_ANI_SMALLSTONE, effect = CONST_ME_STUN, target = true, duration = 4000 },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -400, maxDamage = -640, range = 7, radius = 3, effect = CONST_ME_HITBYPOISON, target = false },
}

monster.defenses = {
	defense = 60,
	armor = 60,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 275, maxDamage = 350, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 10, duration = 6000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 1 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
