local mType = Game.createMonsterType("Tazhadur")
local monster = {}

monster.description = "Tazhadur"
monster.experience = 9000
monster.outfit = {
	lookType = 947,
	lookHead = 24,
	lookBody = 119,
	lookLegs = 19,
	lookFeet = 95,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1390,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 7000
monster.maxHealth = 7000
monster.race = "blood"
monster.corpse = 25065
monster.speed = 175
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
}

monster.loot = {
	{ id = 5920, chance = 50000 }, -- green dragon scale
	{ id = 24938, chance = 80000 }, -- dragon tongue
	{ id = 3386, chance = 1000 }, -- dragon scale mail
	{ id = 3322, chance = 25000 }, -- dragon hammer
	{ id = 3416, chance = 12000 }, -- dragon shield
	{ id = 3085, chance = 25000 }, -- dragon necklace
	{ id = 3583, chance = 25000 }, -- dragon ham
	{ id = 5877, chance = 25000 }, -- green dragon leather
	{ id = 24937, chance = 80000, maxCount = 2 }, -- dragon blood
	{ id = 24940, chance = 80000 }, -- tooth of tazhadur
	{ id = 3098, chance = 44840 }, -- ring of healing
	{ name = "hydra egg", chance = 8840 },
	{ name = "strong mana potion", chance = 77840 },
	{ name = "stone skin amulet", chance = 5750 },
	{ name = "boots of haste", chance = 1190 },
	{ id = 8853, chance = 22840 },
	{ id = 19083, chance = 22200 }, -- silver raid token
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 112, attack = 85 },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -450, length = 5, spread = 4, effect = CONST_ME_BLACKSMOKE, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -66, maxDamage = -320, length = 8, spread = 3, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -110, maxDamage = -345, range = 7, radius = 5, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -310, maxDamage = -395, length = 9, spread = 4, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_FIREDAMAGE, minDamage = -410, maxDamage = -695, length = 6, spread = 4, effect = CONST_ME_FIREAREA, target = false },
}

monster.defenses = {
	defense = 64,
	armor = 52,
	--	mitigation = ???,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 90 },
	{ type = COMBAT_FIREDAMAGE, percent = 90 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -30 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
