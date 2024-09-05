local mType = Game.createMonsterType("The Flaming Orchid")
local monster = {}

monster.description = "The Flaming Orchid"
monster.experience = 8500
monster.outfit = {
	lookType = 150,
	lookHead = 114,
	lookBody = 94,
	lookLegs = 78,
	lookFeet = 79,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 4000
monster.maxHealth = 4000
monster.race = "blood"
monster.corpse = 21987
monster.speed = 110
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20,
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
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 250,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.events = {
	"FlamingOrchidDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I will end your torment. Do not run, little mortal.", yell = false },
	{ text = "*SNIFF* *SNIFF* BLOOD! I CAN SMELL YOU, MORTAL!", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 246 },
	{ name = "platinum coin", chance = 100000, maxCount = 10 },
	{ id = 21974, chance = 100000 },
	{ id = 21975, chance = 100000 },
	{ id = 7642, chance = 14300, maxCount = 5 },
	{ name = "assassin star", chance = 44000, maxCount = 15 },
	{ name = "demonic essence", chance = 33000 },
	{ name = "gold ingot", chance = 3300, maxCount = 3 },
	{ id = 3033, chance = 22200, maxCount = 3 },
	{ id = 7643, chance = 24180, maxCount = 5 },
	{ id = 3038, chance = 6590 },
	{ id = 821, chance = 2200 },
	{ id = 3070, chance = 14911 },
	{ id = 3069, chance = 5490 },
	{ id = 21981, chance = 1100 },
	{ name = "soul orb", chance = 23000 },
	{ id = 3036, chance = 3300 },
	{ name = "flask of demonic blood", chance = 36260, maxCount = 5 },
	{ id = 8082, chance = 5470 },
	{ id = 7404, chance = 3300 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
	{ name = "the flaming orchid fire", interval = 2000, chance = 17, minDamage = -100, maxDamage = -300, range = 3, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -500, range = 6, radius = 6, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 4000, chance = 17, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -350, length = 8, spread = 0, effect = CONST_ME_BLOCKHIT, target = false },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -300, range = 6, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_HITBYFIRE, target = true },
	{ name = "the flaming orchid paralyze", interval = 2000, chance = 14, minDamage = -100, maxDamage = -300, range = 3, target = false },
}

monster.defenses = {
	defense = 49,
	armor = 49,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 100, maxDamage = 280, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 20, duration = 8000, effect = CONST_ME_TELEPORT },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 1 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -1 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -1 },
	{ type = COMBAT_HOLYDAMAGE, percent = -1 },
	{ type = COMBAT_DEATHDAMAGE, percent = 1 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
