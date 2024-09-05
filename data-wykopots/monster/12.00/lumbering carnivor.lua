local mType = Game.createMonsterType("Lumbering Carnivor")
local monster = {}

monster.description = "a Lumbering Carnivor"
monster.experience = 1760
monster.outfit = {
	lookType = 1133,
	lookHead = 85,
	lookBody = 40,
	lookLegs = 86,
	lookFeet = 85,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1721
-- monster.Bestiary = {
-- class = "Magical",
-- race = BESTY_RACE_MAGICAL,
-- toKill = 1000,
-- FirstUnlock = 50,
-- SecondUnlock = 500,
-- CharmsPoints = 25,
-- Stars = 3,
-- Occurrence = 0,
-- Locations = "Carnivora's Rocks."
-- }

monster.health = 2600
monster.maxHealth = 2600
monster.race = "blood"
monster.corpse = 30065
monster.speed = 200
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
	canWalkOnEnergy = true,
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
	{ text = "Me clomping!", yell = false },
	{ text = "Vroosh!!!", yell = false },
	{ text = "Stampede!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 65000, maxCount = 3 },
	{ name = "blue glass plate", chance = 21866, maxCount = 3 },
	{ id = 3264, chance = 5174 },
	{ name = "axe", chance = 14599 },
	{ name = "ice rapier", chance = 6838 },
	{ id = 281, chance = 1768 },
	{ name = "violet gem", chance = 1410 },
	{ name = "green gem", chance = 1618 },
	{ name = "blue gem", chance = 962 },
	{ name = "two handed sword", chance = 1430 },
	{ name = "blue robe", chance = 858 },
	{ name = "glorious axe", chance = 1423 },
	{ name = "green crystal shard", chance = 1118 },
	{ name = "fur armor", chance = 942 },
	{ name = "focus cape", chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
	{ name = "lumbering carnivor wave", interval = 2000, chance = 18, minDamage = -180, maxDamage = -210, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = -160, maxDamage = -190, length = 4, spread = 0, effect = CONST_ME_SMOKE, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -190, maxDamage = -240, range = 7, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = true },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = -120, maxDamage = -200, range = 7, shootEffect = CONST_ANI_CRYSTALLINEARROW, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 65,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
