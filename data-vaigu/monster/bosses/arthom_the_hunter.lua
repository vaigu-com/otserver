local mType = Game.createMonsterType("Arthom the Hunter")
local monster = {}

monster.description = "a arthom the hunter"
monster.experience = 500
monster.outfit = {
	lookType = 129,
	lookHead = 95,
	lookBody = 116,
	lookLegs = 120,
	lookFeet = 115,
	lookAddons = 0,
	lookMount = 0,
}
monster.bosstiary = {
	bossRaceId = 1128,
	bossRace = RARITY_NEMESIS,
}

monster.health = 450
monster.maxHealth = 450
monster.race = "blood"
monster.corpse = 18138
monster.speed = 105
monster.manaCost = 530

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 10,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	
}

monster.loot = {
	{ name = "small ruby", chance = 150 },
	{ name = "dragon necklace", chance = 3000 },
	{ name = "bow", chance = 5770 },
	{ id = 3449, chance = 45360, maxCount = 23 }, -- burst arrow
	{ name = "orange", chance = 20300, maxCount = 2 },
	{ name = "roll", chance = 11370, maxCount = 2 },
	{ name = "sniper gloves", chance = 8540 },
	{ name = "slingshot", chance = 2120 },
	{ id = 7394, chance = 5190 }, -- wolf trophy
	{ id = 7397, chance = 4520 }, -- deer trophy
	{ id = 7400, chance = 370 }, -- lion trophy
	{ name = "hunter's quiver", chance = 70240 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -40 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -150, range = 7, shootEffect = CONST_ANI_ARROW, target = false },
}

monster.defenses = {
	defense = 15,
	armor = 8,
	mitigation = 0.25,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
