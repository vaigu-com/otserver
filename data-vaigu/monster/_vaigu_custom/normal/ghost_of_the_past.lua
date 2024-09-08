local mType = Game.createMonsterType("Ghost of the past")
local monster = {}

monster.description = "a ghost of the past"
monster.experience = 1900
monster.outfit = {
	lookType = 560,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 962
-- monster.Bestiary = {
-- class = "Undead",
-- race = BESTY_RACE_UNDEAD,
-- toKill = 500,
-- FirstUnlock = 25,
-- SecondUnlock = 250,
-- CharmsPoints = 15,
-- Stars = 2,
-- Occurrence = 0,
-- Locations = "Drefia."
-- }

monster.health = 2600
monster.maxHealth = 2600
monster.race = "undead"
monster.corpse = 19059
monster.speed = 95
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
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
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Leave this place... save yourself...", yell = false },
	{ text = "The dark ones.. must be stopped... unholy, twisted, EVIL!", yell = false },
	{ text = "No... don't go further stranger... danger lies in every step...", yell = false },
}

monster.loot = {
	{ name = "crystal coin", chance = 1500 },
	{ id = 5909, chance = 24000, maxCount = 3 },
	{ id = 32769, chance = 1000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -250 },
	{ name = "combat", interval = 2750, chance = 28, type = COMBAT_LIFEDRAIN, minDamage = -5, maxDamage = -38, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 3000, chance = 30, type = COMBAT_LIFEDRAIN, minDamage = -5, maxDamage = -20, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 2000, chance = 7, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -450, length = 10, spread = 3, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -40, maxDamage = -160, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_YALAHARIGHOST, target = false },
	{ name = "speed", interval = 2000, chance = 5, speedChange = -400, radius = 4, effect = CONST_ME_HITAREA, target = false, duration = 3000 },
}

monster.defenses = {
	defense = 15,
	armor = 15,
	{ name = "invisible", interval = 2000, chance = 5, duration = 6000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 90 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)