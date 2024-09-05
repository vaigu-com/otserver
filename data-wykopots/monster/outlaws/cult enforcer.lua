local mType = Game.createMonsterType("Cult Enforcer")
local monster = {}

monster.description = "a cult enforcer"
monster.experience = 1000
monster.outfit = {
	lookType = 134,
	lookHead = 95,
	lookBody = 19,
	lookLegs = 76,
	lookFeet = 57,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1513
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Forbidden Temple (Carlin).",
}

monster.health = 1250
monster.maxHealth = 1250
monster.race = "blood"
monster.corpse = 111
monster.speed = 130
monster.manaCost = 390

monster.changeTarget = {
	interval = 4000,
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
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
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
	{ text = "No one will stop us!", yell = false },
}

monster.loot = { -- avg 168 / 198
	{ name = "gold coin", chance = 100000, maxCount = 70 },
	{ name = "platinum coin", chance = 20000, maxCount = 3 }, -- 30gp
	{ name = "great health potion", chance = 5860 },
	{ id = 3577, chance = 12400 }, -- small emerald
	{ id = 3572, chance = 680 }, -- scarf
	{ id = 3028, chance = 3000 }, -- small diamond
	{ id = 3032, chance = 3000 }, -- small emerald
	{ id = 3033, chance = 3000 }, -- small amethyst
	{ id = 2995, chance = 70 }, -- piggy bank
	{ id = 3048, chance = 500 }, -- might ring
	{ id = 9639, chance = 10000 }, -- cultish robe 150 14
	{ id = 3269, chance = 2300 }, -- halberd
	{ id = 3279, chance = 860 }, -- war hammer
	{ id = 3371, chance = 1000 }, -- knight legs 5000 28.5
	{ id = 3415, chance = 640 }, -- guardian shield 2000 13
	{ id = 3369, chance = 180 }, -- warrior helmet 5000 9
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -250 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -140, range = 5, shootEffect = CONST_ANI_SPEAR, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 30,
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
