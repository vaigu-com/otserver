local mType = Game.createMonsterType("Knowledge Elemental")
local monster = {}

monster.description = "a knowledge elemental"
monster.experience = 10710
monster.outfit = {
	lookType = 1065,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1670
-- monster.Bestiary = {
-- class = "Elemental",
-- race = BESTY_RACE_ELEMENTAL,
-- toKill = 2500,
-- FirstUnlock = 100,
-- SecondUnlock = 1000,
-- CharmsPoints = 50,
-- Stars = 4,
-- Occurrence = 1,
-- Locations = "Secret Library."
-- }

monster.health = 10500
monster.maxHealth = 10500
monster.race = "undead"
monster.corpse = 28606
monster.speed = 230
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
	{ text = "Did you know... you could die in 1.299.223 ways?", yell = false },
	{ text = "Did you know... there are over 200 bones in your body to break?", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 65000, maxCount = 20 },
	{ name = "small amethyst", chance = 65000, maxCount = 6 },
	{ name = "silken bookmark", chance = 15600 },
	{ name = "quill", chance = 19500 },
	{ name = "book page", chance = 32500, maxCount = 5 },
	{ name = "glowing rune", chance = 22100, maxCount = 8 },
	{ name = "mana potion", chance = 7800 },
	{ name = "flash arrow", chance = 14300, maxCount = 13 },
	{ id = 3051, chance = 9750 }, -- energy ring
	{ name = "wand of cosmic energy", chance = 4030 },
	{ name = "throwing star", chance = 7150, maxCount = 10 },
	{ name = "guardian shield", chance = 3250 },
	{ name = "crystal sword", chance = 3445 },
	{ name = "ultimate health potion", chance = 14300, maxCount = 2 },
	{ name = "great mana potion", chance = 16575 },
	{ name = "lightning pendant", chance = 780 },
	{ id = 3007, chance = 1170 },
	{ name = "might ring", chance = 1040 },
	{ name = "silver amulet", chance = 2600 },
	{ name = "obsidian lance", chance = 585 },
	{ name = "wand of defiance", chance = 195 },
	{ name = "spellweaver's robe", chance = 195 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HOLYDAMAGE, minDamage = -500, maxDamage = -750, length = 6, spread = 0, effect = CONST_ME_HOLYDAMAGE, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HOLYDAMAGE, minDamage = -300, maxDamage = -450, range = 4, radius = 3, shootEffect = CONST_ANI_HOLY, effect = CONST_ME_HOLYDAMAGE, target = true },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_PHYSICALDAMAGE, minDamage = -450, maxDamage = -650, radius = 2, effect = CONST_ME_BLOCKHIT, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_ENERGYDAMAGE, minDamage = -320, maxDamage = -780, radius = 2, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "divine missile", interval = 2000, chance = 20, minDamage = -450, maxDamage = -700, range = 6, target = false },
}

monster.defenses = {
	defense = 76,
	armor = 76,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = -20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
