local mType = Game.createMonsterType("Manticore")
local monster = {}

monster.description = "a manticore"
monster.experience = 5100
monster.outfit = {
	lookType = 1189,
	lookHead = 58,
	lookBody = 78,
	lookLegs = 113,
	lookFeet = 20,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1816
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Kilmaresh.",
}

monster.health = 6700
monster.maxHealth = 6700
monster.race = "blood"
monster.corpse = 31390
monster.speed = 145
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 50,
	health = 10,
	damage = 10,
	random = 30,
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
	staticAttackChance = 85,
	targetDistance = 3,
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
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 3 },
	{ name = "flaming arrow", chance = 4000, maxCount = 8 },
	{ name = "royal star", chance = 1200 },
	{ name = "manticore ear", chance = 6600 },
	{ name = "manticore tail", chance = 8500 },
	{ name = "magma legs", chance = 750 },
	{ name = "magma coat", chance = 2900 },
	{ name = "magma boots", chance = 400 },
	{ name = "magma monocle", chance = 1800 },
	{ name = "wand of dragonbreath", chance = 750 },
	{ name = "wand of draconia", chance = 400 },
	{ name = "wand of everblazing", chance = 800 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -350, maxDamage = -450, length = 5, spread = 0, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "fireball rune", interval = 2000, chance = 15, minDamage = -300, maxDamage = -500, range = 3, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -500, range = 6, radius = 3, shootEffect = CONST_ANI_POISONARROW, effect = CONST_ME_POISONAREA, target = true },
}

monster.defenses = {
	defense = 78,
	armor = 78,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
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
