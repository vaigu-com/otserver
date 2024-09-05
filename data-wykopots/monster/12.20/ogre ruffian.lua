local mType = Game.createMonsterType("Ogre Ruffian")
local monster = {}

monster.description = "an ogre ruffian"
monster.experience = 5500
monster.outfit = {
	lookType = 1212,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1820
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

monster.health = 5000
monster.maxHealth = 5000
monster.race = "blood"
monster.corpse = 31527
monster.speed = 215
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
	{ name = "ogre nose ring", chance = 16800 },
	{ name = "ogre ear stud", chance = 16800 },
	{ name = "meat", chance = 10000, maxCount = 4 },
	{ name = "small sapphire", maxCount = 2, chance = 10000 },
	{ name = "diamond sceptre", chance = 4800 },
	{ name = "small emerald", chance = 4700 },
	{ name = "stone skin amulet", chance = 3000 },
	{ name = "skull fetish", chance = 2500 },
	{ name = "metal spats", chance = 2200 },
	{ name = "war hammer", chance = 2200 },
	{ name = "pair of iron fists", chance = 1700 },
	{ name = "cyan crystal fragment", chance = 1400 },
	{ name = "onyx chip", chance = 1400 },
	{ name = "yellow gem", chance = 1100 },
	{ name = "blue gem", chance = 800 },
	{ name = "green crystal splinter", chance = 399 },
	{ name = "ogre klubba", chance = 550 },
	{ name = "small enchanted emerald", chance = 300 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "groundshaker", interval = 2000, chance = 13, minDamage = -430, maxDamage = -600, target = false },
	{ name = "berserk", interval = 2000, chance = 15, minDamage = -400, maxDamage = -600, target = false },
}

monster.defenses = {
	defense = 102,
	armor = 102,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
