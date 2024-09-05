local mType = Game.createMonsterType("Betrayed Wraith")
local monster = {}

monster.description = "a betrayed wraith"
monster.experience = 3500
monster.outfit = {
	lookType = 233,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 284
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Pits of Inferno, Helheim, The Inquisition Quest, Roshamuul Prison.",
}

monster.health = 4200
monster.maxHealth = 4200
monster.race = "undead"
monster.corpse = 6315
monster.speed = 173
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 15,
}

monster.strategiesTarget = {
	nearest = 100,
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
	runHealth = 300,
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
	{ text = "Rrrah!", yell = false },
	{ text = "Gnarr!", yell = false },
	{ text = "Tcharrr!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "platinum coin", chance = 100000, maxCount = 8 },
	{ name = "flask of demonic blood", chance = 65250 },
	{ id = 3450, chance = 50000, maxCount = 5 },
	{ name = "assassin star", chance = 10780, maxCount = 5 },
	{ name = "soul orb", chance = 10000 },
	{ id = 7386, chance = 1490 },
	{ name = "great mana potion", chance = 15000, maxCount = 3 },
	{ id = 6299, chance = 390 },
	{ id = 7416, chance = 80 },
	{ id = 5799, chance = 210 },
	{ id = 5741, chance = 390 },
	{ name = "demonic essence", chance = 19430 },
	{ id = 3028, chance = 11800, maxCount = 4 },
	{ name = "orichalcum pearl", chance = 8000, maxCount = 2 },
	{ id = 10316, chance = 18410 },
	{ id = 7643, chance = 15410 },
	{ id = 3057, chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 80, attack = 100 },
	{ name = "betrayed wraith skill reducer", interval = 2000, chance = 10, target = false },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -600, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_SMALLCLOUDS, target = true, duration = 3000 },
}

monster.defenses = {
	defense = 42,
	armor = 42,
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_HEALING, minDamage = 350, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 10, duration = 5000 },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 360, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
