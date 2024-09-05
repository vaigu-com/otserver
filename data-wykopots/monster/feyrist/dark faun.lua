local mType = Game.createMonsterType("Dark Faun")
local monster = {}

monster.description = "a dark faun"
monster.experience = 850
monster.outfit = {
	lookType = 980,
	lookHead = 94,
	lookBody = 114,
	lookLegs = 57,
	lookFeet = 94,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1496
monster.Bestiary = {
	class = "Fey",
	race = BESTY_RACE_FEY,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Feyrist (nighttime) and its underground (all day).",
}

monster.health = 1000
monster.maxHealth = 1000
monster.race = "blood"
monster.corpse = 25815
monster.speed = 108
monster.manaCost = 450

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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 50,
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
	{ text = "Are you posing a threat to this realm? I suppose so.", yell = false },
	{ text = "Hicks!", yell = false },
	{ text = "This is will be your last dance!", yell = false },
	{ text = "You're a threat to this realm! You have to die!", yell = false },
	{ text = "This is a nightmare and you won't wake up!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 160 },
	{ name = "wood cape", chance = 2000 },
	{ id = 25694, chance = 15400 },
	{ name = "wooden spellbook", chance = 360 },
	{ name = "mandrake", chance = 50 },
	{ name = "leaf legs", chance = 450 },
	{ name = "small stone", chance = 5400, maxCount = 5 },
	{ name = "small enchanted sapphire", chance = 2500, maxCount = 2 },
	{ id = 25693, chance = 10350 },
	{ name = "cave turnip", chance = 6500, maxCount = 2 },
	{ name = "dark mushroom", chance = 5300 },
	{ name = "panpipes", chance = 2800 },
	{ name = "prismatic quartz", chance = 5000 },
	{ name = "leaf star", chance = 7330, maxCount = 8 },
	{ name = "strong health potion", chance = 12400, maxCount = 2 },
	{ name = "goat grass", chance = 7500 },
	{ name = "great health potion", chance = 3500 },
	{ id = 5792, chance = 160 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "stalagmite rune", interval = 2000, chance = 15, minDamage = -60, maxDamage = -115, range = 7, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -115, range = 7, shootEffect = CONST_ANI_THROWINGSTAR, target = false },
	{ name = "drunk", interval = 3000, chance = 10, length = 5, spread = 2, effect = CONST_ME_SOUND_PURPLE, target = false, duration = 5000 },
}

monster.defenses = {
	defense = 50,
	armor = 50,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 85, maxDamage = 115, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = 250, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 70 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
