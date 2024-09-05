local mType = Game.createMonsterType("Svoren the Mad")
local monster = {}

monster.description = "svoren the mad"
monster.experience = 3000
monster.outfit = {
	lookType = 254,
	lookHead = 80,
	lookBody = 99,
	lookLegs = 118,
	lookFeet = 38,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 6300
monster.maxHealth = 6300
monster.race = "blood"
monster.corpse = 0
monster.speed = 90
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
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
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
	{ text = "NO mommy NO. Leave me alone!", yell = false },
	{ text = "Not that tower again!", yell = false },
	{ text = "The cat has grown some horns!!", yell = false },
	{ text = "What was I doing here again?", yell = false },
	{ text = "Are we there soon mommy?", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 60, attack = 150 },
	{ name = "speed", interval = 3500, chance = 35, speedChange = -450, range = 1, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 40 },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_EARTHDAMAGE, minDamage = -80, maxDamage = -100, range = 10, radius = 4, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -95, maxDamage = -215, range = 9, length = 5, spread = 4, effect = CONST_ME_SOUND_YELLOW, target = false },
}

monster.defenses = {
	defense = 45,
	armor = 35,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 60, maxDamage = 85, effect = CONST_ME_SOUND_GREEN, target = false },
	{ name = "speed", interval = 2000, chance = 9, speedChange = 578, effect = CONST_ME_SOUND_BLUE, target = false, duration = 3000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
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
