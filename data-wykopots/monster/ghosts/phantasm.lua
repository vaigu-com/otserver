local mType = Game.createMonsterType("Phantasm")
local monster = {}

monster.description = "a phantasm"
monster.experience = 4400
monster.outfit = {
	lookType = 241,
	lookHead = 20,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 292
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Pits of Inferno, The Inquisition Quest, Deeper Banuta.",
}

monster.health = 3950
monster.maxHealth = 3950
monster.race = "undead"
monster.corpse = 6343
monster.speed = 170
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
	runHealth = 350,
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

monster.summon = {
	maxSummons = 3,
	summons = {
		{ name = "Phantasm Summon", chance = 12, interval = 2000, count = 3 },
		{ name = "Phantasm Summon", chance = 12, interval = 2000, count = 3 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Oh my, you forgot to put your pants on!", yell = false },
	{ text = "Weeheeheeheehee!", yell = false },
	{ text = "Its nothing but a dream!", yell = false },
	{ text = "Give in!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 95000, maxCount = 244 },
	{ name = "platinum coin", chance = 95730, maxCount = 4 },
	{ id = 3147, chance = 22500, maxCount = 2 },
	{ name = "demonic essence", chance = 16820 },
	{ name = "great mana potion", chance = 29750, maxCount = 2 },
	{ id = 7643, chance = 17430 },
	{ id = 3740, chance = 25930 },
	{ id = 3032, chance = 9620, maxCount = 3 },
	{ id = 7414, chance = 460 },
	{ id = 3381, chance = 780 },
	{ id = 3049, chance = 770 },
	{ id = 6299, chance = 470 },
	{ id = 7451, chance = 670 },
	{ id = 3030, chance = 10160, maxCount = 3 },
	{ id = 9057, chance = 12810, maxCount = 3 },
	{ id = 3033, chance = 12770, maxCount = 3 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 84, attack = 100, condition = { type = CONDITION_POISON, totalDamage = 700, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 7, type = COMBAT_DEATHDAMAGE, minDamage = -245, maxDamage = -510, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = -5, maxDamage = -80, radius = 3, effect = CONST_ME_YELLOW_RINGS, target = false },
	{ name = "phantasm drown", interval = 2000, chance = 20, target = false },
	{ name = "drunk", interval = 2000, chance = 15, radius = 5, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.defenses = {
	defense = 80,
	armor = 80,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 225, maxDamage = 450, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 9, speedChange = 568, effect = CONST_ME_MAGIC_RED, target = false, duration = 10000 },
	{ name = "invisible", interval = 2000, chance = 15, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
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
