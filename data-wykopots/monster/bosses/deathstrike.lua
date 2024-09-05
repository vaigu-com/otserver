local mType = Game.createMonsterType("Deathstrike")
local monster = {}

monster.description = "Deathstrike"
monster.experience = 40000
monster.outfit = {
	lookType = 500,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 892,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 200000
monster.maxHealth = 200000
monster.race = "blood"
monster.corpse = 16088
monster.speed = 290
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
	runHealth = 2000,
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
	{ text = "Deeestructiooon!", yell = false },
	{ text = "Maaahhhrrr!", yell = false },
	{ text = "I am carnage incarnate!", yell = false },
	{ text = "I've seen the light! And it was all engulfing fire!", yell = false },
	{ text = "Taaake... this!", yell = false },
}

monster.loot = {
	{ id = 16175, chance = 11430 },
	{ id = 16162, chance = 8570 },
	{ id = 16160, chance = 10480 },
	{ id = 16136, chance = 100000 },
	{ id = 16163, chance = 12380 },
	{ id = 16161, chance = 11430 },
	{ id = 16164, chance = 11430 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 190, attack = 200 },
	{ name = "drunk", interval = 2000, chance = 40, range = 7, radius = 6, effect = CONST_ME_BLOCKHIT, target = false, duration = 25000 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -400, range = 7, radius = 1, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -600, range = 7, radius = 5, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "deathstrike freeze", interval = 2000, chance = 12, range = 7, target = false },
	{ name = "deathstrike manadrain", interval = 2000, chance = 17, minDamage = -200, maxDamage = -800, target = false },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -1200, length = 4, spread = 0, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "deathstrike paralyze", interval = 2000, chance = 20, target = false },
}

monster.defenses = {
	defense = 133,
	armor = 101,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 4000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 1, type = COMBAT_HEALING, minDamage = 5000, maxDamage = 10000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 25, duration = 2000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 40 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 50 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 40 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
