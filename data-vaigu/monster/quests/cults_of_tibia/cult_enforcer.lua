local mType = Game.createMonsterType("Cult Enforcer")
local monster = {}

monster.description = "a cult enforcer"
monster.experience = 1000
monster.outfit = {
	lookType = 134,
	lookHead = 95,
	lookBody = 19,
	lookLegs = 57,
	lookFeet = 76,
	lookAddons = 1,
	lookMount = 0,
}

monster.events = {}

monster.raceId = 1513
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Forbidden Temple (Carlin).",
}

monster.health = 1150
monster.maxHealth = 1150
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "No one will stop us!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 50000, maxCount = 3 },
	{ id = 3031, chance = 75410, maxCount = 90 }, -- gold coin
	{ id = 3592, chance = 15400 }, -- grapes
	{ id = 239, chance = 12340, maxCount = 2 }, -- great health potion
	{ id = 3577, chance = 5000 }, -- meat
	{ id = 3349, chance = 830 }, -- crossbow
	{ id = 3563, chance = 760 }, -- green tunic
	{ id = 3048, chance = 900 }, -- might ring
	{ id = 3028, chance = 830 }, -- small diamond
	{ id = 3279, chance = 3130 }, -- war hammer
	{ id = 3269, chance = 2830 }, -- halberd
	{ id = 3415, chance = 330 }, -- guardian shield
	{ id = 3371, chance = 230 }, -- knight legs
	{ id = 3369, chance = 200 }, -- warrior helmet
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -360 },
}

monster.defenses = {
	defense = 50,
	armor = 30,
	mitigation = 1.24,
	{ name = "combat", interval = 4000, chance = 25, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
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
