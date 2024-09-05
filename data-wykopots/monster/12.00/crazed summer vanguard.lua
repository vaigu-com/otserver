local mType = Game.createMonsterType("Crazed Summer Vanguard")
local monster = {}

monster.description = "a Crazed Summer Vanguard"
monster.experience = 5000
monster.outfit = {
	lookType = 1136,
	lookHead = 20,
	lookBody = 94,
	lookLegs = 20,
	lookFeet = 81,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1732
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Court of Winter, Dream Labyrinth.",
}

monster.health = 5500
monster.maxHealth = 5500
monster.race = "undead"
monster.corpse = 30077
monster.speed = 195
monster.manaCost = 0

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
	{ text = "I see colours, all colours! Or are these just illusions?", yell = false },
	{ text = "La di da di doo!!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 80000, maxCount = 13 },
	{ name = "elven astral observer", chance = 28800 },
	{ name = "dream essence egg", chance = 8984 },
	{ name = "belted cape", chance = 8752 },
	{ name = "two handed sword", chance = 6952 },
	{ name = "seeds", chance = 8208 },
	{ id = 3307, chance = 6480 },
	{ name = "knife", chance = 6752 },
	{ name = "dragon necklace", chance = 6840 },
	{ name = "magma amulet", chance = 4720 },
	{ name = "wand of dragonbreath", chance = 4088 },
	{ name = "wand of draconia", chance = 4648 },
	{ name = "magma boots", chance = 2824 },
	{ name = "sun fruit", chance = 880 },
	{ name = "bullseye potion", chance = 272 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -430 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_FIREDAMAGE, minDamage = -230, maxDamage = -280, length = 6, spread = 0, effect = CONST_ME_FIREAREA, target = false }, -- long beam
	{ name = "crazed summer chain", interval = 2000, chance = 14, range = 6, target = true }, -- chain
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -280, radius = 4, effect = CONST_ME_EXPLOSIONAREA, target = false }, -- explo ball
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -300, radius = 3, effect = CONST_ME_EXPLOSIONHIT, target = false }, -- eruption box
}

monster.defenses = {
	defense = 20,
	armor = 77,
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_FIREDAMAGE, percent = 70 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 50 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
