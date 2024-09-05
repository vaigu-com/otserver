local mType = Game.createMonsterType("Burning Book")
local monster = {}

monster.description = "a burning book"
monster.experience = 11934
monster.outfit = {
	lookType = 1061,
	lookHead = 79,
	lookBody = 112,
	lookLegs = 78,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1663
-- monster.Bestiary = {
-- class = "Magical",
-- race = BESTY_RACE_MAGICAL,
-- toKill = 2500,
-- FirstUnlock = 100,
-- SecondUnlock = 1000,
-- CharmsPoints = 50,
-- Stars = 4,
-- Occurrence = 0,
-- Locations = "Secret Library."
-- }

monster.health = 18000
monster.maxHealth = 18000
monster.race = "undead"
monster.corpse = 28754
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
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
	{ text = "Aaaah... Burning passion can be fatal!", yell = false },
}

monster.loot = {
	{ name = "flask of demonic blood", chance = 35964 },
	{ name = "platinum coin", chance = 52000, maxCount = 35 },
	{ name = "book page", chance = 42445, maxCount = 4 },
	{ name = "demonic essence", chance = 16250 },
	{ name = "silken bookmark", chance = 15860 },
	{ name = "magma coat", chance = 9100 },
	{ name = "small amethyst", chance = 4914, maxCount = 7 },
	{ name = "necrotic rod", chance = 3373 },
	{ name = "guardian shield", chance = 3796 },
	{ id = 3307, chance = 3575 },
	{ name = "soul orb", chance = 3126 },
	{ id = 6299, chance = 1320 },
	{ name = "magma monocle", chance = 650 },
	{ id = 3049, chance = 221 }, -- stealth ring
	{ name = "shadow sceptre", chance = 195 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_FIREDAMAGE, minDamage = -750, maxDamage = -950, length = 8, spread = 0, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_FIREDAMAGE, minDamage = -700, maxDamage = -950, radius = 3, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "fireball rune", interval = 2000, chance = 22, minDamage = -800, maxDamage = -1100, range = 7, target = false },
}

monster.defenses = {
	defense = 82,
	armor = 82,
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 150, maxDamage = 350, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
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
