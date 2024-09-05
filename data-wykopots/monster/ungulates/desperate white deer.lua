local mType = Game.createMonsterType("Desperate White Deer")
local monster = {}

monster.description = "a desperate white deer"
monster.experience = 35
monster.outfit = {
	lookType = 400,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 195
monster.maxHealth = 195
monster.race = "blood"
monster.corpse = 12524
monster.speed = 112
monster.manaCost = 260

monster.changeTarget = {
	interval = 2000,
	chance = 20,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = false,
	convinceable = false,
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 55,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.events = {
	"WhiteDeerScoutsDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "*wheeze*", yell = false },
	{ text = "ROOOAAARR!!", yell = false },
	{ text = "*sniff*", yell = false },
}

monster.loot = {
	{ name = "ham", chance = 19360, maxCount = 3 },
	{ id = 12545, chance = 20180 },
	{ id = 12544, chance = 21640 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 10, attack = 2 },
}

monster.defenses = {
	defense = 2,
	armor = 2,
	{ name = "speed", interval = 2000, chance = 16, speedChange = 346, effect = CONST_ME_POFF, target = false, duration = 4000 },
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
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
