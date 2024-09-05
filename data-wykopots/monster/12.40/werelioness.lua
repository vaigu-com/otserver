local mType = Game.createMonsterType("Werelioness")
local monster = {}

monster.description = "a werelioness"
monster.experience = 2300
monster.outfit = {
	lookType = 1301,
	lookHead = 58,
	lookBody = 2,
	lookLegs = 94,
	lookFeet = 94,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1966
monster.Bestiary = {
	class = "Lycanthrope",
	race = BESTY_RACE_LYCANTHROPE,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 3,
	Occurrence = 0,
	Locations = "This monster we can find in Hyaena Lairs.",
}

monster.health = 3000
monster.maxHealth = 3000
monster.race = "blood"
monster.corpse = 34185
monster.speed = 105
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 20,
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
	runHealth = 5,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 1,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 5 },
	{ name = "gold coin", chance = 100000, maxCount = 60 },
	{ name = "small enchanted sapphire", chance = 9000, maxCount = 2 },
	{ name = "black pearl", chance = 7000, maxCount = 2 },
	{ name = "ham", chance = 70000, maxCount = 2 },
	{ name = "meat", chance = 20000, maxCount = 2 },
	{ name = "soul orb", chance = 20000, maxCount = 2 },
	{ name = "white pearl", chance = 3000, maxCount = 2 },
	{ name = "ankh", chance = 10000 },
	{ name = "crystal sword", chance = 10000 },
	{ name = "serpent sword", chance = 6000 },
	{ name = "rapier", chance = 5000 },
	{ name = "lion's mane", chance = 15000 },
	{ name = "lightning headband", chance = 2000 },
	{ name = "steel helmet", chance = 4200 },
	{ name = "doublet", chance = 1500 },
	{ name = "ivory carving", chance = 3600 },
	{ name = "magma legs", chance = 750 },
	{ name = "crown helmet", chance = 1100 },
	{ name = "white silk flower", chance = 300 },
	{ name = "lion figurine", chance = 400 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "divine missile", interval = 2000, chance = 15, minDamage = -300, maxDamage = -350, range = 5, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -250, maxDamage = -350, length = 4, spread = 1, effect = CONST_ME_FIREAREA, target = false },
}

monster.defenses = {
	defense = 40,
	armor = 40,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 100, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 35 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -25 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
