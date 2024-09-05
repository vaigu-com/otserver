local mType = Game.createMonsterType("Dwarf Henchman")
local monster = {}

monster.description = "a dwarf henchman"
monster.experience = 15
monster.outfit = {
	lookType = 160,
	lookHead = 115,
	lookBody = 77,
	lookLegs = 112,
	lookFeet = 114,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 350
monster.maxHealth = 350
monster.race = "blood"
monster.corpse = 6007
monster.speed = 85
monster.manaCost = 0

monster.changeTarget = {
	interval = 0,
	chance = 0,
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
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "This place is for our eyes only!", yell = false },
	{ text = "We will live and let you die!", yell = false },
	{ text = "I will die another day!", yell = false },
	{ text = "We have license to kill!", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -50, condition = { type = CONDITION_POISON, totalDamage = 4, interval = 4000 } },
	-- drown
	{ name = "condition", type = CONDITION_DROWN, interval = 2000, chance = 20, target = true },
}

monster.defenses = {
	defense = 10,
	armor = 8,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
