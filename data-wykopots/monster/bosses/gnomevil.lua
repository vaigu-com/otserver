local mType = Game.createMonsterType("Gnomevil")
local monster = {}

monster.description = "Gnomevil"
monster.experience = 45000
monster.outfit = {
	lookType = 504,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 893,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 250000
monster.maxHealth = 250000
monster.race = "blood"
monster.corpse = 16149
monster.speed = 235
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 8,
}

monster.strategiesTarget = {
	nearest = 60,
	health = 15,
	damage = 15,
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
	staticAttackChance = 50,
	targetDistance = 1,
	runHealth = 5000,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.events = {
	"BigfootBurdenBossDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "No more Mr. Nicegnome!", yell = false },
	{ text = "Taste the power of the dark side!", yell = false },
	{ text = "I've seen the light! And it was all engulfing fire!", yell = false },
	{ text = "Tatatata!!!", yell = false },
	{ text = "Muhahaha!", yell = false },
	{ text = "I'm feeling grrrreat!", yell = false },
}

monster.loot = {
	{ id = 16161, chance = 9830 },
	{ id = 16163, chance = 8120 },
	{ id = 16205, chance = 100000 },
	{ id = 16175, chance = 7690 },
	{ id = 16164, chance = 9400 },
	{ id = 16162, chance = 8120 },
	{ id = 16160, chance = 14100 },
	{ id = 16155, chance = 1710 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 160, attack = 100 },
	{ name = "gnomevil electrify", interval = 2000, chance = 20, target = false },
	{ name = "gnomevil drunk", interval = 2000, chance = 13, target = false },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -750, range = 7, radius = 1, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_EXPLOSIONAREA, target = true },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ICEDAMAGE, minDamage = -250, maxDamage = -750, range = 7, radius = 1, shootEffect = CONST_ANI_SNOWBALL, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -750, range = 7, radius = 1, shootEffect = CONST_ANI_WHIRLWINDCLUB, effect = CONST_ME_CARNIPHILA, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -200, maxDamage = -800, radius = 4, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "gnomevil skill reducer 1", interval = 2000, chance = 11, target = false },
	{ name = "gnomevil skill reducer 2", interval = 2000, chance = 11, target = false },
	{ name = "deathstrike manadrain", interval = 2000, chance = 20, minDamage = -200, maxDamage = -800, target = false },
	{ name = "gnomevil soulfire", interval = 2000, chance = 20, target = false },
}

monster.defenses = {
	defense = 143,
	armor = 108,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 2000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 3, type = COMBAT_HEALING, minDamage = 10000, maxDamage = 15000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 25, duration = 2000, effect = CONST_ME_SMOKE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 50 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
