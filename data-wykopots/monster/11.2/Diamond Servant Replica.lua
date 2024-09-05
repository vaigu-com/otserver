local mType = Game.createMonsterType("Diamond Servant Replica")
local monster = {}

monster.description = "a diamond servant replica"
monster.experience = 700
monster.outfit = {
	lookType = 397,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1326
-- monster.Bestiary = {
-- class = "Construct",
-- race = BESTY_RACE_CONSTRUCT,
-- toKill = 1000,
-- FirstUnlock = 50,
-- SecondUnlock = 500,
-- CharmsPoints = 25,
-- Stars = 3,
-- Occurrence = 2,
-- Locations = "Replica Dungeon."
-- }

monster.health = 2000
monster.maxHealth = 2000
monster.race = "venom"
monster.corpse = 12496
monster.speed = 105
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	runHealth = 100,
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
	{ text = "Error. LOAD 'PROGRAM',8,1", yell = false },
	{ text = "Remain. Obedient.", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 44000, maxCount = 100 },
	{ name = "gold coin", chance = 50000, maxCount = 79 },
	{ name = "soul orb", chance = 45000 },
	{ id = 3061, chance = 9150 },
	{ id = 237, chance = 5980 },
	{ id = 236, chance = 5790 },
	{ id = 9063, chance = 5320 },
	{ id = 8775, chance = 5000 },
	{ id = 9655, chance = 5000 },
	{ id = 3048, chance = 940 },
	{ id = 816, chance = 710 },
	{ id = 3037, chance = 550 },
	{ id = 3073, chance = 530 },
	{ id = 12601, chance = 480 },
	{ id = 7440, chance = 400 },
	{ id = 8050, chance = 20 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 30, attack = 50 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -80, maxDamage = -120, radius = 3, effect = CONST_ME_YELLOWENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -125, maxDamage = -170, length = 5, spread = 2, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "drunk", interval = 2000, chance = 10, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_STUN, target = true, duration = 3000 },
}

monster.defenses = {
	defense = 25,
	armor = 25,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 80 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
