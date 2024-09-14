local mType = Game.createMonsterType("Snake God Follower")
local monster = {}

monster.description = "a snake god follower"
monster.experience = 1950
monster.outfit = {
	lookType = 356,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2583
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Vaux Mach mountain range on Ganymede.",
}

monster.health = 2500
monster.maxHealth = 2500
monster.race = "blood"
monster.corpse = 6061
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 60,
	health = 15,
	damage = 15,
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
	staticAttackChance = 95,
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
	{ text = "AHHH ZHE POWER...", yell = true },
	{ text = "ZHE TIME OF ZHE SNAKE HAZ COME!", yell = true },
}

monster.loot = {
	{ name = "small ruby", chance = 6640, maxCount = 5 },
	{ name = "platinum coin", chance = 50590, maxCount = 3 },
	{ name = "great mana potion", chance = 9950, maxCount = 5 },
	{ name = "terra hood", chance = 2310 },
	{ name = "wand of voodoo", chance = 1020 },
	{ name = "small topaz", chance = 2900, maxCount = 4 },
	{ name = "luminous orb", chance = 2580 },
	{ name = "green gem", chance = 1290 },
	{ name = "focus cape", chance = 740 },
	{ name = "spellweaver's robe", chance = 740 },
	{ name = "ring of the sky", chance = 120 },
	{ name = "snake god's wristguard", chance = 10 },
	{ name = "snake god's sceptre", chance = 10 },
	{ name = "snake god trophy", chance = 10}
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -150 },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -150, length = 8, spread = 0, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_EARTHDAMAGE, minDamage = -120, maxDamage = -170, radius = 6, effect = CONST_ME_MAGIC_GREEN, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 70,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
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