local mType = Game.createMonsterType("Wiggler")
local monster = {}

monster.description = "a wiggler"
monster.experience = 900
monster.outfit = {
	lookType = 510,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 899
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Can be found in Truffels Garden as well as the Mushroom Gardens.",
}

monster.health = 1200
monster.maxHealth = 1200
monster.race = "venom"
monster.corpse = 16193
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 4,
}

monster.strategiesTarget = {
	nearest = 70,
	damage = 30,
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
	runHealth = 400,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
	pet = false,
}

monster.events = {
	"BigfootBurdenWigglerDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Zzzrp!", yell = false },
	{ text = "Crick! Crick!", yell = false },
}

monster.loot = {
	{ id = 15793, chance = 1550, maxCount = 5 },
	{ id = 3429, chance = 1320 },
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ id = 16142, chance = 15260, maxCount = 5 },
	{ name = "platinum coin", chance = 14720 },
	{ id = 237, chance = 5240 },
	{ id = 236, chance = 4950 },
	{ id = 3723, chance = 7230, maxCount = 5 },
	{ id = 16122, chance = 3610 },
	{ id = 5912, chance = 2040 },
	{ id = 5914, chance = 2150 },
	{ id = 16127, chance = 2070 },
	{ id = 3297, chance = 1380 },
	{ id = 3065, chance = 850 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 70, attack = 50, condition = { type = CONDITION_POISON, totalDamage = 540, interval = 4000 } },
	{ name = "wiggler paralyze", interval = 2000, chance = 12, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -180, maxDamage = -270, length = 5, spread = 2, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 11, minDamage = -180, maxDamage = -200, range = 7, shootEffect = CONST_ANI_POISONARROW, effect = CONST_ME_SMALLPLANTS, target = true },
}

monster.defenses = {
	defense = 52,
	armor = 52,
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 100, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
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
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
