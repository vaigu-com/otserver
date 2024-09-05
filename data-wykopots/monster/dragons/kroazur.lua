local mType = Game.createMonsterType("Kroazur")
local monster = {}

monster.description = "Kroazur"
monster.experience = 2700
monster.outfit = {
	lookType = 842,
	lookHead = 19,
	lookBody = 114,
	lookLegs = 94,
	lookFeet = 85,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 3000
monster.maxHealth = 3000
monster.race = "undead"
monster.corpse = 6324
monster.speed = 250
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 20,
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

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "fairy wings", chance = 100000 },
	--{name = "gold coin", chance = 100000, maxCount = 365},
	{ name = "platinum coin", chance = 100000, maxCount = 11 },
	--{name = "strong health potion", chance = 91460, maxCount = 2},
	{ name = "great health potion", chance = 76330, maxCount = 6 },
	{ name = "small enchanted amethyst", chance = 53560, maxCount = 5 },
	{ name = "ancient coin", chance = 50000, maxCount = 3 },
	{ name = "gemmed figurine", chance = 28000 },
	{ name = "small enchanted emerald", chance = 26003, maxCount = 3 },
	{ name = "small enchanted ruby", chance = 60000, maxCount = 5 },
	{ name = "silver token", chance = 14000 },
	{ name = "cluster of solace", chance = 9960 },
	{ name = "red crystal fragment", chance = 12000, maxCount = 3 },
	{ name = "small enchanted sapphire", chance = 5000, maxCount = 5 },
	--{name = "assassin star", chance = 8540},
	{ name = "gold token", chance = 6580 },
	{ name = "gold ingot", chance = 10000 },
	{ name = "nightmare blade", chance = 2000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "terra strike", interval = 2000, chance = 28, minDamage = -0, maxDamage = -300, range = 6, target = true },
	{ name = "death strike", interval = 2000, chance = 28, minDamage = -0, maxDamage = -300, range = 6, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 400, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onThink = function(monster, interval) end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
