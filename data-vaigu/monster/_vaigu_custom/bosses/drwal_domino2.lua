local mType = Game.createMonsterType("Drwal Domino2")
local monster = {}

monster.name = "Drwal Domlno"
monster.description = "a drwal domino"
monster.experience = 0
monster.outfit = {
	lookType = 143,
	lookHead = 114,
	lookBody = 116,
	lookLegs = 116,
	lookFeet = 114,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 8000
monster.maxHealth = 8000
monster.race = "blood"
monster.corpse = 111
monster.speed = 90
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
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
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, minCount = 10, maxCount = 15 },
	{ name = "knight axe", chance = 10000 },
	{ name = "knight armor", chance = 5000 },
	{ name = "knight legs", chance = 5000 },
	{ name = "steel helmet", chance = 60000 },
	{ name = "tower shield", chance = 5000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -150 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -100, range = 7, radius = 1, shootEffect = CONST_ANI_WHIRLWINDAXE, target = true },
	{ name = "berserk", interval = 2000, chance = 13, minDamage = 0, maxDamage = -150, target = false },
}

monster.defenses = {
	defense = 9,
	armor = 9,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 240, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
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

monster.events = {
	"Domino2Death",
}

mType:register(monster)
