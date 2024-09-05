local mType = Game.createMonsterType("Cult Scholar")
local monster = {}

monster.description = "a cult scholar"
monster.experience = 1100
monster.outfit = {
	lookType = 145,
	lookHead = 0,
	lookBody = 77,
	lookLegs = 2,
	lookFeet = 2,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1514
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 1,
	Locations = "Forbidden Temple (Carlin).",
}

monster.health = 1650
monster.maxHealth = 1650
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
	{ text = "The secrets are ours alone!", yell = false },
}

monster.loot = { -- avg 74 gp / 148 /178plat
	{ name = "gold coin", chance = 100000, maxCount = 70 }, -- 35gp
	{ name = "platinum coin", chance = 20000, maxCount = 3 }, -- 30gp
	{ name = "great health potion", chance = 5560 }, -- 4
	{ id = 238, chance = 5560 }, -- great mana potion 4
	{ id = 3577, chance = 12400 }, -- meat
	{ id = 3572, chance = 360 }, -- scarf
	{ id = 3028, chance = 3000 }, -- small diamond 300 9
	{ id = 3032, chance = 3000 }, -- small emerald 300 9
	{ id = 3033, chance = 3000 }, -- small amethyst 300 9
	{ id = 2995, chance = 120 }, -- piggy bank 500 1
	{ id = 3048, chance = 500 }, -- might ring 250 1
	{ id = 9639, chance = 6020 }, -- cultish robe 150 9
	{ id = 3072, chance = 1500 }, -- wand of decay 1000 15
	{ id = 3065, chance = 750 }, -- terra rod 2000 15
	{ id = 3324, chance = 250 }, -- skull staff 6000 15
	{ id = 8072, chance = 250 }, -- spellbook of enli 16
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -250 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -80, maxDamage = -200, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -110, maxDamage = -230, length = 7, spread = 0, effect = CONST_ME_POISONAREA, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 30,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
