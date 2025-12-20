local mType = Game.createMonsterType("Tromphonyte")
local monster = {}

monster.description = "Tromphonyte"
monster.experience = 7300
monster.outfit = {
	lookType = 381,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3000
monster.maxHealth = 3000
monster.race = "blood"
monster.corpse = 12325
monster.speed = 120
monster.manaCost = 0

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
	rewardBoss = true,
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
	{ id = 12314, chance = 90000 }, -- hollow stampor hoof
	{ id = 3370, chance = 90000 }, -- knight armor
	{ id = 3035, chance = 90000, maxCount = 13 }, -- platinum coin
	{ id = 9057, chance = 90000, maxCount = 15 }, -- small topaz
	{ id = 12312, chance = 90000 }, -- stampor horn
	{ id = 12313, chance = 90000, maxCount = 4 }, -- stampor talons
	{ id = 236, chance = 90000, maxCount = 20 }, -- strong health potion
	{ id = 237, chance = 90000, maxCount = 20 }, -- strong mana potion
	{ id = 7452, chance = 50000 }, -- spiked squelcher
	{ id = 9079, chance = 20000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -315 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -170, maxDamage = -300, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -90, maxDamage = -230, shootEffect = CONST_ANI_SMALLSTONE, target = true },
	{ name = "stampor skill reducer", interval = 2000, chance = 20, range = 5, target = true },
}

monster.defenses = {
	defense = 20,
	armor = 40,
	mitigation = 1.11,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 90, maxDamage = 120, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
