local mType = Game.createMonsterType("Glooth Bandit")
local monster = {}

monster.description = "a glooth bandit"
monster.experience = 2400
monster.outfit = {
	lookType = 129,
	lookHead = 115,
	lookBody = 80,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1119
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Underground Glooth Factory.",
}

monster.health = 2600
monster.maxHealth = 2600
monster.race = "blood"
monster.corpse = 21882
monster.speed = 150
monster.manaCost = 450

monster.changeTarget = {
	interval = 5000,
	chance = 5,
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
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
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
	{ name = "gold coin", chance = 44100, maxCount = 100 },
	{ name = "platinum coin", chance = 54000, maxCount = 3 },
	{ name = "glooth capsule", chance = 2900 },
	{ name = "tainted glooth capsule", chance = 8000 },
	{ id = 9057, chance = 2250, maxCount = 2 },
	{ id = 21203, chance = 3213 },
	{ id = 21143, chance = 2250 },
	{ id = 21146, chance = 2340 },
	{ name = "great health potion", chance = 7110, maxCount = 3 },
	{ name = "great mana potion", chance = 6660, maxCount = 3 },
	{ id = 7642, chance = 3060, maxCount = 3 },
	{ id = 21180, chance = 927 },
	{ id = 21158, chance = 900 },
	{ id = 7643, chance = 3060 },
	{ id = 3344, chance = 720 },
	{ id = 21183, chance = 900 },
	{ id = 21179, chance = 900 },
	{ id = 21164, chance = 522 },
	{ id = 21178, chance = 900 },
	{ id = 3038, chance = 1440 },
	{ id = 3324, chance = 378 },
	{ id = 830, chance = 540 },
	{ id = 812, chance = 450 },
	{ id = 811, chance = 540 },
	{ id = 3032, chance = 1800, maxCount = 2 },
	{ id = 21165, chance = 657 },
	{ id = 3342, chance = 900 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -320 },
	{ name = "combat", interval = 2000, chance = 33, type = COMBAT_PHYSICALDAMAGE, minDamage = -60, maxDamage = -200, range = 7, shootEffect = CONST_ANI_ARROW, target = false },
}

monster.defenses = {
	defense = 46,
	armor = 46,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 200, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
