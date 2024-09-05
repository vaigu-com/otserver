local mType = Game.createMonsterType("Retching Horror")
local monster = {}

monster.description = "Retching Horror"
monster.experience = 3900
monster.outfit = {
	lookType = 588,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1018
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "All over the surface of Upper Roshamuul and Nightmare Isles.",
}

monster.health = 5300
monster.maxHealth = 5300
monster.race = "fire"
monster.corpse = 20174
monster.speed = 180
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Wait for us, little maggot...", yell = false },
	{ text = "We will devour you...", yell = false },
	{ text = "My little beetles, go forth, eat, feast!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 75000, maxCount = 10 },
	{ id = 3280, chance = 1155 },
	{ id = 3419, chance = 1125 },
	{ id = 3428, chance = 1012 },
	{ id = 20029, chance = 2775 },
	{ id = 3725, chance = 14000, maxCount = 2 },
	{ id = 3344, chance = 3720 },
	{ id = 7452, chance = 1132 },
	{ id = 7386, chance = 2062 },
	{ name = "great mana potion", chance = 12500 },
	{ name = "great health potion", chance = 15000 },
	{ id = 8082, chance = 1050 },
	{ id = 8092, chance = 1470 },
	{ id = 20205, chance = 12300 },
	{ id = 20207, chance = 11250 },
	{ name = "steel boots", chance = 195 },
	{ id = 7421, chance = 540 },
	{ name = "butcher's axe", chance = 472 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -400 }, --Podstawowy
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -200, range = 6, shootEffect = CONST_ANI_SNIPERARROW, target = true }, -- arrow
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_FIREDAMAGE, length = 4, spread = 3, minDamage = -200, maxDamage = -400, effect = CONST_ME_MAGIC_GREEN, target = false }, -- star wave
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -300, radius = 4, effect = CONST_ME_HITAREA, target = false }, -- dizzy ball
	{ name = "speed", interval = 2000, chance = 12, speedChange = -700, radius = 4, shootEffect = CONST_ANI_WHIRLWINDCLUB, effect = CONST_ME_STUN, target = true, duration = 15000 }, -- paral
}

monster.defenses = {
	defense = 74,
	armor = 74,
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 100, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 85 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 22 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
