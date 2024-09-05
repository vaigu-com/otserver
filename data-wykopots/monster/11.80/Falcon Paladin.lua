local mType = Game.createMonsterType("Falcon Paladin")
local monster = {}

monster.description = "a falcon paladin"
monster.experience = 6544
monster.outfit = {
	lookType = 1071,
	lookHead = 57,
	lookBody = 96,
	lookLegs = 38,
	lookFeet = 105,
	lookAddons = 2,
	lookMount = 0,
}

monster.raceId = 1647
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Falcon Bastion.",
}

monster.health = 8500
monster.maxHealth = 8500
monster.race = "undead"
monster.corpse = 28862
monster.speed = 110
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
	illusionable = true,
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
	{ text = "Repent Heretic!", yell = false },
	{ text = "Uuunngh!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 80000, maxCount = 5 },
	{ name = "great spirit potion", chance = 31856, maxCount = 2 },
	{ name = "assassin star", chance = 20432, maxCount = 10 },
	{ name = "small amethyst", chance = 32000, maxCount = 2 },
	{ name = "small diamond", chance = 31888, maxCount = 2 },
	{ name = "small emerald", chance = 32264, maxCount = 2 },
	{ name = "small ruby", chance = 16320, maxCount = 2 },
	{ name = "onyx arrow", chance = 11792, maxCount = 15 },
	{ name = "small topaz", chance = 16144, maxCount = 2 },
	{ id = 281, chance = 1440 },
	{ id = 28822, chance = 864 },
	{ name = "green gem", chance = 4016 },
	{ name = "violet gem", chance = 3720 },
	{ id = 3039, chance = 5296 },
	{ name = "golden armor", chance = 352 },
	{ name = "falcon crest", chance = 584 },
	{ name = "mastermind shield", chance = 300 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -500, range = 7, shootEffect = CONST_ANI_BOLT, target = true },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -550, range = 6, shootEffect = CONST_ANI_ROYALSPEAR, target = true },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_ENERGYDAMAGE, minDamage = -350, maxDamage = -450, radius = 3, shootEffect = CONST_ANI_POWERBOLT, effect = CONST_ME_ENERGYAREA, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -250, maxDamage = -350, length = 4, spread = 0, effect = CONST_ME_ENERGYHIT, target = false },
}

monster.defenses = {
	defense = 82,
	armor = 82,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 55 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
