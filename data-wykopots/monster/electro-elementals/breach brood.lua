local mType = Game.createMonsterType("Breach Brood")
local monster = {}

monster.description = "a breach brood"
monster.experience = 2200
monster.outfit = {
	lookType = 878,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1235
monster.Bestiary = {
	class = "Extra Dimensional",
	race = BESTY_RACE_EXTRA_DIMENSIONAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Otherworld.",
}

monster.health = 3500
monster.maxHealth = 3500
monster.race = "venom"
monster.corpse = 23553
monster.speed = 135
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	canPushCreatures = false,
	staticAttackChance = 85,
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
	level = 5,
	color = 40,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Hisss!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 5 },
	{ id = 23545, chance = 18400 },
	{ id = 23535, chance = 18700 },
	{ id = 23518, chance = 15400 },
	{ id = 23507, chance = 9410 },
	{ name = "great mana potion", chance = 12000 },
	{ name = "great health potion", chance = 12000 },
	{ id = 7642, chance = 12000 },
	{ id = 23511, chance = 9140 },
	{ id = 23506, chance = 10500 },
	{ id = 23514, chance = 10630 },
	{ id = 16124, chance = 8170, maxCount = 2 },
	{ id = 16125, chance = 6500 },
	{ id = 16119, chance = 4090 },
	{ id = 16121, chance = 4020 },
	{ id = 23531, chance = 160 },
	{ id = 23533, chance = 190 },
	{ id = 23529, chance = 450 },
	{ id = 23544, chance = 250 },
	{ id = 23542, chance = 210 },
	{ id = 23543, chance = 170 },
	{ id = 822, chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_ENERGYDAMAGE, minDamage = -100, maxDamage = -200, range = 7, radius = 3, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_MAGIC_RED, target = true },
	{ name = "energy strike", interval = 2000, chance = 20, minDamage = -250, maxDamage = -450, range = 6, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_LIFEDRAIN, minDamage = -250, maxDamage = -400, radius = 4, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 53,
	armor = 53,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 90, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 80 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 25 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
