local mType = Game.createMonsterType("Brain Squid")
local monster = {}

monster.description = "a brain squid"
monster.experience = 17850
monster.outfit = {
	lookType = 1059,
	lookHead = 16,
	lookBody = 98,
	lookLegs = 77,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1653
-- monster.Bestiary = {
-- class = "Magical",
-- race = BESTY_RACE_MAGICAL,
-- toKill = 2500,
-- FirstUnlock = 100,
-- SecondUnlock = 1000,
-- CharmsPoints = 50,
-- Stars = 4,
-- Occurrence = 0,
-- Locations = "Secret Library."
-- }

monster.health = 18000
monster.maxHealth = 18000
monster.race = "blood"
monster.corpse = 28582
monster.speed = 215
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
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
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "platinum coin", chance = 65000, maxCount = 19 },
	{ name = "violet crystal shard", chance = 27950, maxCount = 5 },
	{ name = "glowing rune", chance = 21450, maxCount = 5 },
	{ name = "instable proto matter", chance = 16900 },
	{ name = "energy drink", chance = 12350 },
	{ name = "energy bar", chance = 12025 },
	{ name = "energy ball", chance = 10400 },
	{ name = "great mana potion", chance = 10400 },
	{ name = "frozen lightning", chance = 9750 },
	{ id = 28568, chance = 9100 },
	{ name = "blue crystal splinter", chance = 5525 },
	{ name = "small ruby", chance = 4875, maxCount = 5 },
	{ name = "violet gem", chance = 4550, maxCount = 3 },
	{ name = "odd organ", chance = 4550 },
	{ name = "lightning headband", chance = 3900 },
	{ name = "cyan crystal fragment", chance = 3055 },
	{ name = "might ring", chance = 1560 },
	{ name = "wand of defiance", chance = 1235 },
	{ name = "slime heart", chance = 1235 },
	{ name = "lightning pendant", chance = 910 },
	{ name = "piece of dead brain", chance = 715 },
	{ name = "spellweaver's robe", chance = 312 },
	{ id = 23531, chance = 1495 },
	{ id = 23533, chance = 1495 },
	{ id = 23529, chance = 1495 },
	{ id = 23544, chance = 1300 },
	{ id = 23542, chance = 1300 },
	{ id = 23543, chance = 1300 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_ENERGYDAMAGE, minDamage = -500, maxDamage = -700, length = 7, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -600, maxDamage = -850, radius = 4, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -580, radius = 3, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "energy strike", interval = 2000, chance = 18, minDamage = -600, maxDamage = -800, range = 7, target = false },
}

monster.defenses = {
	defense = 78,
	armor = 78,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 100 },
	{ type = COMBAT_DEATHDAMAGE, percent = -15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
