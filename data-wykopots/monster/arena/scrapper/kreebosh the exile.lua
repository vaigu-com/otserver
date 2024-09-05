local mType = Game.createMonsterType("Kreebosh the Exile")
local monster = {}

monster.description = "kreebosh the exile"
monster.experience = 350
monster.outfit = {
	lookType = 103,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 880
monster.maxHealth = 880
monster.race = "blood"
monster.corpse = 0
monster.speed = 135
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

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Green Djinn", chance = 20, interval = 5000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I bet you wish you weren't here.", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 30, attack = 50 },
	{ name = "combat", interval = 6000, chance = 80, type = COMBAT_FIREDAMAGE, minDamage = 0, maxDamage = -120, radius = 3, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "speed", interval = 3500, chance = 35, range = 5, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, speedChange = -450, duration = 20000 },
	{ name = "combat", interval = 6000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -20, maxDamage = -100, range = 5, radius = 1, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 5000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -40, maxDamage = -200, range = 5, radius = 1, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_FIREAREA, target = true },
	{ name = "drunk", interval = 1000, chance = 20, range = 5, radius = 1, target = true, duration = 30000 },
	{ name = "outfit", interval = 2000, chance = 50, range = 5, radius = 1, effect = CONST_ME_MAGIC_GREEN, target = true, duration = 60000, outfitMonster = "Rat" },
}

monster.defenses = {
	defense = 40,
	armor = 30,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 55 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
