local mType = Game.createMonsterType("Lost Berserker")
local monster = {}

monster.description = "a lost berserker"
monster.experience = 4400
monster.outfit = {
	lookType = 496,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 888
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Warzones 2 and 3.",
}

monster.health = 5900
monster.maxHealth = 5900
monster.race = "blood"
monster.corpse = 16071
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
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
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
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
	{ text = "Kill! Kiill! Kill!", yell = false },
	{ text = "Yahaaaargh!", yell = false },
	{ text = "Death! Death! Death!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 50000, maxCount = 100 },
	{ name = "gold coin", chance = 50000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 9 },
	{ id = 3725, chance = 15190, maxCount = 2 },
	{ id = 16123, chance = 7540, maxCount = 2 },
	{ id = 9057, chance = 7970, maxCount = 2 },
	{ id = 16142, chance = 8210, maxCount = 10 },
	{ name = "great health potion", chance = 13650 },
	{ name = "great mana potion", chance = 13650 },
	{ id = 16127, chance = 6870 },
	{ id = 5880, chance = 8490 },
	{ id = 2995, chance = 3920 },
	{ id = 16124, chance = 4610 },
	{ id = 16120, chance = 3500 },
	{ id = 12600, chance = 2050 },
	{ id = 3429, chance = 640 },
	{ id = 5904, chance = 720 },
	{ id = 7452, chance = 810 },
	{ id = 3415, chance = 1400 },
	{ id = 3097, chance = 2280 },
	{ id = 3318, chance = 2070 },
	{ id = 10422, chance = 930 },
	{ id = 7427, chance = 550 },
	{ id = 3428, chance = 1002 },
	{ id = 813, chance = 640 },
	{ id = 3320, chance = 380 },
	{ id = 3392, chance = 150 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 92, attack = 100 },
	{ name = "drunk", interval = 2000, chance = 11, range = 7, radius = 4, shootEffect = CONST_ANI_WHIRLWINDCLUB, effect = CONST_ME_STUN, target = true, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -300, radius = 5, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "lost berserker skill reducer", interval = 2000, chance = 15, target = false },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -300, range = 7, radius = 3, shootEffect = CONST_ANI_WHIRLWINDAXE, effect = CONST_ME_EXPLOSIONAREA, target = true },
}

monster.defenses = {
	defense = 80,
	armor = 80,
	{ name = "invisible", interval = 2000, chance = 10, duration = 5000, effect = CONST_ME_TELEPORT },
	{ name = "speed", interval = 2000, chance = 12, speedChange = 440, effect = CONST_ME_SMOKE, target = false, duration = 6000 },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_HEALING, minDamage = 300, maxDamage = 770, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 17 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 40 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
