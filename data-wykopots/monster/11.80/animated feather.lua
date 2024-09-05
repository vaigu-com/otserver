local mType = Game.createMonsterType("Animated Feather")
local monster = {}

monster.description = "an animated feather"
monster.experience = 9860
monster.outfit = {
	lookType = 1058,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1671
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "The Secret Library.",
}

monster.health = 13000
monster.maxHealth = 13000
monster.race = "undead"
monster.corpse = 28578
monster.speed = 210
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
	{ text = "scribble scribble", yell = false },
	{ text = "*scraaaatch*", yell = false },
}

monster.loot = {
	{ name = "glowing rune", chance = 55900, maxCount = 5 },
	{ name = "platinum coin", chance = 54600, maxCount = 21 },
	{ name = "small sapphire", chance = 29250, maxCount = 6 },
	{ name = "great mana potion", chance = 14560, maxCount = 2 },
	{ id = 3051, chance = 12025 }, -- energy ring
	{ name = "quill", chance = 11336 },
	{ id = 7441, chance = 11050 },
	{ name = "diamond sceptre", chance = 5089 },
	{ name = "glacier mask", chance = 4394 },
	{ name = "small diamond", chance = 3009, maxCount = 6 },
	{ name = "golden mug", chance = 2775 },
	{ name = "life crystal", chance = 2541 },
	{ name = "crystal mace", chance = 2080 },
	{ name = "glacier amulet", chance = 2080 },
	{ name = "hailstorm rod", chance = 1852 },
	{ name = "crystalline armor", chance = 130 },
	{ name = "leviathan's amulet", chance = 130 },
	{ name = "sapphire hammer", chance = 130 },
	{ name = "shard", chance = 325 },
	{ name = "glacial rod", chance = 130 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "strong ice wave", interval = 2000, chance = 13, minDamage = -800, maxDamage = -1150, target = false },
	{ name = "icicle rune", interval = 2000, chance = 18, minDamage = -600, maxDamage = -800, range = 7, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -500, maxDamage = -850, radius = 3, effect = CONST_ME_ICETORNADO, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -500, maxDamage = -850, range = 5, radius = 4, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true },
}

monster.defenses = {
	defense = 72,
	armor = 72,
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -18 },
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
