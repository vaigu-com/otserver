local mType = Game.createMonsterType("Lost Thrower")
local monster = {}

monster.description = "a lost thrower"
monster.experience = 1200
monster.outfit = {
	lookType = 539,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 926
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Caves of the Lost, Lower Spike and in the Lost Dwarf version of the Forsaken Mine.",
}

monster.health = 1700
monster.maxHealth = 1700
monster.race = "blood"
monster.corpse = 17718
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
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
	targetDistance = 4,
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
	{ text = "Yagga! Yagga!", yell = false },
	{ text = "*grunt*", yell = false },
	{ text = "Hurrr!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 140 },
	{ name = "platinum coin", chance = 70000 },
	{ id = 3725, chance = 14880, maxCount = 2 },
	{ id = 17853, chance = 15100 },
	{ id = 17852, chance = 11940 },
	{ id = 17857, chance = 9350 },
	{ id = 17856, chance = 6910 },
	{ id = 17851, chance = 1540 },
	{ id = 17850, chance = 14720 },
	{ id = 17827, chance = 12410 },
	{ id = 17854, chance = 11910 },
	{ id = 5880, chance = 9280 },
	{ id = 17829, chance = 730 },
	{ name = "great health potion", chance = 13990 },
	{ name = "great mana potion", chance = 14160 },
	{ id = 12600, chance = 12190 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 110, attack = 50 },
	{ name = "lost thrower skill reducer", interval = 2000, chance = 15, radius = 2, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -150, maxDamage = -300, radius = 3, shootEffect = CONST_ANI_WHIRLWINDAXE, effect = CONST_ME_EXPLOSIONAREA, target = true },
	{ name = "drunk", interval = 2000, chance = 15, radius = 2, shootEffect = CONST_ANI_WHIRLWINDCLUB, effect = CONST_ME_STUN, target = true, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -250, radius = 1, shootEffect = CONST_ANI_THROWINGSTAR, effect = CONST_ME_EXPLOSIONAREA, target = true },
}

monster.defenses = {
	defense = 55,
	armor = 55,
	{ name = "invisible", interval = 2000, chance = 16, duration = 3000, effect = CONST_ME_TELEPORT },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 100, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
