local mType = Game.createMonsterType("Tarbaz")
local monster = {}

monster.description = "a tarbaz"
monster.experience = 80000
monster.outfit = {
	lookType = 842,
	lookHead = 57,
	lookBody = 20,
	lookLegs = 57,
	lookFeet = 57,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1188,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 295000
monster.maxHealth = 295000
monster.race = "undead"
monster.corpse = 22495
monster.speed = 247
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
	"TarbazDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You are a failure", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 9000, maxCount = 200 },
	{ name = "platinum coin", chance = 95000, maxCount = 30 },
	{ id = 22516, chance = 100000 },
	{ id = 3037, chance = 15500 },
	{ id = 3036, chance = 15500 },
	{ id = 3039, chance = 15500 },
	{ id = 3038, chance = 15500 },
	{ id = 3041, chance = 15500 },
	{ id = 22757, chance = 600 },
	{ id = 22727, chance = 3000 },
	{ id = 22867, chance = 3000 },
	{ id = 8082, chance = 34000 },
	{ id = 824, chance = 15000 },
	{ id = 823, chance = 15000 },
	{ id = 815, chance = 45000 },
	{ id = 3326, chance = 6000 },
	{ id = 3326, chance = 600 },
	{ id = 3326, chance = 3000 },
	{ id = 3326, chance = 3000 },
	{ id = 3326, chance = 600 },
	{ id = 3326, chance = 16000 },
	{ id = 3326, chance = 800 },
	{ id = 281, chance = 15500 },
	{ name = "demonic essence", chance = 10500 },
	{ id = 3051, chance = 26500 },
	{ id = 16120, chance = 9500, maxCount = 3 },
	{ id = 16119, chance = 9500, maxCount = 3 },
	{ id = 16121, chance = 9500, maxCount = 3 },
	{ id = 9057, chance = 9500, maxCount = 5 },
	{ id = 3032, chance = 9900, maxCount = 5 },
	{ id = 3028, chance = 9700, maxCount = 5 },
	{ id = 3033, chance = 9500, maxCount = 5 },
	{ id = 3030, chance = 9500, maxCount = 5 },
	{ id = 7643, chance = 35000, maxCount = 10 },
	{ id = 7642, chance = 45000, maxCount = 10 },
	{ name = "great mana potion", chance = 95000, maxCount = 10 },
	{ name = "flask of demonic blood", chance = 45000, maxCount = 5 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 200, attack = 290 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -350, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_HITBYFIRE, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -650, maxDamage = -850, length = 10, spread = 3, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -1300, length = 10, spread = 0, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -100, maxDamage = -600, length = 8, spread = 0, effect = CONST_ME_EXPLOSIONHIT, target = false },
}

monster.defenses = {
	defense = 160,
	armor = 160,
	{ name = "combat", interval = 2000, chance = 5, type = COMBAT_HEALING, minDamage = 200, maxDamage = 400, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "tarbaz teleport", interval = 180000, chance = 40, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
