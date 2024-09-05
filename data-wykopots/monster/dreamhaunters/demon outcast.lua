local mType = Game.createMonsterType("Demon Outcast")
local monster = {}

monster.description = "Demon Outcast"
monster.experience = 6200
monster.outfit = {
	lookType = 590,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1019
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Roshamuul Prison.",
}

monster.health = 6900
monster.maxHealth = 6900
monster.race = "blood"
monster.corpse = 20215
monster.speed = 145
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
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "energy elemental", chance = 10, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Back in the evil business!", yell = false },
	{ text = "This prison break will have casualties!", yell = false },
	{ text = "At last someone to hurt", yell = false },
	{ text = "No one will imprison me again!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 6 },
	{ id = 3028, chance = 10000, maxCount = 5 },
	{ id = 3029, chance = 10000, maxCount = 5 },
	{ id = 3030, chance = 12000, maxCount = 5 },
	{ id = 3032, chance = 10000, maxCount = 5 },
	{ id = 3048, chance = 910 },
	{ id = 3049, chance = 1300 },
	{ id = 3055, chance = 1000 },
	{ id = 3098, chance = 3000 },
	{ id = 3281, chance = 2000 },
	{ id = 3284, chance = 660 },
	{ id = 3356, chance = 910 },
	{ id = 3391, chance = 620 },
	{ id = 3419, chance = 940 },
	{ id = 3381, chance = 940 },
	{ id = 3420, chance = 390 },
	{ id = 7382, chance = 100 },
	{ id = 6550, chance = 1000 },
	{ id = 3731, chance = 20600, maxCount = 6 },
	{ name = "assassin star", chance = 8340, maxCount = 10 },
	{ name = "great mana potion", chance = 18000, maxCount = 2 },
	{ id = 7643, chance = 20500, maxCount = 3 },
	{ id = 9057, chance = 9300, maxCount = 5 },
	{ id = 20062, chance = 480 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -300, maxDamage = -450, length = 6, spread = 0, effect = CONST_ME_PURPLEENERGY, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -450, length = 8, spread = 0, effect = CONST_ME_YELLOWENERGY, target = true },
	{ name = "demon outcast skill reducer", interval = 2000, chance = 10, range = 5, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -120, range = 6, radius = 3, effect = CONST_ME_MAGIC_GREEN, target = true },
}

monster.defenses = {
	defense = 49,
	armor = 49,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 200, maxDamage = 300, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -8 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -6 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
