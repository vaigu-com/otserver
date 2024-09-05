local mType = Game.createMonsterType("Mutanted")
local monster = {}

monster.description = "a mutanted"
monster.experience = 1500
monster.outfit = {
	lookType = 323,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 2400
monster.maxHealth = 2400
monster.race = "blood"
monster.corpse = 5798
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
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

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Take that creature off my back!! I can fell it!", yell = false },
	{ text = "HEEEEEEEELP!", yell = false },
	{ text = "You will be the next infected one... GRAAAAAAAAARRR!", yell = false },
	{ text = "Science... is a curse.", yell = false },
	{ text = "Run as fast as you can.", yell = false },
	{ text = "Oh by the gods! What is this... aaaaaargh!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 99000, minCount = 50, maxCount = 280 },
	{ id = 3492, chance = 7110, maxCount = 2 },
	{ id = 3111, chance = 10050 },
	{ id = 3045, chance = 4980 },
	{ id = 10308, chance = 79940 },
	{ id = 8894, chance = 190 },
	{ id = 3737, chance = 4200 },
	{ id = 3054, chance = 70 },
	{ id = 3415, chance = 68000 },
	{ id = 7454, chance = 16700 },
	{ id = 3033, chance = 79000, maxCount = 4 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 50, condition = { type = CONDITION_POISON, totalDamage = 160, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_DEATHDAMAGE, minDamage = -70, maxDamage = -160, length = 3, spread = 2, effect = CONST_ME_POFF, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 20, minDamage = -280, maxDamage = -480, length = 1, spread = 0, effect = CONST_ME_HITBYPOISON, target = true },
	{ name = "speed", interval = 2000, chance = 13, speedChange = -700, range = 7, effect = CONST_ME_STUN, target = true, duration = 30000 },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_EARTHDAMAGE, minDamage = -10, maxDamage = -150, range = 7, effect = CONST_ME_CARNIPHILA, target = true },
}

monster.defenses = {
	defense = 15,
	armor = 15,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 420, effect = CONST_ME_GREEN_RINGS, target = false, duration = 3000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
