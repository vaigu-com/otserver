local mType = Game.createMonsterType("Swampling")
local monster = {}

monster.description = "a swampling"
monster.experience = 45
monster.outfit = {
	lookType = 535,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 919
monster.Bestiary = {
	class = "Plant",
	race = BESTY_RACE_PLANT,
	toKill = 250,
	FirstUnlock = 10,
	SecondUnlock = 100,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Venore swamp area, Venore Salamander Cave, Tiquanda Laboratory.",
}

monster.health = 80
monster.maxHealth = 80
monster.race = "venom"
monster.corpse = 17622
monster.speed = 95
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
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
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
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
	{ text = "Gnark!", yell = false },
	{ text = "Crrrck!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 60000, maxCount = 12 },
	{ id = 3723, chance = 8980, maxCount = 5 },
	{ id = 17822, chance = 12610 },
	{ id = 17823, chance = 8270 },
	{ id = 17821, chance = 18670 },
	{ id = 3003, chance = 4540 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 30, attack = 40 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -2, maxDamage = -15, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -300, length = 3, spread = 2, effect = CONST_ME_WATERSPLASH, target = false, duration = 5000 },
}

monster.defenses = {
	defense = 4,
	armor = 4,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
