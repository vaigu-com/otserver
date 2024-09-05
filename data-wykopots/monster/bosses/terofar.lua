local mType = Game.createMonsterType("Terofar")
local monster = {}

monster.description = "Terofar"
monster.experience = 24000
monster.outfit = {
	lookType = 12,
	lookHead = 19,
	lookBody = 0,
	lookLegs = 77,
	lookFeet = 79,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 40000
monster.maxHealth = 40000
monster.race = "blood"
monster.corpse = 6068
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 25,
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
	{ text = "IT TOOK AN ARMY OF YOUR KIND TO DEFEAT THE WARDEN. NOW YOU ARE ALONE!", yell = true },
	{ text = "FEELS GOOD TO BE BACK IN ACTION!", yell = true },
	{ text = "THE WARDS ARE FAILING! MY ESCAPE IS ONLY A MATTER OF TIME!!", yell = true },
}

monster.loot = {
	{ id = 20062, chance = 100000 }, -- cluster
	{ id = 20264, chance = 100000 }, -- dreams
	{ id = 20063, chance = 100000 }, -- dream matter
	{ id = 6499, chance = 100000 },
	{ id = 5954, chance = 100000 },
	{ id = 20276, chance = 10060 }, -- mask
	{ id = 3035, chance = 100000, maxCount = 60 },
	{ id = 238, chance = 33330, maxCount = 10 },
	{ id = 7643, chance = 3890, maxCount = 10 },
	{ id = 7642, chance = 2780, maxCount = 5 },
	{ id = 16119, chance = 22220, maxCount = 8 },
	{ id = 16120, chance = 33330, maxCount = 8 },
	{ id = 16121, chance = 44440, maxCount = 8 },
	{ id = 9058, chance = 21670 }, -- gold ing
	{ id = 281, chance = 38890 }, -- shimm
	{ id = 282, chance = 38890 }, -- shimm2
	{ id = 3420, chance = 2510 }, --demonka
	{ id = 3415, chance = 22220 }, -- guardianka
	{ id = 3419, chance = 11110 }, -- crown sh
	{ id = 3414, chance = 960 }, -- mms
	{ id = 8063, chance = 5560 }, -- pall arm
	{ id = 8051, chance = 3110 }, -- voltage
	{ id = 8049, chance = 2110 }, -- lavos
	{ id = 3038, chance = 16670 },
	{ id = 3041, chance = 11110 },
	{ id = 8054, chance = 810 }, -- earthborn
	{ id = 3366, chance = 610 }, -- mpa
	{ id = 3554, chance = 7010 }, -- steel
	{ id = 3392, chance = 3500 }, -- rh
	{ id = 813, chance = 12010 }, -- terra boots
	{ id = 3079, chance = 1010 }, -- boh
	{ id = 5741, chance = 5010 }, -- skull helm
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1800 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -700, maxDamage = -1500, length = 8, spread = 0, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -750, range = 7, radius = 1, shootEffect = CONST_ANI_WHIRLWINDAXE, target = true },
	{ name = "terofar skill 1", interval = 2000, chance = 15, target = false },
	{ name = "terofar skill 2", interval = 2000, chance = 15, target = false },
	{ name = "terofar curse", interval = 1000, chance = 100, range = 7, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	{ name = "terofar heal", interval = 2000, chance = 30, target = false },
	{ name = "speed", interval = 2000, chance = 18, speedChange = 784, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 7000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 50 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 50 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
