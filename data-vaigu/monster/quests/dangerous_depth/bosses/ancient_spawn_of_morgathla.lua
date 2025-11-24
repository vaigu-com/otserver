local mType = Game.createMonsterType("Ancient Spawn of Morgathla")
local monster = {}

monster.description = "Ancient Spawn Of Morgathla"
monster.experience = 700000
monster.outfit = {
	lookType = 1055,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1551,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 350000
monster.maxHealth = 350000
monster.race = "blood"
monster.corpse = 21004
monster.speed = 535
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 4,
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
}

monster.loot = {
	{ id = 3035, chance = 67610, maxCount = 40 }, -- platinum coin
	{ id = 9058, chance = 17390 }, -- gold ingot
	{ id = 5911, chance = 3230 }, -- red piece of cloth
	{ id = 239, chance = 11480, maxCount = 20 }, -- great health potion
	{ id = 238, chance = 10060, maxCount = 20 }, -- great mana potion
	{ id = 3577, chance = 7230 }, -- meat
	{ id = 9057, chance = 5810, maxCount = 20 }, -- small topaz
	{ id = 3030, chance = 4520, maxCount = 20}, -- small ruby
	{ id = 7412, chance = 900 }, -- butcher's axe
	{ id = 3381, chance = 770 }, -- crown armor
	{ id = 22721, chance = 1420 },
	{ id = 3318, chance = 1770 }, -- knight axe
	{ id = 7413, chance = 1390 }, -- titan axe
	{ id = 22516, chance = 1520 },
	{ id = 27605, chance = 1520 },
	{ id = 22193, chance = 10060 },
	{ id = 12509, chance = 10240 },
	{ id = 5891, chance = 3070 },
	{ id = 7424, chance = 2030 },
	{ id = 8029, chance = 2040 },
	{ id = 23474, chance = 3090 },
	{ id = 25088, chance = 5020 },
	{ id = 8902, chance = 13050 },
	{ id = 23476, chance = 3090 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 95 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -135, maxDamage = -680, range = 7, radius = 5, shootEffect = CONST_ANI_WHIRLWINDAXE, effect = CONST_ME_HITAREA, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -390, maxDamage = -700, range = 7, shootEffect = CONST_ANI_WHIRLWINDAXE, effect = CONST_ME_EXPLOSIONAREA, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -550, maxDamage = -720, length = 8, spread = 2, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAINDAMAGE, minDamage = 0, maxDamage = -700, length = 8, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "groundshaker", interval = 2000, chance = 25, minDamage = -288, maxDamage = -613, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -750, range = 5, effect = CONST_ME_MORTAREA, target = true }, --Death Missile
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -440, maxDamage = -710, radius = 8, effect = CONST_ME_SMALLPLANTS, target = false },

}

monster.defenses = {
	defense = 190,
	armor = 190,
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -30 },
	{ type = COMBAT_HOLYDAMAGE, percent = -15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
