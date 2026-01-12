local mType = Game.createMonsterType("Cult Scholar")
local monster = {}

monster.description = "a cult scholar"
monster.experience = 1100
monster.outfit = {
	lookType = 145,
	lookHead = 19,
	lookBody = 77,
	lookLegs = 3,
	lookFeet = 20,
	lookAddons = 1,
	lookMount = 0,
}

monster.events = {}

monster.raceId = 1514
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 1,
	Locations = "Forbidden Temple (Carlin).",
}

monster.health = 1650
monster.maxHealth = 1650
monster.race = "blood"
monster.corpse = 22017
monster.speed = 130
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20,
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
	canPushCreatures = false,
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
	maxSummons = 2,
	summons = {
		{ name = "skeleton mage", chance = 20, interval = 2000, count = 1 },
	},
}
monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "The Secrets are ours alone!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 50000, maxCount = 5 },
	{ id = 3031, chance = 75410, maxCount = 30 }, -- gold coin
	{ id = 3592, chance = 15400 }, -- grapes
	{ id = 3577, chance = 5000 }, -- meat
	{ id = 3563, chance = 760 }, -- green tunic
	{ id = 3048, chance = 3700 }, -- might ring
	{ id = 3028, chance = 8830 }, -- small diamond
	{ id = 12669, chance = 900 }, -- star ring
	{ id = 3014, chance = 200 }, -- star amulet
	{ name = "cultish robe", chance = 11720 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -380 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -175, maxDamage = -200, range = 1, shootEffect = CONST_ANI_DEATH, target = false },
	{ name = "melee", interval = 2000, chance = 10, minDamage = 0, maxDamage = -220, condition = { type = CONDITION_POISON, totalDamage = 180, interval = 4000 } },
}

monster.defenses = {
	defense = 50,
	armor = 30,
	mitigation = 1.18,
	{ name = "combat", interval = 4000, chance = 25, type = COMBAT_HEALING, minDamage = 20, maxDamage = 80, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
