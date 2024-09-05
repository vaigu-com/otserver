local mType = Game.createMonsterType("Ogre Rowdy")
local monster = {}

monster.description = "an ogre rowdy"
monster.experience = 4200
monster.outfit = {
	lookType = 1213,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1821
monster.Bestiary = {
	class = "Giant",
	race = BESTY_RACE_GIANT,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Kilmaresh Central Steppe, Kilmaresh Southern Steppe, Green Belt, Kilmaresh Mountains (underground).",
}

monster.health = 4500
monster.maxHealth = 4500
monster.race = "blood"
monster.corpse = 31531
monster.speed = 210
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 15,
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
	staticAttackChance = 80,
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
}

monster.loot = {
	{ name = "platinum coin", chance = 90000, maxCount = 2 },
	{ name = "flaming arrow", chance = 22000, maxCount = 9 },
	{ name = "ogre nose ring", chance = 22000 },
	{ name = "ogre ear stud", chance = 15000 },
	{ name = "wand of inferno", chance = 8000 },
	{ name = "skull fetish", chance = 9000 },
	{ name = "jalapeno pepper", chance = 5000 },
	{ name = "wand of draconia", chance = 8100 },
	{ name = "wand of everblazing", chance = 1000 },
	{ name = "blue crystal shard", chance = 3700 },
	{ name = "small emerald", chance = 3200 },
	{ name = "prismatic quartz", chance = 2600 },
	{ name = "violet crystal shard", chance = 2200 },
	{ name = "onyx chip", chance = 1800 },
	{ name = "blue gem", chance = 1300 },
	{ id = 281, chance = 650 }, -- pearl
	{ name = "opal", chance = 650 },
	{ name = "ogre choppa", chance = 600 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -550 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -560, range = 5, radius = 5, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true }, --gfb
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_FIREDAMAGE, minDamage = -380, maxDamage = -500, radius = 3, effect = CONST_ME_FIREAREA, target = false }, -- fire bomb
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -500, range = 4, shootEffect = CONST_ANI_FLAMMINGARROW, target = true }, -- fire missile
}

monster.defenses = {
	defense = 98,
	armor = 98,
	{ name = "speed", interval = 2000, chance = 16, speedChange = 200, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -30 },
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
