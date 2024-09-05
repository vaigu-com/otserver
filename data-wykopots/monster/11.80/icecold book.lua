local mType = Game.createMonsterType("Icecold Book")
local monster = {}

monster.description = "a icecold book"
monster.experience = 12750
monster.outfit = {
	lookType = 1061,
	lookHead = 87,
	lookBody = 66,
	lookLegs = 79,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1664
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

monster.health = 21000
monster.maxHealth = 21000
monster.race = "undead"
monster.corpse = 28774
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
	{ text = "The temperatue drops sub zero!", yell = false },
	{ text = "grawuz grawuz grawuz!", yell = false },
}

monster.loot = {
	{ id = 7441, chance = 1982 },
	{ name = "platinum coin", chance = 65000, maxCount = 35 },
	{ name = "book page", chance = 44200 },
	{ name = "small diamond", chance = 33488 },
	{ name = "small sapphire", chance = 19630, maxCount = 9 },
	{ name = "ultimate health potion", chance = 14352 },
	{ name = "great mana potion", chance = 14020 },
	{ name = "ice rapier", chance = 13364 },
	{ name = "silken bookmark", chance = 12207 },
	{ name = "quill", chance = 11219 },
	{ name = "glacier mask", chance = 8248 },
	{ name = "frosty heart", chance = 8086 },
	{ name = "diamond sceptre", chance = 4452 },
	{ name = "glacier kilt", chance = 4127 },
	{ name = "glacier shoes", chance = 4127 },
	{ name = "crystal mace", chance = 1625 },
	{ name = "glacier robe", chance = 1430 },
	{ name = "strange helmet", chance = 1170 },
	{ name = "crystalline armor", chance = 845 },
	{ name = "sapphire hammer", chance = 650 },
	{ name = "glacial rod", chance = 162 },
	{ name = "leviathan's amulet", chance = 130 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_ICEDAMAGE, minDamage = -800, maxDamage = -1350, length = 7, spread = 0, effect = CONST_ME_ICEAREA, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_ICEDAMAGE, minDamage = -700, maxDamage = -900, radius = 3, effect = CONST_ME_ICETORNADO, target = false },
	{ name = "icicle rune", interval = 2000, chance = 22, minDamage = -700, maxDamage = -850, range = 7, target = false },
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
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
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
