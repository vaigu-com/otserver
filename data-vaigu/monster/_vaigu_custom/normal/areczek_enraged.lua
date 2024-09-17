local mType = Game.createMonsterType("Areczek")
local monster = {}

monster.name = "Areczek"
monster.description = "an Areczek"
monster.experience = 9900
monster.outfit = {
	lookType = 1042,
	lookHead = 0,
	lookBody = 97,
	lookLegs = 37,
	lookFeet = 115,
	lookAddons = 3,
	lookMount = 0,
}

monster.raceId = 2585
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 50,
	Stars = 5,
	Occurrence = 0,
	Locations = "Areczek is your usual Januszex inhabitant.",
}

monster.health = 7500
monster.maxHealth = 7500
monster.speed = 250

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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 0,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {
	"AreczekEnragedDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 0,
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700, effect = CONST_ME_DRAWBLOOD },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -400, range = 7, shootEffect = CONST_ANI_BURSTARROW, target = true },
	{ name = "combat", interval = 6000, chance = 22, type = COMBAT_HOLYDAMAGE, minDamage = -200, maxDamage = -900, range = 7, radius = 4, effect = CONST_ME_HOLYAREA, target = true },
	{ name = "combat", interval = 4000, chance = 12, type = COMBAT_HOLYDAMAGE, minDamage = -400, maxDamage = -900, range = 7, effect = CONST_ME_HOLYDAMAGE, target = true },
	{ name = "combat", interval = 4000, chance = 17, type = COMBAT_ICEDAMAGE, minDamage = -400, maxDamage = -900, radius = 4, effect = CONST_ME_ICEAREA, target = false },
}

monster.defenses = {
	defense = 86,
	armor = 86,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
