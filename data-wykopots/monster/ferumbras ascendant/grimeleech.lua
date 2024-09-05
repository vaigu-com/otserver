local mType = Game.createMonsterType("Grimeleech")
local monster = {}

monster.description = "a grimeleech"
monster.experience = 6560
monster.outfit = {
	lookType = 855,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1196
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

monster.health = 9500
monster.maxHealth = 9500
monster.race = "undead"
monster.corpse = 22780
monster.speed = 170
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
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
	{ text = "Death!", yell = true },
	{ text = "Come a little closer!", yell = true },
	{ text = "The end is near!", yell = true },
}

monster.loot = {
	{ name = "platinum coin", chance = 89000, maxCount = 10 },
	{ name = "great mana potion", chance = 23919, maxCount = 3 },
	{ name = "great health potion", chance = 23905, maxCount = 3 },
	{ id = 7642, chance = 22400, maxCount = 3 },
	{ name = "flask of demonic blood", chance = 17500 },
	{ name = "demonic essence", chance = 14000 },
	{ id = 22730, chance = 13972 },
	{ id = 3731, chance = 10500, maxCount = 5 },
	{ id = 3732, chance = 10500, maxCount = 4 },
	{ id = 3033, chance = 7000, maxCount = 5 },
	{ id = 3028, chance = 6930, maxCount = 5 },
	{ id = 3030, chance = 6930, maxCount = 5 },
	{ id = 9057, chance = 7000, maxCount = 5 },
	{ id = 8082, chance = 5250 },
	{ id = 8094, chance = 3500 },
	{ id = 3039, chance = 2100 },
	{ id = 3037, chance = 2100 },
	{ id = 821, chance = 910 },
	{ id = 3041, chance = 658 },
	{ id = 3420, chance = 644 },
	{ id = 22727, chance = 623 },
	{ id = 3356, chance = 602 },
	{ id = 7418, chance = 546 },
	{ id = 22726, chance = 462 },
	{ id = 22866, chance = 343 },
	{ id = 22867, chance = 329 },
	{ name = "steel boots", chance = 210 },
	{ id = 7414, chance = 161 },
	{ name = "vile axe", chance = 133 },
	{ id = 3366, chance = 70 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_LIFEDRAIN, minDamage = -50, maxDamage = -200, range = 7, shootEffect = CONST_ANI_GREENSTAR, target = true },
	{ name = "drunk", interval = 2000, chance = 8, radius = 4, shootEffect = CONST_ANI_GLOOTHSPEAR, effect = CONST_ME_STUN, target = true, duration = 4000 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -550, maxDamage = -950, length = 5, spread = 0, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -250, length = 8, spread = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -350, maxDamage = -400, radius = 4, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 65,
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HEALING, minDamage = 200, maxDamage = 300, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "effect", interval = 2000, chance = 9, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "effect", interval = 2000, chance = 10, target = false },
	{ name = "speed", interval = 2000, chance = 12, speedChange = 532, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 60 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
