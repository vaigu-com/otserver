local mType = Game.createMonsterType("Reality Reaver")
local monster = {}

monster.description = "a reality reaver"
monster.experience = 3100
monster.outfit = {
	lookType = 879,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1224
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

monster.health = 3900
monster.maxHealth = 3900
monster.race = "venom"
monster.corpse = 23412
monster.speed = 170
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 20,
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
	staticAttackChance = 80,
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
	{ text = "Ssshhh!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 100 },
	{ name = "platinum coin", chance = 100000, maxCount = 6 },
	{ name = "great health potion", chance = 11000, maxCount = 2 },
	{ name = "great mana potion", chance = 11000, maxCount = 2 },
	{ id = 7642, chance = 11000, maxCount = 2 },
	{ id = 16119, chance = 4000 },
	{ id = 16124, chance = 8310 },
	{ id = 16126, chance = 6060 },
	{ id = 16120, chance = 4040 },
	{ id = 3036, chance = 440 },
	{ id = 3039, chance = 2510 },
	{ id = 23515, chance = 9660 },
	{ id = 23535, chance = 17870, maxCount = 2 },
	{ id = 23545, chance = 16700, maxCount = 2 },
	{ id = 23508, chance = 14730 },
	{ id = 828, chance = 510 },
	{ id = 23520, chance = 14670 },
	{ id = 23506, chance = 8910 },
	{ id = 8092, chance = 840 },
	{ id = 8043, chance = 840 },
	{ id = 23531, chance = 370 },
	{ id = 23533, chance = 400 },
	{ id = 23529, chance = 510 },
	{ id = 23544, chance = 250 },
	{ id = 23542, chance = 420 },
	{ id = 23543, chance = 330 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 },
	{ name = "energy strike", interval = 2000, chance = 16, minDamage = 0, maxDamage = -400, range = 6, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -150, maxDamage = -400, range = 6, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -450, range = 7, radius = 5, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "reality reaver wave", interval = 2000, chance = 10, minDamage = -250, maxDamage = -500, target = false },
	{ name = "massive energy elemental electrify", interval = 2000, chance = 12, effect = CONST_ME_BLOCKHIT, target = false },
}

monster.defenses = {
	defense = 51,
	armor = 51,
	{ name = "combat", interval = 2000, chance = 5, type = COMBAT_HEALING, minDamage = 190, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 13, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 350, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 85 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
