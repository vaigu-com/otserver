local mType = Game.createMonsterType("Vicious Squire")
local monster = {}

monster.description = "a vicious squire"
monster.experience = 900
monster.outfit = {
	lookType = 131,
	lookHead = 97,
	lookBody = 26,
	lookLegs = 71,
	lookFeet = 114,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1145
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

monster.health = 1000
monster.maxHealth = 1000
monster.race = "blood"
monster.corpse = 22017
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
	{ text = "I'll cut you a bloody grin!", yell = false },
	{ text = "You as good as dead!", yell = false },
	{ text = "You shouldn't have come here!", yell = false },
	{ text = "Your stuff will be mine soon!; For hurting me, my sire will kill you!", yell = false },
}

monster.loot = {
	{ id = 3446, chance = 20000, maxCount = 10 },
	{ name = "gold coin", chance = 100000, maxCount = 70 },
	{ name = "great health potion", chance = 6010 },
	{ id = 3577, chance = 10000 },
	{ id = 3349, chance = 13080 },
	{ id = 3048, chance = 430 },
	{ id = 3572, chance = 640 },
	{ id = 3028, chance = 2512 },
	{ id = 3032, chance = 2470 },
	{ id = 3033, chance = 2450 },
	{ id = 3279, chance = 780 },
	{ id = 3269, chance = 2600 },
	{ id = 3415, chance = 340 },
	{ id = 3371, chance = 310 },
	{ id = 3369, chance = 260 },
	{ id = 2995, chance = 50 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -230 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -110, range = 7, shootEffect = CONST_ANI_BOLT, target = false },
}

monster.defenses = {
	defense = 38,
	armor = 30,
	{ name = "combat", interval = 4000, chance = 25, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 40 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = -20 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
