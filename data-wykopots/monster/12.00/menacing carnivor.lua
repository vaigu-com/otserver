local mType = Game.createMonsterType("Menacing Carnivor")
local monster = {}

monster.description = "a Menacing Carnivor"
monster.experience = 2560
monster.outfit = {
	lookType = 1139,
	lookHead = 50,
	lookBody = 52,
	lookLegs = 61,
	lookFeet = 90,
	lookAddons = 3,
	lookMount = 0,
}

-- monster.raceId = 1723
-- monster.Bestiary = {
-- class = "Magical",
-- race = BESTY_RACE_MAGICAL,
-- toKill = 2500,
-- FirstUnlock = 100,
-- SecondUnlock = 1000,
-- CharmsPoints = 50,
-- Stars = 4,
-- Occurrence = 0,
-- Locations = "Carnivora's Rocks."
-- }

monster.health = 3500
monster.maxHealth = 3500
monster.race = "blood"
monster.corpse = 30103
monster.speed = 170
monster.manaCost = 0

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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
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
	{ text = "Stamp on the ground!!!", yell = false },
	{ text = "Special treatment!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 65000, maxCount = 8 },
	{ name = "morning star", chance = 18200 },
	{ name = "small ruby", chance = 3243 },
	{ name = "terra rod", chance = 4595 },
	{ name = "crystal sword", chance = 4595 },
	{ name = "ultimate mana potion", chance = 9919 },
	{ name = "violet glass plate", chance = 6188 },
	{ name = "small enchanted ruby", chance = 2645 },
	{ name = "terra legs", chance = 2080 },
	{ name = "wand of dragonbreath", chance = 500 },
	{ name = "serpent sword", chance = 1202 },
	{ name = "machete", chance = 1371 },
	{ name = "heavy machete", chance = 1540 },
	{ name = "iron helmet", chance = 663 },
	{ name = "knight legs", chance = 1969 },
	{ name = "wand of starstorm", chance = 1956 },
	{ name = "wand of voodoo", chance = 1579 },
	{ name = "green crystal fragment", chance = 3035 },
	{ name = "onyx chip", chance = 3113 },
	{ name = "opal", chance = 760 },
	{ name = "tiger eye", chance = 1358 },
	{ name = "wand of decay", chance = 513 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -370, condition = { type = CONDITION_POISON, totalDamage = 80, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -140, maxDamage = -200, range = 7, radius = 3, shootEffect = CONST_ANI_POISON, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -170, maxDamage = -250, length = 4, spread = 0, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -170, maxDamage = -230, radius = 4, effect = CONST_ME_GROUNDSHAKER, target = false },
}

monster.defenses = {
	defense = 68,
	armor = 68,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
