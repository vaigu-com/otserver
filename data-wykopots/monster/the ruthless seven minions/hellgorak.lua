local mType = Game.createMonsterType("Hellgorak")
local monster = {}

monster.description = "Hellgorak"
monster.experience = 10000
monster.outfit = {
	lookType = 12,
	lookHead = 19,
	lookBody = 77,
	lookLegs = 3,
	lookFeet = 80,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 30000
monster.maxHealth = 30000
monster.race = "fire"
monster.corpse = 7893
monster.speed = 165
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
	staticAttackChance = 90,
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
	"InquisitionBossDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I'll sacrifice yours souls to seven!", yell = false },
	{ text = "I'm bad news for you mortals!", yell = false },
	{ text = "No man can defeat me!", yell = false },
	{ text = "Your puny skills are no match for me.", yell = false },
	{ text = "I smell your fear. Delicious!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "demonic essence", chance = 100000 },
	{ id = 8899, chance = 49920 },
	{ id = 7643, chance = 41750, maxCount = 2 },
	{ id = 8073, chance = 31010 },
	{ id = 8896, chance = 28560 },
	{ id = 3344, chance = 29950 },
	{ name = "platinum coin", chance = 21790, maxCount = 30 },
	{ id = 7642, chance = 21180 },
	{ name = "great health potion", chance = 20570 },
	{ id = 3381, chance = 19670 },
	{ name = "great mana potion", chance = 16190 },
	{ id = 3027, chance = 14070, maxCount = 25 },
	{ id = 3026, chance = 13920, maxCount = 25 },
	{ id = 7456, chance = 12860 },
	{ id = 3028, chance = 12860, maxCount = 25 },
	{ id = 3030, chance = 13010, maxCount = 5 },
	{ id = 3008, chance = 12710 },
	{ id = 3033, chance = 12410, maxCount = 25 },
	{ id = 3016, chance = 11800 },
	{ id = 3029, chance = 11650, maxCount = 25 },
	{ id = 821, chance = 9750 },
	{ id = 9057, chance = 11200, maxCount = 25 },
	{ id = 3032, chance = 10740, maxCount = 25 },
	{ name = "steel boots", chance = 11040 },
	{ id = 8043, chance = 10590 },
	{ id = 3382, chance = 98140 },
	{ id = 8042, chance = 10140 },
	{ id = 3013, chance = 9680 },
	{ id = 3371, chance = 9530 },
	{ id = 5954, chance = 9230, maxCount = 2 },
	{ id = 8074, chance = 9370 },
	{ id = 8075, chance = 7620 },
	{ id = 3063, chance = 8320 },
	{ id = 3567, chance = 7870 },
	{ id = 3360, chance = 2070 },
	{ name = "butcher's axe", chance = 2120 },
	{ name = "vile axe", chance = 970 },
	{ id = 8076, chance = 970 },
	{ id = 7453, chance = 230 },
	{ id = 8098, chance = 60 },
	{ name = "golden legs", chance = 530 },
	{ id = 8051, chance = 850 },
	{ id = 8090, chance = 180 },
	{ id = 3019, chance = 1000 },
	{ id = 3303, chance = 120 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 150, attack = 100 },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ENERGYDAMAGE, minDamage = -250, maxDamage = -820, length = 8, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_MANADRAIN, minDamage = -90, maxDamage = -500, radius = 5, effect = CONST_ME_STUN, target = false },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_MANADRAIN, minDamage = -250, maxDamage = -420, range = 7, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_TELEPORT, target = true },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -400, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_PURPLEENERGY, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -120, maxDamage = -570, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "hellgorak skill reducer", interval = 2000, chance = 11, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 70,
	{ name = "combat", interval = 2000, chance = 27, type = COMBAT_HEALING, minDamage = 350, maxDamage = 470, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_HEALING, minDamage = 1450, maxDamage = 1700, effect = CONST_ME_YELLOWENERGY, target = false },
	{ name = "speed", interval = 2000, chance = 12, speedChange = 542, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 98 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 98 },
	{ type = COMBAT_EARTHDAMAGE, percent = 98 },
	{ type = COMBAT_FIREDAMAGE, percent = 98 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = -305 },
	{ type = COMBAT_ICEDAMAGE, percent = 98 },
	{ type = COMBAT_HOLYDAMAGE, percent = 98 },
	{ type = COMBAT_DEATHDAMAGE, percent = 98 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
