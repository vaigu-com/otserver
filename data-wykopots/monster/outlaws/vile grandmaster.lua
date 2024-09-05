local mType = Game.createMonsterType("Vile Grandmaster")
local monster = {}

monster.description = "a vile grandmaster"
monster.experience = 1500
monster.outfit = {
	lookType = 268,
	lookHead = 97,
	lookBody = 0,
	lookLegs = 95,
	lookFeet = 94,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1147
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Old Fortress (north of Edron), Old Masonry, Forbidden Temple (Carlin).",
}

monster.health = 1700
monster.maxHealth = 1700
monster.race = "blood"
monster.corpse = 22023
monster.speed = 140
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
	{ text = "I will end this now!", yell = false },
	{ text = "I've seen orcs though than you!", yell = false },
	{ text = "Your gods won't help you!", yell = false },
	{ text = "Is that the best, they can throw at me?", yell = false },
	{ text = "You'll make a fine trophy!", yell = false },
	{ text = "Let's have a fight!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 175 },
	{ name = "platinum coin", chance = 74680, maxCount = 2 },
	{ id = 3577, chance = 9760, maxCount = 2 },
	{ name = "great health potion", chance = 6900 },
	{ id = 11510, chance = 7550 },
	{ id = 11450, chance = 2480 },
	{ id = 3030, chance = 3550 },
	{ id = 3029, chance = 3540 },
	{ id = 3004, chance = 5120 },
	{ id = 5911, chance = 1960 },
	{ id = 3279, chance = 2040 },
	{ id = 3381, chance = 1010 },
	{ id = 3280, chance = 710 },
	{ id = 3385, chance = 790 },
	{ id = 3419, chance = 310 },
	{ id = 3382, chance = 750 },
	{ id = 3055, chance = 430 },
	{ id = 2995, chance = 190 },
}

monster.attacks = {
	{ name = "combat", interval = 1000, chance = 8, type = COMBAT_PHYSICALDAMAGE, minDamage = -75, maxDamage = -125, radius = 6, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -260 },
	-- bleed
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 17, minDamage = -150, maxDamage = -225, radius = 1, shootEffect = CONST_ANI_THROWINGKNIFE, target = true },
}

monster.defenses = {
	defense = 40,
	armor = 40,
	{ name = "combat", interval = 4000, chance = 15, type = COMBAT_HEALING, minDamage = 220, maxDamage = 280, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = 25 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
