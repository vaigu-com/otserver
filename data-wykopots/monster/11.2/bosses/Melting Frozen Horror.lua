local mType = Game.createMonsterType("Melting Frozen Horror")
local monster = {}

monster.description = "an Melting Frozen Horror"
monster.experience = 65000
monster.outfit = {
	lookType = 261,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 25000
monster.maxHealth = 25000
monster.race = "undead"
monster.corpse = 7282
monster.speed = 143
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5,
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
	staticAttackChance = 50,
	targetDistance = 1,
	runHealth = 0,
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

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "gold coin", chance = 100000, maxCount = 11 },
	{ id = 9661, chance = 14111 },
	{ id = 7441, chance = 5100 },
	{ id = 3029, chance = 560 },
	{ id = 236, chance = 2444 },
	{ id = 237, chance = 3044 },
	{ id = 3284, chance = 320 },
	{ id = 7290, chance = 210 },
	{ id = 7449, chance = 580 },
	{ id = 3028, chance = 730 },
	{ id = 16119, chance = 9660, maxCount = 5 },
	{ id = 16120, chance = 9660, maxCount = 5 },
	{ id = 3041, chance = 5000 },
	{ id = 22516, chance = 1970 },
	{ id = 7643, chance = 19500, maxCount = 3 },
	{ id = 16121, chance = 9660, maxCount = 5 },
	{ id = 7459, chance = 9660 },
	{ id = 23518, chance = 9660 },
	{ id = 24965, chance = 9660 },
	{ id = 24966, chance = 9660 },
	{ id = 3067, chance = 9660 },
	{ id = 5892, chance = 9660 },
	{ id = 3333, chance = 9660 },
	{ id = 16160, chance = 9660 },
	{ id = 16175, chance = 9660 },
	{ id = 14247, chance = 9660 },
	{ id = 8059, chance = 9660 },
	{ id = 3332, chance = 9660 },
	{ id = 24946, chance = 9660 },
	{ id = 19363, chance = 9660 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 100, attack = 40 },
}

monster.defenses = {
	defense = 26,
	armor = 25,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 100 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
