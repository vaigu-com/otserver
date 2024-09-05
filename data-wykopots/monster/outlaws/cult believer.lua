local mType = Game.createMonsterType("Cult Believer")
local monster = {}

monster.description = "a cult believer"
monster.experience = 850
monster.outfit = {
	lookType = 132,
	lookHead = 79,
	lookBody = 77,
	lookLegs = 39,
	lookFeet = 57,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1512
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Forbidden Temple (Carlin).",
}

monster.health = 1100
monster.maxHealth = 1100
monster.race = "blood"
monster.corpse = 111
monster.speed = 130
monster.manaCost = 390

monster.changeTarget = {
	interval = 4000,
	chance = 20,
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
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
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
	{ text = "Death to the unbelievers!", yell = false },
}

monster.loot = { -- avg 75 / 194
	{ name = "gold coin", chance = 100000, maxCount = 70 },
	{ name = "platinum coin", chance = 20000, maxCount = 3 }, -- 30gp
	{ name = "great health potion", chance = 6360 },
	{ id = 3577, chance = 12400 }, -- meat
	{ id = 3572, chance = 920 }, -- scarf
	{ id = 3028, chance = 5000 }, -- small diamond 7.5
	{ id = 3032, chance = 5000 }, -- small emerald
	{ id = 3033, chance = 5000 }, -- small amethyst
	{ id = 2995, chance = 70 }, -- piggy bank
	{ id = 3048, chance = 240 }, -- might ring
	{ id = 9639, chance = 3760 }, -- cultish robe
	{ id = 3326, chance = 500 }, -- epee 40
	{ id = 3428, chance = 350 }, -- epee 28
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200 },
}

monster.defenses = {
	defense = 30,
	armor = 30,
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
