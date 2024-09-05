local mType = Game.createMonsterType("Sphinx")
local monster = {}

monster.description = "a sphinx"
monster.experience = 7500
monster.outfit = {
	lookType = 1188,
	lookHead = 50,
	lookBody = 39,
	lookLegs = 0,
	lookFeet = 3,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1808
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Nykri Delta, Kilmaresh Central Steppe, Kilmaresh Southern Steppe, Kilmaresh Catacombs.",
}

monster.health = 8500
monster.maxHealth = 8500
monster.race = "blood"
monster.corpse = 31386
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
	targetDistance = 1,
	runHealth = 10,
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
	{ name = "sphinx feather", chance = 6500 },
	{ name = "magma amulet", chance = 5000 },
	{ name = "blue gem", chance = 5700 },
	{ name = "green gem", chance = 4300 },
	{ name = "sphinx tiara", chance = 6300 },
	{ name = "magma boots", chance = 3200 },
	{ name = "lightning pendant", chance = 2300 },
	{ name = "lightning headband", chance = 3300 },
	{ name = "wand of starstorm", chance = 2350 },
	{ name = "wand of defiance", chance = 2000 },
	{ name = "magma monocle", chance = 1900 },
	{ name = "magma legs", chance = 890 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -450, length = 6, spread = 0, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HOLYDAMAGE, minDamage = -100, maxDamage = -350, range = 5, radius = 3, shootEffect = CONST_ANI_SMALLHOLY, effect = CONST_ME_HOLYAREA, target = true },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -400, radius = 3, effect = CONST_ME_ENERGYAREA, target = false },
}

monster.defenses = {
	defense = 82,
	armor = 82,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = -20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
