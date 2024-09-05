local mType = Game.createMonsterType("Draken Elite")
local monster = {}

monster.description = "a draken elite"
monster.experience = 4200
monster.outfit = {
	lookType = 362,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 672
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Razachai, including the Crystal Column chambers in the Inner Sanctum.",
}

monster.health = 5550
monster.maxHealth = 5550
monster.race = "blood"
monster.corpse = 11653
monster.speed = 166
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
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
	canPushCreatures = false,
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
	{ text = "For ze emperor!", yell = false },
	{ text = "You will die zhouzandz deazhz!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 96000, maxCount = 200 },
	{ name = "platinum coin", chance = 50360, maxCount = 8 },
	{ id = 11661, chance = 24670 },
	{ id = 3577, chance = 30175 },
	{ name = "great mana potion", chance = 9340, maxCount = 3 },
	{ id = 3028, chance = 2410, maxCount = 4 },
	{ id = 11659, chance = 14030 },
	{ id = 11660, chance = 17730 },
	{ id = 7643, chance = 9250, maxCount = 3 },
	{ id = 11658, chance = 7770 },
	{ id = 11657, chance = 810 },
	{ id = 5904, chance = 2100 },
	{ id = 7404, chance = 990 },
	{ id = 10390, chance = 530 },
	{ id = 4033, chance = 530 },
	{ id = 11693, chance = 60 },
	{ id = 11674, chance = 10 },
	{ id = 10385, chance = 220 },
	{ id = 10387, chance = 840 },
	{ id = 10384, chance = 630 },
	{ id = 11691, chance = 40 },
	{ id = 11651, chance = 110 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "lizard wave 2", interval = 2000, chance = 10, minDamage = -400, maxDamage = -550, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -300, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -380, maxDamage = -410, range = 4, radius = 4, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_POFF, target = true },
	{ name = "draken elite soulfire", interval = 2000, chance = 11, range = 7, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 11, minDamage = -200, maxDamage = -320, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_GREEN_RINGS, target = true },
}

monster.defenses = {
	defense = 60,
	armor = 60,
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 310, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 40 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
