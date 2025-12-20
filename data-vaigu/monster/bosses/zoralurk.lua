local mType = Game.createMonsterType("Zoralurk")
local monster = {}

monster.description = "Zoralurk"
monster.experience = 300000
monster.outfit = {
	lookType = 12,
	lookHead = 0,
	lookBody = 98,
	lookLegs = 86,
	lookFeet = 94,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 115000
monster.maxHealth = 115000
monster.race = "undead"
monster.corpse = 6068
monster.speed = 300
monster.manaCost = 0

monster.changeTarget = {
	interval = 10000,
	chance = 20,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 98,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "demon", chance = 50, interval = 8000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I AM ZORALURK, THE DEMON WITH A THOUSAND FACES", yell = true },
	{ text = "BRING IT, COCKROACHES!", yell = true },
}

monster.loot = {
	{ name = "white pearl", chance = 10000, maxCount = 5 },
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "boots of haste", chance = 12033 },
	{ name = "giant sword", chance = 30000 },
	{ name = "bright sword", chance = 12000 },
	{ name = "warlord sword", chance = 6000 },
	{ name = "patched boots", chance = 7000 },
	{ name = "dark lord's cape", chance = 17000 },
	{ name = "ironworker", chance = 21000 },
	{ name = "thunder hammer", chance = 6000 },
	{ name = "dragon robe", chance = 4500 },
	{ name = "molten plate", chance = 4500 },
	{ name = "great shield", chance = 700 },
	{ id = 25088, chance = 1000 },
	{ id = 3278, chance = 40 },
	{ id = 8097, chance = 200 },
	{ id = 3343, chance = 1200 },
	{ id = 7450, chance = 1100 },
	{ id = 3400, chance = 100 },
	{ id = 3363, chance = 300 },
	{ id = 3368, chance = 70 },
	{ id = 21955, chance = 600 },
	{ id = 3399, chance = 800 },
	{ id = 3402, chance = 500 },
	{ id = 23544, chance = 560 }, -- collar of red plasma
	{ id = 23542, chance = 560 }, -- collar of blue plasma
	{ id = 23543, chance = 560 }, -- collar of green plasma
	{ id = 23533, chance = 560 }, -- ring of red plasma
	{ id = 23529, chance = 560 }, -- ring of blue plasma
	{ id = 23531, chance = 560 }, -- ring of green plasma
	{ name = "white piece of cloth", chance = 6430 },
	{ name = "green piece of cloth", chance = 3003 },
	{ name = "red piece of cloth", chance = 1820 },
	{ name = "blue piece of cloth", chance = 3700 },
	{ name = "envenomed arrow", chance = 14500, maxCount = 55 },
	{ name = "mycological bow", chance = 160 },
	{ id = 3423, chance = 40 },






	
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -1013 },
	{ name = "combat", interval = 1000, chance = 12, type = COMBAT_ENERGYDAMAGE, minDamage = -600, maxDamage = -900, radius = 7, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "combat", interval = 1000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -400, maxDamage = -800, radius = 7, effect = CONST_ME_SMALLPLANTS, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_MANADRAIN, minDamage = -500, maxDamage = -800, range = 7, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 3000, chance = 35, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -600, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	--	mitigation = ???,
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_HEALING, minDamage = 300, maxDamage = 800, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 4000, chance = 80, speedChange = 440, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_CRAPS, target = false, duration = 10000, outfitMonster = "behemoth" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_CRAPS, target = false, duration = 10000, outfitMonster = "fire devil" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_CRAPS, target = false, duration = 10000, outfitMonster = "undead dragon" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_CRAPS, target = false, duration = 10000, outfitMonster = "lost soul" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_CRAPS, target = false, duration = 10000, outfitMonster = "ragiaz" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_CRAPS, target = false, duration = 10000, outfitMonster = "white deer" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_CRAPS, target = false, duration = 10000, outfitMonster = "gozzler" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_CRAPS, target = false, duration = 10000, outfitMonster = "swan maiden" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_CRAPS, target = false, duration = 10000, outfitMonster = "yielothax" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_CRAPS, target = false, duration = 10000, outfitMonster = "askarak prince" },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 60 },
	{ type = COMBAT_EARTHDAMAGE, percent = 60 },
	{ type = COMBAT_FIREDAMAGE, percent = 75 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 75 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
