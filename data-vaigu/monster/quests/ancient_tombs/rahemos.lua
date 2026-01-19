local mType = Game.createMonsterType("Rahemos")
local monster = {}

monster.description = "Rahemos"
monster.experience = 13100
monster.outfit = {
	lookType = 88,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3700
monster.maxHealth = 3700
monster.race = "undead"
monster.corpse = 6031
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.bosstiary = {
	bossRaceId = 88,
	bossRace = RARITY_BANE,
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 1,
	summons = {
		{ name = "Demon", chance = 10, interval = 5000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "It's a kind of magic.", yell = false },
	{ text = "Abrah Kadabrah!", yell = false },
	{ text = "Nothing hidden in my wrappings.", yell = false },
	{ text = "It's not a trick, it's Rahemos.", yell = false },
	{ text = "Meet my friend from hell!", yell = false },
	{ text = "I will make you believe in magic.", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 50000, maxCount = 90 },
	{ name = "small amethyst", chance = 71000, maxCount = 3 },
	{ name = "violet gem", chance = 5500 },
	{ name = "orb", chance = 45500 },
	{ name = "crystal wand", chance = 5000 },
	{ id = 3098, chance = 71000 }, -- ring of healing
	{ name = "ancient rune", chance = 90000 },
	{ name = "twin axe", chance = 2200 },
	{ name = "magician hat", chance = 1300 },
	{ name = "great mana potion", chance = 70000 },
	{ id = 10290, chance = 8280 }, -- Mini Mummy
	{ name = "silver token", chance = 15140 },
	{ id = 8898, chance = 2500 }, -- rusted legs
	{ id = 8907, chance = 2500 }, -- rusted helmet
	{ id = 11701, chance = 12500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -650, condition = { type = CONDITION_POISON, totalDamage = 65, interval = 2000 } },
	{ name = "combat", interval = 3000, chance = 7, type = COMBAT_LIFEDRAIN, minDamage = -75, maxDamage = -450, range = 1, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -60, maxDamage = -300, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -60, maxDamage = -400, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "speed", interval = 1000, chance = 12, speedChange = -650, radius = 4, effect = CONST_ME_POISONAREA, target = false, duration = 20000 },
	{ name = "drunk", interval = 1000, chance = 8, range = 3, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "outfit", interval = 1000, chance = 15, range = 7, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 12000, outfitMonster = "pig" },
}

monster.defenses = {
	defense = 35,
	armor = 30,
	{ name = "combat", interval = 1000, chance = 10, type = COMBAT_HEALING, minDamage = 200, maxDamage = 400, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "outfit", interval = 1000, chance = 15, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 4000, outfitMonster = "demon" },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 85 },
	{ type = COMBAT_EARTHDAMAGE, percent = 70 },
	{ type = COMBAT_FIREDAMAGE, percent = 75 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 90 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
