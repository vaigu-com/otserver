local mType = Game.createMonsterType("Deadeye Devious")
local monster = {}

monster.description = "deadeye devious"
monster.experience = 500
monster.outfit = {
	lookType = 151,
	lookHead = 115,
	lookBody = 76,
	lookLegs = 35,
	lookFeet = 117,
	lookAddons = 2,
	lookMount = 0,
}

monster.health = 2000
monster.maxHealth = 2000
monster.race = "blood"
monster.corpse = 18097
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 60000,
	chance = 0,
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
	canPushCreatures = false,
	staticAttackChance = 50,
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
	{ text = "Let's kill 'em", yell = false },
	{ text = "Arrrgh!", yell = false },
	{ text = "You'll never take me alive!", yell = false },
}

monster.loot = {
	{ id = 6102, chance = 100000 },
	{ name = "gold coin", chance = 100000, maxCount = 65 },
	{ id = 3370, chance = 12000 },
	{ id = 3357, chance = 4000 },
	{ id = 3207, chance = 100000, maxCount = 2 },
	{ id = 5926, chance = 40000 },
	{ id = 3577, chance = 100000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -250, maxDamage = -550 },
	{ name = "combat", interval = 4000, chance = 60, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -250, shootEffect = CONST_ANI_THROWINGKNIFE, target = false },
}

monster.defenses = {
	defense = 50,
	armor = 35,
	{ name = "combat", interval = 6000, chance = 65, type = COMBAT_HEALING, minDamage = 200, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
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
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
