local mType = Game.createMonsterType("Glooth Fairy")
local monster = {}

monster.description = "a glooth fairy"
monster.experience = 150
monster.outfit = {
	lookType = 600,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 59000
monster.maxHealth = 59000
monster.race = "blood"
monster.corpse = 20972
monster.speed = 100
monster.manaCost = 490

monster.changeTarget = {
	interval = 4000,
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
	canPushCreatures = true,
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

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ id = 21103, chance = 100000, maxCount = 3 },
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 5 },
	{ id = 7642, chance = 33333, maxCount = 5 },
	{ name = "great health potion", chance = 25000, maxCount = 5 },
	{ name = "great mana potion", chance = 25000, maxCount = 5 },
	{ id = 21143, chance = 25000, maxCount = 5 },
	{ id = 21183, chance = 20000 },
	{ id = 21144, chance = 20000, maxCount = 5 },
	{ id = 21179, chance = 20000 },
	{ id = 21146, chance = 20000, maxCount = 5 },
	{ id = 5880, chance = 20000 },
	{ id = 21178, chance = 20000 },
	{ id = 3032, chance = 20000, maxCount = 5 },
	{ id = 21158, chance = 16666, maxCount = 5 },
	{ id = 8775, chance = 16666 },
	{ id = 21180, chance = 14285 },
	{ id = 3028, chance = 14285, maxCount = 5 },
	{ id = 3030, chance = 14285, maxCount = 5 },
	{ id = 9057, chance = 14285, maxCount = 5 },
	{ id = 3029, chance = 12500, maxCount = 5 },
	{ id = 3033, chance = 10000, maxCount = 5 },
	{ id = 21164, chance = 7142 },
	{ id = 21165, chance = 7142 },
	{ id = 21167, chance = 5000 },
	{ id = 3041, chance = 4166 },
	{ id = 3039, chance = 3333 },
	{ id = 3037, chance = 2500 },
	{ id = 21292, chance = 1666 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 500, attack = 75 },
	{ name = "thunderstorm rune", interval = 2000, chance = 35, minDamage = -200, maxDamage = -500, range = 7, target = true },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -300, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 15000 },
}

monster.defenses = {
	defense = 40,
	armor = 40,
	{ name = "combat", interval = 3000, chance = 35, type = COMBAT_HEALING, minDamage = 150, maxDamage = 300, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 3000, chance = 5, type = COMBAT_HEALING, minDamage = 7500, maxDamage = 8000, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
