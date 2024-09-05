local mType = Game.createMonsterType("Hellflayer")
local monster = {}

monster.description = "a hellflayer"
monster.experience = 10000
monster.outfit = {
	lookType = 856,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1198
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "The Dungeons of The Ruthless Seven.",
}

monster.health = 14000
monster.maxHealth = 14000
monster.race = "blood"
monster.corpse = 22784
monster.speed = 165
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
	staticAttackChance = 85,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You should consider bargaining for you life!", yell = false },
	{ text = "Your tainted soul belongs to us anyway!", yell = false },
	{ text = "Today I deal only in death!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 89000, maxCount = 12 },
	{ name = "flask of demonic blood", chance = 20300, maxCount = 2 },
	{ name = "gold ingot", chance = 5810, maxCount = 2 },
	{ name = "great mana potion", chance = 14000, maxCount = 5 },
	{ id = 7642, chance = 13300, maxCount = 5 },
	{ id = 3033, chance = 7000, maxCount = 5 },
	{ id = 3028, chance = 6300, maxCount = 5 },
	{ id = 3032, chance = 7000, maxCount = 5 },
	{ id = 3030, chance = 7000, maxCount = 5 },
	{ id = 9057, chance = 7000, maxCount = 5 },
	{ id = 7643, chance = 12600, maxCount = 5 },
	{ id = 3019, chance = 154 },
	{ name = "demonic essence", chance = 17500 },
	{ id = 281, chance = 3500 },
	{ id = 3038, chance = 700 },
	{ id = 818, chance = 826 },
	{ id = 821, chance = 931 },
	{ id = 3414, chance = 301 },
	{ id = 22729, chance = 14000 },
	{ id = 3039, chance = 2100 },
	{ id = 3036, chance = 1050 },
	{ id = 22866, chance = 420 },
	{ id = 22867, chance = 357 },
	{ id = 5741, chance = 406 },
	{ id = 22727, chance = 700 },
	{ id = 7413, chance = 700 },
	{ id = 3360, chance = 2562 },
	{ id = 8074, chance = 77 },
	{ id = 3340, chance = 63 },
	{ id = 22726, chance = 588 },
	{ id = 3366, chance = 161 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -850 },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_FIREDAMAGE, minDamage = -450, maxDamage = -650, range = 7, shootEffect = CONST_ANI_FLAMMINGARROW, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -850, maxDamage = -1250, length = 6, spread = 0, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -550, radius = 1, shootEffect = CONST_ANI_THROWINGSTAR, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -500, range = 7, radius = 4, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_EXPLOSIONAREA, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -550, radius = 5, effect = CONST_ME_GROUNDSHAKER, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_HEALING, minDamage = 150, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 70 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
