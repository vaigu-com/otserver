local mType = Game.createMonsterType("Yaga The Crone")
local monster = {}

monster.description = "an yaga the crone"
monster.experience = 375
monster.outfit = {
	lookType = 54,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 620
monster.maxHealth = 620
monster.race = "blood"
monster.corpse = 6081
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
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
	staticAttackChance = 90,
	targetDistance = 4,
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
	{ text = "Where did I park my hut?", yell = false },
	{ text = "You will taste so sweet!", yell = false },
	{ text = "Hexipooh, bewitched are you!", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 100000 },
	{ id = 3598, chance = 30000, maxCount = 8 },
	{ id = 3069, chance = 25000 },
	{ id = 3562, chance = 25000 },
	{ id = 3454, chance = 15000 },
	{ id = 3565, chance = 15000 },
	{ id = 3012, chance = 10000 },
	{ id = 8074, chance = 25000 },
	{ id = 3736, chance = 20000 },
	{ id = 3083, chance = 18000 },
	{ id = 12548, chance = 50000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -90 },
	{ name = "combat", interval = 2500, chance = 50, type = COMBAT_FIREDAMAGE, minDamage = -30, maxDamage = -50, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_HITBYFIRE, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 3000, chance = 13, minDamage = -200, maxDamage = -300, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	{ name = "firefield", interval = 2000, chance = 13, range = 7, shootEffect = CONST_ANI_FIRE, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 15,
	{ name = "invisible", interval = 1000, chance = 9, duration = 3000, effect = CONST_ME_MAGIC_RED },
	{ name = "outfit", interval = 4000, chance = 9, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000, outfitMonster = "green frog" },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -1 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 1 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
