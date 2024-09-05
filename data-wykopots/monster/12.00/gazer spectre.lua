local mType = Game.createMonsterType("Gazer Spectre")
local monster = {}

monster.description = "a Gazer Spectre"
monster.experience = 4200
monster.outfit = {
	lookType = 1122,
	lookHead = 94,
	lookBody = 20,
	lookLegs = 77,
	lookFeet = 20,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1725
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Haunted Temple, Buried Cathedral.",
}

monster.health = 4500
monster.maxHealth = 4500
monster.race = "undead"
monster.corpse = 30167
monster.speed = 195
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
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
	staticAttackChance = 85,
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
	{ text = "Deathhh... is... a.... doooor!!", yell = false },
	{ text = "Tiiimeee... is... a... windowww!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 75000, maxCount = 10 },
	{ name = "small diamond", chance = 12600 },
	{ name = "brown crystal splinter", chance = 10875 },
	{ name = "small sapphire", chance = 10500 },
	{ id = 3039, chance = 10125 },
	{ name = "red crystal fragment", chance = 8017 },
	{ name = "small enchanted ruby", chance = 4380 },
	{ name = "yellow gem", chance = 4380 },
	{ id = 29299, chance = 5000 }, -- golden idol of tukh
	{ name = "wand of draconia", chance = 2940 },
	{ name = "wand of inferno", chance = 2287 },
	{ id = 30084, chance = 1395 }, -- red ectoplasm
	{ name = "magma coat", chance = 1597 },
	{ name = "prismatic quartz", chance = 1432 },
	{ name = "small enchanted emerald", chance = 1395, maxCount = 3 },
	{ name = "onyx chip", chance = 1132, maxCount = 4 },
	{ name = "hexagonal ruby", chance = 795 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "gazer fire chain", interval = 2000, chance = 18, range = 6, target = true }, --fire chain
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -350, range = 6, radius = 3, effect = CONST_ME_FIREATTACK, target = true }, -- flame box
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -400, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true }, -- red star strike
}

monster.defenses = {
	defense = 68,
	armor = 68,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_FIREDAMAGE, percent = 133 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 85 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 60 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -30 },
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
