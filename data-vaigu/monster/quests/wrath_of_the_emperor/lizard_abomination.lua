local mType = Game.createMonsterType("Lizard Abomination")
local monster = {}

monster.description = "a lizard abomination"
monster.experience = 9700
monster.outfit = {
	lookType = 364,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 6500
monster.maxHealth = 6500
monster.race = "blood"
monster.corpse = 6323
monster.speed = 150
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
}

monster.light = {
	level = 4,
	color = 113,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "NOOOO! NOW YOU HERETICS WILL FACE MY GODLY WRATH!", yell = true },
	{ text = "RAAARRRR! I WILL DEVOL YOU!", yell = true },
	{ text = "I WILL MAKE YOU ZHEE!", yell = true },
}

monster.loot = {
	{ name = "broken draken mail", chance = 2500 },
	{ name = "broken slicer", chance = 2500 },
	{ name = "ultimate health potion", chance = 1240, maxCount = 3 },
	{ name = "great mana potion", chance = 1960, maxCount = 3 },
	{ name = "draken sulphur", chance = 6480 },
	{ name = "draken wristbands", chance = 6480 },
	{ name = "small diamond", chance = 1850, maxCount = 2 },
	{ name = "zaoan legs", chance = 1850 },
	{ name = "magic sulphur", chance = 1850 },
	{ name = "draken boots", chance = 930 },
	{ name = "assassin dagger", chance = 930 },
	{ name = "twiceslicer", chance = 930 },
	{ name = "zaoan armor", chance = 650 },
	{ name = "zaoan sword", chance = 550 },
	{ name = "zaoan helmet", chance = 1020 },
	{ name = "elite draken mail", chance = 1110 },
	{ name = "blade of corruption", chance = 160 },
	{ name = "great spirit potion", chance = 4905, maxCount = 3 },
	{ name = "ultimate health potion", chance = 9400, maxCount = 3 },
	{ name = "wand of voodoo", chance = 1020 },
	{ name = "eye of corruption", chance = 1210 },
	{ name = "tail of corruption", chance = 2640 },
	{ name = "scale of corruption", chance = 1940 },
	{ name = "shield of corruption", chance = 100 },
	{ name = "undead heart", chance = 2110 },
	{ id = 8896, chance = 15080 }, -- slightly rusted armor
	{ name = "demonic essence", chance = 10550 },
	{ name = "ghastly dragon head", chance = 7540 },
	{ name = "soul orb", chance = 7040 },
	{ name = "terra legs", chance = 452 },
	{ name = "jade hat", chance = 701 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -550 },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -680, radius = 4, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -500, length = 8, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = -200, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 15000 },

}

monster.defenses = {
	defense = 60,
	armor = 55,
	--	mitigation = ???,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 50, maxDamage = 350, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
