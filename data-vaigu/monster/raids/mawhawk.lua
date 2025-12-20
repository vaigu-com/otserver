local mType = Game.createMonsterType("Mawhawk")
local monster = {}

monster.description = "Mawhawk"
monster.experience = 14000
monster.outfit = {
	lookType = 595,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1028,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 25000
monster.maxHealth = 25000
monster.race = "blood"
monster.corpse = 20295
monster.speed = 135
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
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
	canPushItems = false,
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
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 3,
	summons = {
		{ name = "guzzlemaw", chance = 20, interval = 2000, count = 1 },
	},
}
monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Better flee now!", yell = false },
	{ text = "Watch my maws!", yell = false },
}

monster.loot = {
	{ id = 20062, chance = 60000, maxCount = 12 }, -- cluster of solace
	{ id = 20198, chance = 30000 }, -- frazzle tongue
	{ id = 20264, chance = 70000, maxCount = 3, unique = true }, -- unrealized dream
	{ id = 3035, chance = 10000, maxCount = 25 }, -- platinum coin
	{ id = 5880, chance = 10000 }, -- iron ore
	{ id = 5895, chance = 40000 }, -- fish fin
	{ id = 5911, chance = 10000 }, -- red piece of cloth
	{ id = 5925, chance = 10000 }, -- hardened bone
	{ id = 7407, chance = 10000 }, -- haunted blade
	{ id = 7418, chance = 10000 }, -- nightmare blade
	{ id = 16120, chance = 10000, maxCount = 3 }, -- violet crystal shard
	{ id = 16121, chance = 10000, maxCount = 3 }, -- green crystal shard
	{ id = 16122, chance = 10000, maxCount = 5 }, -- green crystal splinter
	{ id = 16124, chance = 10000, maxCount = 5 }, -- blue crystal splinter
	{ id = 20280, chance = 10000 },
	{ id = 20279, chance = 10000 },
	{ id = 20274, chance = 10000 },
	{ id = 12669, chance = 70000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 190 },
	{ name = "hirintror skill reducer", interval = 2000, chance = 20, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -250, maxDamage = -510, length = 8, spread = 2, effect = CONST_ME_BLOCKHIT, target = false },
	{ name = "combat", interval = 3000, chance = 34, type = COMBAT_PHYSICALDAMAGE, minDamage = -120, maxDamage = -700, range = 8, radius = 1, shootEffect = CONST_ANI_WHIRLWINDSWORD, target = true },
	{ name = "combat", interval = 1800, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -685, length = 7, spread = 0, effect = CONST_ME_STONES, target = false },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -590, radius = 6, effect = CONST_ME_BIGPLANTS, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 55,
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 80 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = -50 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
