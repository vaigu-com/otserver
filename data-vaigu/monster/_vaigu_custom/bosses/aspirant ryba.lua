local mType = Game.createMonsterType("Aspirant Ryba")
local monster = {}

monster.description = "an aspirant ryba"
monster.experience = 16000
monster.outfit = {
	lookType = 970,
	lookHead = 95,
	lookBody = 38,
	lookLegs = 57,
	lookFeet = 95,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 16000
monster.maxHealth = 17000
monster.race = "blood"
monster.corpse = 18250
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	rewardBoss = false,
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
	pet = false,
}

monster.events = {
	"RybaKill",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "MINE!", yell = true },
	{ text = "No prisoners!", yell = true },
	{ text = "NO MERCY!", yell = true },
	{ text = "By Bolg's Blood!", yell = false },
	{ text = "You're no match for me!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 49000, maxCount = 133 },
	{ id = 3277, chance = 30800, maxCount = 3 },
	{ id = 3602, chance = 21600, maxCount = 2 },
	{ id = 3372, chance = 12200 },
	{ id = 3003, chance = 16020 },
	{ id = 3269, chance = 11850 },
	{ id = 3357, chance = 10370 },
	{ id = 3351, chance = 11220 },
	{ id = 3265, chance = 8470 },
	{ id = 3369, chance = 6210 },
	{ id = 3305, chance = 6980 },
	{ id = 3318, chance = 1980 },
	{ id = 3370, chance = 1000 },
	{ id = 3383, chance = 1900 },
	{ id = 3384, chance = 2330 },
	{ id = 3371, chance = 1350 },
	{ id = 3016, chance = 740 },
	{ id = 3302, chance = 310 },
	{ id = 822, chance = 650 },
	{ id = 2995, chance = 210 },
	{ id = 3079, chance = 520 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 60 },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -200, range = 7, shootEffect = CONST_ANI_SPEAR, target = false },
}

monster.defenses = {
	defense = 60,
	armor = 42,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 80 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 95 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
