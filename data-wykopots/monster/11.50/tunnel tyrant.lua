local mType = Game.createMonsterType("Tunnel Tyrant")
local monster = {}

monster.description = "a tunnel tyrant"
monster.experience = 4000
monster.outfit = {
	lookType = 1035,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1545
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Warzone 5.",
}

monster.health = 5200
monster.maxHealth = 5200
monster.race = "blood"
monster.corpse = 27555
monster.speed = 120
monster.manaCost = 450

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
	canPushCreatures = false,
	staticAttackChance = 85,
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
}

monster.loot = {
	{ name = "tunnel tyrant shell", chance = 22100 },
	{ name = "tunnel tyrant head", chance = 13920 },
	{ name = "small enchanted sapphire", chance = 11110 },
	{ name = "lump of dirt", chance = 9770 },
	{ name = "small enchanted ruby", chance = 9280 },
	{ name = "violet gem", chance = 5740 },
	{ id = 23508, chance = 3910 }, -- energy vein
	{ name = "blue gem", chance = 2440 },
	{ name = "crystal mace", chance = 1710 },
	{ name = "green gem", chance = 1500 },
	{ name = "suspicious device", chance = 330 },
	{ name = "crystalline armor", chance = 120 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "stalagmite rune", interval = 2000, chance = 18, minDamage = -170, maxDamage = -230, range = 7, target = true },
	{ name = "fireball rune", interval = 2000, chance = 18, minDamage = -160, maxDamage = -200, range = 7, target = true },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_PHYSICALDAMAGE, minDamage = -230, maxDamage = -270, range = 6, radius = 4, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_GROUNDSHAKER, target = true },
	{ name = "combat", interval = 4000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -220, maxDamage = -260, length = 7, spread = 3, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 76,
	armor = 76,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
