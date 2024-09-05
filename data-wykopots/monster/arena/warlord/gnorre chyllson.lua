local mType = Game.createMonsterType("Gnorre Chyllson")
local monster = {}

monster.description = "gnorre chyllson"
monster.experience = 4000
monster.outfit = {
	lookType = 251,
	lookHead = 11,
	lookBody = 9,
	lookLegs = 11,
	lookFeet = 85,
	lookAddons = 1,
	lookMount = 0,
}

monster.health = 7100
monster.maxHealth = 7100
monster.race = "blood"
monster.corpse = 0
monster.speed = 185
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
	canWalkOnFire = true,
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
	{ text = "I am like the merciless northwind.", yell = false },
	{ text = "Snow will be your death shroud.", yell = false },
	{ text = "Feel the wrath of father chyll!", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 60, attack = 130 },
	{ name = "melee", interval = 3000, chance = 50, minDamage = -500, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -170, maxDamage = -200, range = 7, shootEffect = CONST_ANI_SNOWBALL, target = false },
}

monster.defenses = {
	defense = 52,
	armor = 51,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
