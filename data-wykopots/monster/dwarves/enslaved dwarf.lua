local mType = Game.createMonsterType("Enslaved Dwarf")
local monster = {}

monster.description = "enslaved dwarf"
monster.experience = 2900
monster.outfit = {
	lookType = 494,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 886
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Caves of the Lost and Lower Spike.",
}

monster.health = 4200
monster.maxHealth = 4200
monster.race = "blood"
monster.corpse = 16063
monster.speed = 135
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
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = false,
	pet = false,
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
	{ name = "gold coin", chance = 50000, maxCount = 99 },
	{ name = "gold coin", chance = 50000, maxCount = 50 },
	{ name = "platinum coin", chance = 100000, maxCount = 6 },
	{ name = "great mana potion", chance = 6660, maxCount = 2 },
	{ id = 3725, chance = 15150, maxCount = 2 },
	{ name = "great health potion", chance = 7960 },
	{ id = 7454, chance = 1640 },
	{ id = 16122, chance = 3110 },
	{ id = 3432, chance = 3690 },
	{ id = 7452, chance = 80 },
	{ id = 7437, chance = 80 },
	{ id = 5880, chance = 11070 },
	{ id = 16123, chance = 5630, maxCount = 2 },
	{ id = 16142, chance = 3690, maxCount = 5 },
	{ id = 3415, chance = 2300 },
	{ id = 3428, chance = 390 },
	{ id = 3033, chance = 10680, maxCount = 2 },
	{ id = 3032, chance = 10290, maxCount = 2 },
	{ id = 3092, chance = 1550 },
	{ id = 16126, chance = 3690 },
	{ id = 16121, chance = 1750 },
	{ id = 3279, chance = 5050 },
	{ id = 7413, chance = 1270 },
	{ id = 3369, chance = 350 },
	{ id = 10310, chance = 4660 },
	{ id = 12600, chance = 780 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 100 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -370, range = 6, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_EXPLOSIONAREA, target = true },
	{ name = "drunk", interval = 2000, chance = 11, radius = 5, effect = CONST_ME_BLOCKHIT, target = false, duration = 5000 },
	{ name = "enslaved dwarf skill reducer 2", interval = 2000, chance = 10, target = false },
	{ name = "enslaved dwarf skill reducer 1", interval = 2000, chance = 10, target = false },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -300, radius = 3, shootEffect = CONST_ANI_WHIRLWINDAXE, effect = CONST_ME_EXPLOSIONHIT, target = true },
}

monster.defenses = {
	defense = 60,
	armor = 60,
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_HEALING, minDamage = 100, maxDamage = 300, effect = CONST_ME_HITAREA, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 422, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
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
