local mType = Game.createMonsterType("Miss Pitca")
local monster = {}

monster.description = "Miss Pitca"
monster.experience = 100
monster.outfit = {
	lookType = 156,
	lookHead = 94,
	lookBody = 78,
	lookLegs = 97,
	lookFeet = 114,
	lookAddons = 1,
	lookMount = 0,
}

monster.health = 300
monster.maxHealth = 300
monster.race = "undead"
monster.corpse = 0
monster.speed = 200
monster.manaCost = 0

monster.changeTarget = {
	interval = 4999,
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
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {
	"PitcaDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -30 },
}

monster.defenses = {
	defense = 15,
	armor = 15,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "outfit", condition = false },
}

mType:register(monster)
