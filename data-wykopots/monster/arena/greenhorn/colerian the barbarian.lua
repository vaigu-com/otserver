local mType = Game.createMonsterType("Colerian The Barbarian")
local monster = {}

monster.description = "colerian the barbarian"
monster.experience = 90
monster.outfit = {
	lookType = 253,
	lookHead = 76,
	lookBody = 115,
	lookLegs = 115,
	lookFeet = 43,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 265
monster.maxHealth = 265
monster.race = "blood"
monster.corpse = 0
monster.speed = 95
monster.manaCost = 0

monster.changeTarget = {
	interval = 0,
	chance = 0,
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
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.events = {
	"ArenaMonsterDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Flee, coward!", yell = false },
	{ text = "You will lose!", yell = false },
	{ text = "Yeehaawh", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 20, attack = 40 },
	{ name = "combat", interval = 2000, chance = 80, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -40, range = 5, radius = 1, shootEffect = CONST_ANI_PIERCINGBOLT, target = true },
}

monster.defenses = {
	defense = 20,
	armor = 19,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -20 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
