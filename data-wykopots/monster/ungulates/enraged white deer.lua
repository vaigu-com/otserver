local mType = Game.createMonsterType("Enraged White Deer")
local monster = {}

monster.description = "an enraged white deer"
monster.experience = 165
monster.outfit = {
	lookType = 400,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 255
monster.maxHealth = 255
monster.race = "blood"
monster.corpse = 12524
monster.speed = 98
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 0,
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
	{ name = "ham", chance = 19800, maxCount = 3 },
	{ id = 12545, chance = 20240 },
	{ id = 12544, chance = 19470 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 20, attack = 30 },
}

monster.defenses = {
	defense = 2,
	armor = 2,
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HEALING, minDamage = 5, maxDamage = 40, effect = CONST_ME_MAGIC_BLUE, target = false },
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
