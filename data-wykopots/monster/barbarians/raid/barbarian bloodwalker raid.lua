local mType = Game.createMonsterType("Barbarian Bloodwalker Raid")
local monster = {}

monster.name = "Barbarian Bloodwalker"
monster.description = "a barbarian bloodwalker"
monster.experience = 195
monster.outfit = {
	lookType = 255,
	lookHead = 114,
	lookBody = 132,
	lookLegs = 132,
	lookFeet = 132,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 323
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Krimhorn, Bittermor, Ragnir, Arena and Zoo Quarter inside the Arena.",
}

monster.health = 305
monster.maxHealth = 305
monster.race = "blood"
monster.corpse = 18054
monster.speed = 118
monster.manaCost = 590

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
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
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
	{ text = "YAAAHEEE!", yell = false },
	{ text = "SLAUGHTER!", yell = false },
	{ text = "CARNAGE!", yell = false },
	{ text = "You can run but you can't hide", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 800 },
	{ name = "gold coin", chance = 54000, maxCount = 12 },
	{ name = "ham", chance = 4970 },
	{ id = 2914, chance = 8280 },
	{ id = 3269, chance = 7030 },
	{ id = 3352, chance = 10440 },
	{ id = 3266, chance = 6000 },
	{ id = 3358, chance = 10290 },
	{ id = 5911, chance = 530 },
	{ id = 266, chance = 950 },
	{ id = 3344, chance = 390 },
	{ id = 7457, chance = 140 },
	{ id = 7290, chance = 290 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 80 },
}

monster.defenses = {
	defense = 9,
	armor = 9,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 240, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
