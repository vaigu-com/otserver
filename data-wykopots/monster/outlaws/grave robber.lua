local mType = Game.createMonsterType("Grave Robber")
local monster = {}

monster.description = "a grave robber"
monster.experience = 65
monster.outfit = {
	lookType = 146,
	lookHead = 114,
	lookBody = 95,
	lookLegs = 76,
	lookFeet = 38,
	lookAddons = 3,
	lookMount = 0,
}

monster.raceId = 867
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 2,
	Locations = "Horestis Tomb.",
}

monster.health = 165
monster.maxHealth = 165
monster.race = "blood"
monster.corpse = 18130
monster.speed = 102
monster.manaCost = 355

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
	convinceable = true,
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 15,
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
	{ text = "This crypt is taken!", yell = false },
	{ text = "Leave or you are hunted!", yell = false },
	{ text = "The treasure will be mine!", yell = false },
	{ text = "The X marks the spot!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 54260, maxCount = 38 },
	{ id = 3274, chance = 2500 },
	{ id = 3286, chance = 1700 },
	{ id = 3359, chance = 1700 },
	{ id = 3409, chance = 500 },
	{ id = 3353, chance = 500 },
	{ id = 11492, chance = 7510 },
	{ id = 8010, chance = 5680, maxCount = 3 },
	{ id = 7533, chance = 170 },
	{ id = 11456, chance = 1700 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 35, attack = 40 },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -100, maxDamage = -160, range = 7, radius = 1, shootEffect = CONST_ANI_POISON, target = true },
}

monster.defenses = {
	defense = 15,
	armor = 15,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
