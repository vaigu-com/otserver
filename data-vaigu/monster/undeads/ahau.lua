local mType = Game.createMonsterType("Ahau")
local monster = {}

monster.description = "Ahau"
monster.experience = 17500
monster.outfit = {
	lookType = 1591,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2346,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 19000
monster.maxHealth = 19000
monster.race = "blood"
monster.corpse = 42069
monster.speed = 350
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
	rewardBoss = true,
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
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "WAAAHNGH!!!", yell = true },
	{ text = "Awrrrgh!", yell = false },
	{ text = "IKSPUTUTU!!", yell = true },
	{ text = "Hwaaarrrh!!!", yell = false },
	{ text = "Wraaahgh?!", yell = false },
	{ text = "AAAAAH!!", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 90000, maxCount = 100 },
	{ name = "the living idol of tukh", chance = 10000 },
	{ name = "rotten feather", chance = 50000 },
	{ name = "great health potion", chance = 40000, maxCount = 5 },
	{ name = "great spirit potion", chance = 25530, maxCount = 1 },
	{ name = "great mana potion", chance = 34040, maxCount = 5 },
	{ name = "ritual tooth", chance = 32980 },
	{ name = "diamond", chance = 15320, maxCount = 3 },
	{ name = "amber with a bug", chance = 2190 },
	{ name = "amber", chance = 4320 },
	{ id = 23533, chance = 3500 }, --ring of red plasma
	{ id = 23531, chance = 3500 }, --ring of green plasma
	{ id = 23529, chance = 3500 }, --ring of blue plasma
	{ id = 23544, chance = 3500 }, --collar of red plasma
	{ id = 23542, chance = 3500 }, --collar of blue plasma
	{ id = 23543, chance = 3500 }, --collar of green plasma
	{ name = "broken iks headpiece", chance = 1000 },
	{ name = "broken macuahuitl", chance = 1000 },
	{ name = "broken iks faulds", chance = 1000 },
	{ name = "broken iks cuirass", chance = 1000 },
	{ id = 44605, chance = 3500 },
	{ id = 44602, chance = 3500 },
	{ id = 44611, chance = 3500 },
	{ id = 44608, chance = 3500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -456, effect = 244 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -350, maxDamage = -422, range = 1, radius = 1, effect = CONST_ME_GREENSMOKE, target = true },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -500, length = 6, spread = 3, effect = 216, target = false },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_EARTHDAMAGE, minDamage = -415, maxDamage = -570, radius = 3, effect = CONST_ME_STONE_STORM, target = false },
	{ name = "boulder ring", interval = 2000, chance = 20, minDamage = -460, maxDamage = -500 },
}

monster.defenses = {
	defense = 64,
	armor = 20,
	--	mitigation = ???,
}

monster.reflects = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 75 },
	{ type = COMBAT_FIREDAMAGE, percent = 50 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 80 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
