local mType = Game.createMonsterType("Zugurosh")
local monster = {}

monster.description = "Zugurosh"
monster.experience = 10000
monster.outfit = {
	lookType = 12,
	lookHead = 2,
	lookBody = 35,
	lookLegs = 57,
	lookFeet = 91,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 90500
monster.maxHealth = 90500
monster.race = "fire"
monster.corpse = 7893
monster.speed = 165
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 15,
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
	runHealth = 4500,
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
	{ text = "You will run out of resources soon enough!", yell = true },
	{ text = "One little mistake and you're all are mine!", yell = false },
	{ text = "I sense your strength fading!", yell = false },
	{ text = "I know you will show a weakness!", yell = false },
	{ text = "Your fear will make you prone to mistakes!", yell = false },
}

monster.loot = {
	{ name = "demonic essence", chance = 100000 },
	{ name = "gold coin", chance = 100000, maxCount = 194 },
	{ id = 8899, chance = 54000 },
	{ id = 8896, chance = 45000 },
	{ name = "great mana potion", chance = 27000 },
	{ id = 7642, chance = 26000 },
	{ name = "great health potion", chance = 23000 },
	{ id = 7643, chance = 22000 },
	{ name = "gold ingot", chance = 21000 },
	{ name = "platinum coin", chance = 21000, maxCount = 30 },
	{ id = 6104, chance = 21000 },
	{ name = "soul orb", chance = 21000, maxCount = 10 },
	{ id = 3034, chance = 18000, maxCount = 30 },
	{ id = 5911, chance = 17000, maxCount = 10 },
	{ id = 3017, chance = 17000 },
	{ id = 5912, chance = 15000, maxCount = 10 },
	{ id = 5909, chance = 15000, maxCount = 10 },
	{ id = 5910, chance = 14000, maxCount = 10 },
	{ id = 5914, chance = 14000, maxCount = 10 },
	{ id = 5913, chance = 12000, maxCount = 10 },
	{ id = 5954, chance = 9700, maxCount = 2 },
	{ id = 3079, chance = 9800 },
	{ id = 3057, chance = 5300 },
	{ name = "steel boots", chance = 5400 },
	{ id = 3555, chance = 530 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 150, attack = 100 },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_DEATHDAMAGE, minDamage = -50, maxDamage = -100, radius = 5, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "zugurosh soulfire", interval = 2000, chance = 17, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -60, maxDamage = -230, radius = 5, effect = CONST_ME_WATERSPLASH, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -600, length = 10, spread = 0, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 45,
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_HEALING, minDamage = 40, maxDamage = 60, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_HEALING, minDamage = 400, maxDamage = 600, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "invisible", interval = 2000, chance = 10, duration = 6000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 25 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
