local mType = Game.createMonsterType("Hellspawn")
local monster = {}

monster.description = "a hellspawn"
monster.experience = 2550
monster.outfit = {
	lookType = 322,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 519
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Magician Quarter, Vengoth, Deeper Banuta, Formorgar Mines, Chyllfroest, Oramond Dungeon.",
}

monster.health = 3500
monster.maxHealth = 3500
monster.race = "fire"
monster.corpse = 9009
monster.speed = 172
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 15,
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
	{ text = "Your fragile bones are like toothpicks to me.", yell = false },
	{ text = "You little weasel will not live to see another day.", yell = false },
	{ text = "I'm just a messenger of what's yet to come.", yell = false },
	{ text = "HRAAAAAAAAAAAAAAAARRRR", yell = true },
	{ text = "I'm taking you down with me!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 99000, maxCount = 238 },
	{ name = "great health potion", chance = 39770 },
	{ id = 10304, chance = 20000 },
	{ id = 3301, chance = 10000 },
	{ id = 3282, chance = 10000 },
	{ name = "assassin star", chance = 9900, maxCount = 2 },
	{ id = 7643, chance = 9090 },
	{ name = "demonic essence", chance = 9090 },
	{ id = 3724, chance = 8000, maxCount = 2 },
	{ id = 9057, chance = 6020, maxCount = 3 },
	{ id = 8896, chance = 3190 },
	{ id = 8895, chance = 3190 },
	{ id = 3371, chance = 3030 },
	{ id = 3369, chance = 2020 },
	{ id = 7452, chance = 800 },
	{ id = 7439, chance = 934 },
	{ id = 9056, chance = 200 },
	{ id = 9034, chance = 140 },
	{ id = 7421, chance = 103 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "fireball rune", interval = 2000, chance = 20, minDamage = -150, maxDamage = -175, target = false },
	{ name = "hellspawn soulfire", interval = 2000, chance = 10, range = 7, target = false },
}

monster.defenses = {
	defense = 44,
	armor = 44,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 120, maxDamage = 230, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 9, speedChange = 476, effect = CONST_ME_MAGIC_RED, target = false, duration = 3000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 80 },
	{ type = COMBAT_FIREDAMAGE, percent = 40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
