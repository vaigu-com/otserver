local mType = Game.createMonsterType("Abyssador")
local monster = {}

monster.description = "Abyssador"
monster.experience = 50000
monster.outfit = {
	lookType = 495,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 887,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 300000
monster.maxHealth = 300000
monster.race = "blood"
monster.corpse = 16068
monster.speed = 235
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
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
	runHealth = 100,
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
	{ text = "*** BRAINS *** SMALL ***", yell = false },
	{ text = "*** LIVE *** DRY ***", yell = false },
	{ text = "*** IMPORTANT ***", yell = false },
	{ text = "*** FIRE *** HOME *** VICTORY ***", yell = false },
	{ text = "*** EXISTENCE *** FUTILE ***", yell = false },
	{ text = "*** TIME ***", yell = false },
	{ text = "*** STEALTH ***", yell = false },
	{ text = "*** DEATH ***", yell = false },
}

monster.loot = {
	{ id = 16206, chance = 100000 },
	{ id = 16164, chance = 25000 },
	{ id = 16175, chance = 17000 },
	{ id = 16155, chance = 10000 },
	{ id = 16163, chance = 17000 },
	{ id = 16161, chance = 17000 },
	{ id = 16160, chance = 17000 },
	{ id = 16162, chance = 17000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 140, attack = 200, condition = { type = CONDITION_POISON, totalDamage = 1000, interval = 4000 } },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 20, minDamage = -900, maxDamage = -1200, radius = 4, effect = CONST_ME_INSECTS, target = false },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_DEATHDAMAGE, minDamage = -250, maxDamage = -900, range = 7, radius = 4, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -925, range = 7, radius = 3, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_EXPLOSIONAREA, target = true },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_MANADRAIN, minDamage = -400, maxDamage = -530, range = 7, radius = 3, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MAGIC_RED, target = true },
	{ name = "abyssador paralyze", interval = 2000, chance = 13, range = 7, target = false },
	{ name = "abyssador skill reducer 1", interval = 2000, chance = 12, target = false },
	{ name = "abyssador skill reducer 2", interval = 2000, chance = 11, target = false },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_EARTHDAMAGE, minDamage = -390, maxDamage = -500, range = 7, shootEffect = CONST_ANI_POISONARROW, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "abyssador poison wave", interval = 2000, chance = 25, minDamage = -400, maxDamage = -950, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -400, maxDamage = -1250, length = 8, spread = 0, effect = CONST_ME_STONES, target = false },
}

monster.defenses = {
	defense = 145,
	armor = 110,
	--{name ="combat", interval = 2000, chance = 1, type = COMBAT_HEALING, minDamage = 50000, maxDamage = 300000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 1, type = COMBAT_HEALING, minDamage = 5000, maxDamage = 10000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 25, duration = 10000, effect = CONST_ME_SOUND_WHITE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
