local mType = Game.createMonsterType("Mahrdis")
local monster = {}

monster.description = "Mahrdis"
monster.experience = 13050
monster.outfit = {
	lookType = 86,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3900
monster.maxHealth = 3900
monster.race = "undead"
monster.corpse = 6025
monster.speed = 170
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.bosstiary = {
	bossRaceId = 86,
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
	maxSummons = 8,
	summons = {
		{ name = "Fire Elemental", chance = 40, interval = 4000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Ashes to ashes!", yell = false },
	{ text = "Fire, Fire!", yell = false },
	{ text = "The eternal flame demands its due!", yell = false },
	{ text = "This is why I'm hot.", yell = false },
	{ text = "May my flames engulf you!", yell = false },
	{ text = "Burnnnnnnnnn!", yell = false },
}

monster.loot = {
	{ name = "holy falcon", chance = 5000 },
	{ name = "small ruby", chance = 17000, maxCount = 3 },
	{ name = "gold coin", chance = 50000, maxCount = 64 },
	{ id = 3039, chance = 6500 }, -- red gem
	{ id = 3052, chance = 15000 }, -- life ring
	{ name = "burning heart", chance = 90000 },
	{ name = "fire axe", chance = 2750 },
	{ name = "phoenix shield", chance = 3300 },
	{ name = "great health potion", chance = 41500 },
	{ id = 10290, chance = 22280 }, -- Mini Mummy
	{ id = 3564, chance = 8220 }, -- red tunic
	{ id = 3343, chance = 21280 }, -- lich staff
	{ id = 8097, chance = 580 }, -- solar axe
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400, condition = { type = CONDITION_POISON, totalDamage = 65, interval = 4000 } },
	{ name = "combat", interval = 1600, chance = 7, type = COMBAT_PHYSICALDAMAGE, minDamage = -60, maxDamage = -400, range = 1, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 1000, chance = 7, type = COMBAT_FIREDAMAGE, minDamage = -60, maxDamage = -400, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 34, type = COMBAT_FIREDAMAGE, minDamage = -80, maxDamage = -500, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "firefield", interval = 1000, chance = 12, radius = 4, effect = CONST_ME_BLOCKHIT, target = false },
	-- fire
	{ name = "condition", type = CONDITION_FIRE, interval = 2000, chance = 13, minDamage = -50, maxDamage = -500, length = 8, spread = 3, effect = CONST_ME_EXPLOSIONHIT, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 20,
	{ name = "combat", interval = 1000, chance = 20, type = COMBAT_HEALING, minDamage = 20, maxDamage = 800, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 45 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -25 },
	{ type = COMBAT_HOLYDAMAGE, percent = -22 },
	{ type = COMBAT_DEATHDAMAGE, percent = 90 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
