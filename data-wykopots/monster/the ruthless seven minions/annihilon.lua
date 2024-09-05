local mType = Game.createMonsterType("Annihilon")
local monster = {}

monster.description = "Annihilon"
monster.experience = 15000
monster.outfit = {
	lookType = 12,
	lookHead = 19,
	lookBody = 104,
	lookLegs = 96,
	lookFeet = 96,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 46500
monster.maxHealth = 46500
monster.race = "fire"
monster.corpse = 7893
monster.speed = 85
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 700,
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
	{ text = "Flee as long as you can!", yell = false },
	{ text = "Annihilon's might will crush you all!", yell = false },
	{ text = "I am coming for you!", yell = false },
	{ text = "RAHHH!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ id = 8896, chance = 57390 },
	{ id = 281, chance = 41940 },
	{ id = 282, chance = 41940 },
	{ id = 3340, chance = 33320 },
	{ name = "assassin star", chance = 21010, maxCount = 50 },
	{ id = 3041, chance = 20010 },
	{ id = 3010, chance = 17010 },
	{ id = 3037, chance = 19570 },
	{ id = 6528, chance = 18680, maxCount = 46 },
	{ id = 3315, chance = 19240 },
	{ id = 3269, chance = 17800 },
	{ id = 3039, chance = 19950 },
	{ id = 7439, chance = 16910 },
	{ id = 763, chance = 20470, maxCount = 96 },
	{ name = "gold ingot", chance = 19470 },
	{ name = "platinum coin", chance = 19030, maxCount = 30 },
	{ id = 3450, chance = 20030, maxCount = 99 },
	{ name = "soul orb", chance = 21580, maxCount = 5 },
	{ id = 3036, chance = 18900 },
	{ id = 7366, chance = 19810, maxCount = 70 },
	{ id = 3038, chance = 20980 },
	{ id = 7440, chance = 16490 },
	{ id = 7643, chance = 16160 },
	{ name = "great health potion", chance = 16720 },
	{ id = 7421, chance = 12720 },
	{ id = 3419, chance = 10270 },
	{ id = 7642, chance = 11270 },
	{ id = 5954, chance = 10830, maxCount = 2 },
	{ name = "great mana potion", chance = 13390 },
	{ id = 8063, chance = 12050 },
	{ id = 3428, chance = 9970 },
	{ id = 7387, chance = 8420 },
	{ id = 3415, chance = 11010 },
	{ id = 3414, chance = 5050 },
	{ id = 3420, chance = 5440 },
	{ id = 7431, chance = 1300 },
	{ id = 8049, chance = 1170 },
	{ id = 8100, chance = 2330 },
	{ id = 8101, chance = 520 },
	{ id = 8061, chance = 390 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 190, attack = 100 },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -255, range = 7, radius = 4, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_GROUNDSHAKER, target = true },
	{ name = "annihilon skill reducer", interval = 2000, chance = 6, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -325, maxDamage = -500, range = 7, radius = 3, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_ENERGYAREA, target = true },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 9, minDamage = -400, maxDamage = 700, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = -150, maxDamage = -250, range = 7, radius = 4, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_TELEPORT, target = true },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_DEATHDAMAGE, minDamage = -450, maxDamage = -800, length = 8, spread = 0, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "annihilon paralyze", interval = 2000, chance = 13, range = 7, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 60,
	{ name = "combat", interval = 2000, chance = 23, type = COMBAT_HEALING, minDamage = 225, maxDamage = 275, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 95 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 95 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
