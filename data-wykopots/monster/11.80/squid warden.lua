local mType = Game.createMonsterType("Squid Warden")
local monster = {}

monster.description = "a squid warden"
monster.experience = 15300
monster.outfit = {
	lookType = 1059,
	lookHead = 9,
	lookBody = 21,
	lookLegs = 3,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1669
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

monster.health = 16500
monster.maxHealth = 16500
monster.race = "blood"
monster.corpse = 28786
monster.speed = 215
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	{ text = "The blood in your veins shall freeze!", yell = false },
}

monster.loot = {
	{ name = "small sapphire", chance = 48750, maxCount = 3 },
	{ name = "platinum coin", chance = 37043, maxCount = 50 },
	{ name = "glowing rune", chance = 26526, maxCount = 6 },
	{ name = "frosty heart", chance = 14950 },
	{ name = "great mana potion", chance = 11700 },
	{ name = "ultimate health potion", chance = 11700 },
	{ id = 28568, chance = 10517 },
	{ id = 7441, chance = 8125 },
	{ name = "ice rapier", chance = 3960 },
	{ name = "crystal sword", chance = 3960 },
	{ name = "piece of dead brain", chance = 3960 },
	{ name = "crystal mace", chance = 3306 },
	{ name = "slime heart", chance = 3250 },
	{ name = "glacier mask", chance = 3250 },
	{ name = "glacier kilt", chance = 2925 },
	{ name = "diamond sceptre", chance = 1950 },
	{ name = "crystalline armor", chance = 975 },
	{ name = "glacier robe", chance = 975 },
	{ name = "leviathan's amulet", chance = 481 },
	{ name = "glacial rod", chance = 195 },
	{ name = "sapphire hammer", chance = 195 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_ICEDAMAGE, minDamage = -500, maxDamage = -600, length = 7, spread = 0, effect = CONST_ME_ICETORNADO, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -600, maxDamage = -850, radius = 4, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -400, maxDamage = -580, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "icicle rune", interval = 2000, chance = 18, minDamage = -600, maxDamage = -800, range = 7, target = false },
}

monster.defenses = {
	defense = 78,
	armor = 78,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
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
