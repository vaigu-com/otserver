local mType = Game.createMonsterType("Werelion")
local monster = {}

monster.description = "a werelion"
monster.experience = 2200
monster.outfit = {
	lookType = 1301,
	lookHead = 58,
	lookBody = 2,
	lookLegs = 94,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0,
}

monster.raceId = 1965
monster.Bestiary = {
	class = "Lycanthrope",
	race = BESTY_RACE_LYCANTHROPE,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 3,
	Occurrence = 0,
	Locations = "This monster you can find in Hyaena Lairs.",
}

monster.health = 2800
monster.maxHealth = 2800
monster.race = "blood"
monster.corpse = 33825
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
	canWalkOnEnergy = false,
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
	{ name = "great spirit potion", chance = 60000, maxCount = 2 },
	{ name = "small enchanted ruby", chance = 6000, maxCount = 2 },
	{ name = "meat", chance = 11000, maxCount = 2 },
	{ name = "crystal sword", chance = 7000 },
	{ name = "lion's mane", chance = 16000 },
	{ name = "silver brooch", chance = 5000 },
	{ name = "small diamond", chance = 5000, maxCount = 2 },
	{ name = "war hammer", chance = 1500 },
	{ name = "doublet", chance = 1500 },
	{ name = "dark shield", chance = 1500 },
	{ name = "titan axe", chance = 1700 },
	{ name = "spiked squelcher", chance = 1500 },
	{ name = "glorious axe", chance = 2600 },
	{ name = "spirit cloak", chance = 2000 },
	{ name = "onyx chip", chance = 2100 },
	{ name = "coral brooch", chance = 2000 },
	{ name = "ivory carving", chance = 4100 },
	{ name = "rainbow quartz", chance = 2500 },
	{ name = "noble axe", chance = 1200 },
	{ name = "white silk flower", chance = 500 },
	{ name = "lion figurine", chance = 500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "werelion wave", interval = 2000, chance = 15, minDamage = -230, maxDamage = -300, target = false },
	{ name = "divine missile", interval = 2000, chance = 8, minDamage = -350, maxDamage = -450, range = 5, target = true },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_FIREDAMAGE, minDamage = -250, maxDamage = -370, range = 4, radius = 5, effect = CONST_ME_HITBYFIRE, target = true },
}

monster.defenses = {
	defense = 40,
	armor = 40,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 100, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -25 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 45 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
