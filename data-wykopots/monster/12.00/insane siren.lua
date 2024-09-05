local mType = Game.createMonsterType("Insane Siren")
local monster = {}

monster.description = "an insane siren"
monster.experience = 6000
monster.outfit = {
	lookType = 1137,
	lookHead = 94,
	lookBody = 94,
	lookLegs = 79,
	lookFeet = 20,
	lookAddons = 3,
	lookMount = 0,
}

monster.raceId = 1735
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Court of Summer.",
}

monster.health = 6500
monster.maxHealth = 6500
monster.race = "undead"
monster.corpse = 30133
monster.speed = 210
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
	{ text = "Dream or nightmare?", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 80000, maxCount = 12 },
	{ name = "ultimate health potion", chance = 13280 },
	{ name = "miraculum", chance = 9040 },
	{ name = "dream essence egg", chance = 10800 },
	{ name = "wand of draconia", chance = 6160 },
	{ name = "holy orchid", chance = 3968 },
	{ name = "magma amulet", chance = 3680 },
	{ name = "wand of inferno", chance = 2944 },
	{ name = "fire axe", chance = 2752 },
	{ name = "magma coat", chance = 2944 },
	{ name = "wand of dragonbreath", chance = 2848 },
	{ name = "sun fruit", chance = 1776, maxCount = 2 },
	{ name = "magma legs", chance = 608 },
	{ name = "magma monocle", chance = 232 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_FIREDAMAGE, minDamage = -180, maxDamage = -350, range = 6, radius = 3, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -350, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -300, range = 7, radius = 4, effect = CONST_ME_EXPLOSIONHIT, target = true },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_FIREDAMAGE, minDamage = -140, maxDamage = -230, length = 4, spread = 0, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "fireball rune", interval = 2000, chance = 16, minDamage = -150, maxDamage = -300, range = 7, target = false },
}

monster.defenses = {
	defense = 70,
	armor = 70,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_FIREDAMAGE, percent = 70 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 55 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
