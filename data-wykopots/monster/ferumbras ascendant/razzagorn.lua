local mType = Game.createMonsterType("Razzagorn")
local monster = {}

monster.description = "a razzagorn"
monster.experience = 30000
monster.outfit = {
	lookType = 842,
	lookHead = 78,
	lookBody = 94,
	lookLegs = 34,
	lookFeet = 34,
	lookAddons = 1,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1177,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 290000
monster.maxHealth = 290000
monster.race = "undead"
monster.corpse = 22495
monster.speed = 242
monster.manaCost = 200

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
	canPushCreatures = false,
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

monster.events = {
	"RazzagornDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "gold coin", chance = 95000, maxCount = 200 },
	{ name = "platinum coin", chance = 99000, maxCount = 25 },
	{ id = 22516, chance = 100000 },
	{ id = 3037, chance = 8500 },
	{ id = 3036, chance = 8500 },
	{ id = 3039, chance = 8500 },
	{ id = 3065, chance = 29000 },
	{ id = 7440, chance = 700 },
	{ name = "gold ingot", chance = 8000 },
	{ id = 3356, chance = 900 },
	{ name = "demonic essence", chance = 5000 },
	{ id = 7443, chance = 9500 },
	{ id = 3041, chance = 9500 },
	{ id = 7643, chance = 35000, maxCount = 10 },
	{ id = 7642, chance = 35000, maxCount = 10 },
	{ name = "great mana potion", chance = 45000, maxCount = 10 },
	{ id = 3029, chance = 18500, maxCount = 5 },
	{ id = 3032, chance = 18500, maxCount = 5 },
	{ id = 3028, chance = 18500, maxCount = 5 },
	{ id = 3033, chance = 18500, maxCount = 5 },
	{ name = "orichalcum pearl", chance = 13500, maxCount = 5 },
	{ id = 22194, chance = 78000, maxCount = 5 },
	{ id = 22193, chance = 78000, maxCount = 5 },
	{ name = "flask of demonic blood", chance = 48500, maxCount = 5 },
	{ id = 22867, chance = 3550 },
	{ id = 22866, chance = 3550 },
	{ id = 22762, chance = 1550 },
	{ id = 22754, chance = 1850 },
	{ id = 22727, chance = 9000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1250 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -1000, length = 10, spread = 0, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -700, range = 7, radius = 5, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -1500, length = 10, spread = 3, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -50, maxDamage = -800, length = 8, spread = 3, effect = CONST_ME_ENERGYHIT, target = false },
}

monster.defenses = {
	defense = 160,
	armor = 160,
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_HEALING, minDamage = 100, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "razzagorn summon", interval = 6000, chance = 23, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
