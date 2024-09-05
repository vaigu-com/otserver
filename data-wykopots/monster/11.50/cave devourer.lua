local mType = Game.createMonsterType("Cave Devourer")
local monster = {}

monster.description = "a cave devourer"
monster.experience = 2800
monster.outfit = {
	lookType = 1036,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1544
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Warzone 5.",
}

monster.health = 4500
monster.maxHealth = 4500
monster.race = "venom"
monster.corpse = 27559
monster.speed = 120
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
	staticAttackChance = 85,
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
	level = 3,
	color = 174,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "sloap sloap sloap", yell = false },
}

monster.loot = {
	{ name = "cave devourer eyes", chance = 27400 },
	{ name = "cave devourer maw", chance = 23840 },
	{ name = "crystalline arrow", chance = 21710, maxCount = 30 },
	{ name = "cave devourer legs", chance = 19400 },
	{ name = "slime heart", chance = 15300, maxCount = 4 },
	{ name = "cyan crystal fragment", chance = 5160 },
	{ name = "small enchanted sapphire", chance = 8900, maxCount = 2 },
	{ name = "small enchanted ruby", chance = 5870 },
	{ name = "blue crystal shard", chance = 7830 },
	{ name = "violet crystal shard", chance = 7470 },
	{ name = "green crystal shard", chance = 10850 },
	{ id = 3049, chance = 3020 }, -- stealth ring
	{ name = "suspicious device", chance = 550 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400, condition = { type = CONDITION_POISON, totalDamage = 420, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -120, maxDamage = -160, length = 6, spread = 0, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "stalagmite rune", interval = 2000, chance = 17, minDamage = -150, maxDamage = -250, range = 7, target = true },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -330, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_HITBYPOISON, target = true },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_EARTHDAMAGE, minDamage = -60, maxDamage = -100, radius = 5, shootEffect = CONST_ANI_POISON, effect = CONST_ME_SMALLPLANTS, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = -170, maxDamage = -280, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
}

monster.defenses = {
	defense = 70,
	armor = 70,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
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
