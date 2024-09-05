local mType = Game.createMonsterType("Pooka")
local monster = {}

monster.description = "a pooka"
monster.experience = 500
monster.outfit = {
	lookType = 977,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1435
monster.Bestiary = {
	class = "Fey",
	race = BESTY_RACE_FEY,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Feyrist (daytime).",
}

monster.health = 500
monster.maxHealth = 500
monster.race = "blood"
monster.corpse = 25823
monster.speed = 115
monster.manaCost = 450

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

-- monster.respawnType = {
-- period = RESPAWNPERIOD_DAY,
-- underground = false
-- }

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 30,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
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
	{ text = "Hoppel-di-hopp!", yell = false },
	{ text = "Jinx!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 134 },
	{ id = 3595, chance = 21000, maxCount = 3 },
	{ name = "strong health potion", chance = 11180 },
	{ name = "shimmering beetles", chance = 9280 },
	{ name = "small stone", chance = 470, maxCount = 5 },
	{ name = "rainbow quartz", chance = 4200, maxCount = 2 },
	{ name = "cookie", chance = 4210, maxCount = 5 },
	{ id = 3737, chance = 3600 },
	{ name = "opal", chance = 3050, maxCount = 2 },
	{ name = "small enchanted ruby", chance = 2750, maxCount = 2 },
	{ name = "orange mushroom", chance = 2560 },
	{ id = 3049, chance = 900 }, -- stealth ring
	{ name = "dream blossom staff", chance = 700 },
	{ name = "carrot on a stick", chance = 60 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -120 },
	{ name = "combat", interval = 2000, chance = 24, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -100, range = 4, shootEffect = CONST_ANI_SMALLSTONE, target = true },
	{ name = "drunk", interval = 3000, chance = 14, length = 5, spread = 2, effect = CONST_ME_STUN, target = false, duration = 12000 },
	{ name = "outfit", interval = 2000, chance = 8, range = 7, shootEffect = CONST_ANI_POISON, target = true, duration = 6000, outfitMonster = "skunk" },
}

monster.defenses = {
	defense = 38,
	armor = 38,
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 40, maxDamage = 60, effect = CONST_ME_MAGIC_GREEN, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 70 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
