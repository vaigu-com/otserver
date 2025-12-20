local mType = Game.createMonsterType("Skeleton Mage")
local monster = {}

monster.description = "a skeleton mage"
monster.experience = 60
monster.outfit = {
	lookType = 1322,
	lookHead = 38,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 67,
	lookAddons = 1,
	lookMount = 0,
}

monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Island of Destiny, Drefia, Ghostland and beneath Fenrock.",
}

monster.health = 55
monster.maxHealth = 55
monster.race = "undead"
monster.corpse = 5972
monster.speed = 56
monster.manaCost = 380

monster.changeTarget = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = true,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = true,
	rewardBoss = false,
	illusionable = true,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 3,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
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
	{ name = "gold coin", chance = 43500, maxCount = 10 },
	{ id = 3115, chance = 50000 }, -- bone
	{ name = "mace", chance = 2000 },
	{ name = "white mushroom", chance = 24000, maxCount = 3 },
	{ name = "brown mushroom", chance = 1700 },
	{ name = "pelvis bone", chance = 10630 },
	{ name = "wand of dragonbreath", chance = 2100 },
	{ name = "moonlight rod", chance = 1800 },

}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -30 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -7, maxDamage = -13, range = 1, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -10, maxDamage = -19, range = 7, radius = 1, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_FIREATTACK, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -10, maxDamage = -8, range = 7, radius = 3, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -10, maxDamage = -19, range = 7, radius = 1, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICETORNADO, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -10, maxDamage = -8, range = 7, radius = 3, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICEAREA, target = true },
}

monster.defenses = {
	defense = 15,
	armor = 5,
	mitigation = 0.25,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
