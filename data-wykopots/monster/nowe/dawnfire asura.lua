local mType = Game.createMonsterType("Dawnfire Asura")
local monster = {}

monster.description = "a dawnfire asura"
monster.experience = 3200
monster.outfit = {
	lookType = 150,
	lookHead = 114,
	lookBody = 94,
	lookLegs = 78,
	lookFeet = 79,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1134
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Asura Palace.",
}

monster.health = 2900
monster.maxHealth = 2900
monster.race = "blood"
monster.corpse = 21987
monster.speed = 140
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 12,
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
	{ text = "Encounter the flames of destiny!", yell = false },
	{ text = "Fire and destruction!", yell = true },
	{ text = "I will end your torment. Do not run, little mortal.", yell = false },
	{ text = "Join me, brothers, for a BLOODY FRENZY!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 65000, maxCount = 100 },
	{ name = "platinum coin", chance = 65000, maxCount = 9 },
	{ name = "flask of demonic blood", chance = 18850 },
	{ name = "great mana potion", chance = 7728, maxCount = 2 },
	{ id = 3033, chance = 2860, maxCount = 2 },
	{ id = 3028, chance = 2905, maxCount = 2 },
	{ id = 3032, chance = 2944, maxCount = 2 },
	{ id = 3030, chance = 5070, maxCount = 3 },
	{ id = 9057, chance = 2964, maxCount = 2 },
	{ id = 3041, chance = 234 },
	{ id = 6299, chance = 318 },
	{ name = "demonic essence", chance = 9750 },
	{ id = 8043, chance = 786 },
	{ id = 21974, chance = 11817 },
	{ id = 826, chance = 474 },
	{ id = 3078, chance = 955 },
	{ id = 3574, chance = 1917 },
	{ id = 21981, chance = 240 },
	{ id = 21975, chance = 10497 },
	{ id = 5911, chance = 2015 },
	{ id = 3016, chance = 676 },
	{ id = 3039, chance = 793 },
	{ name = "soul orb", chance = 12870 },
	{ id = 8074, chance = 188 },
	{ id = 3071, chance = 981 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -252 },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -252, range = 6, target = false },
	{ name = "dawnfire asura fire", interval = 4000, chance = 10, range = 6, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -200, length = 8, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "flame strike", interval = 2000, chance = 20, minDamage = 0, maxDamage = -175, range = 1, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -700, radius = 3, effect = CONST_ME_SMALLCLOUDS, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_DEATHDAMAGE, minDamage = 0, maxDamage = -320, radius = 6, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -135, range = 7, shootEffect = CONST_ANI_WHIRLWINDSWORD, target = false },
}

monster.defenses = {
	defense = 48,
	armor = 48,
	{ name = "dawnfire asura reducer magic", interval = 4000, chance = 10, range = 1, radius = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 80, maxDamage = 125, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 220, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
