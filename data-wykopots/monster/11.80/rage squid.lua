local mType = Game.createMonsterType("Rage Squid")
local monster = {}

monster.description = "a rage squid"
monster.experience = 14820
monster.outfit = {
	lookType = 1059,
	lookHead = 94,
	lookBody = 78,
	lookLegs = 79,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.raceId = 1668
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

monster.health = 17000
monster.maxHealth = 17000
monster.race = "blood"
monster.corpse = 28782
monster.speed = 215
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	{ text = "The blood in your veins shall freeze!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 65000, maxCount = 29 },
	{ name = "ultimate health potion", chance = 31700, maxCount = 5 },
	{ name = "glowing rune", chance = 15951, maxCount = 3 },
	{ name = "great spirit potion", chance = 15749, maxCount = 3 },
	{ name = "great mana potion", chance = 14553, maxCount = 3 },
	{ name = "fire mushroom", chance = 14157, maxCount = 6 },
	{ name = "small amethyst", chance = 6675, maxCount = 5 },
	{ id = 28568, chance = 7377 },
	{ name = "small topaz", chance = 5200, maxCount = 5 },
	{ name = "fire axe", chance = 5200 },
	{ name = "demonic essence", chance = 6175 },
	{ name = "small emerald", chance = 4933, maxCount = 5 },
	{ name = "small ruby", chance = 3900, maxCount = 5 },
	{ name = "talon", chance = 2392 },
	{ name = "giant sword", chance = 1040 },
	{ id = 3039, chance = 1300 },
	{ name = "platinum amulet", chance = 1592 },
	{ name = "demon shield", chance = 1592 },
	{ name = "might ring", chance = 1397 },
	{ name = "piece of dead brain", chance = 1397 },
	{ name = "poisonous slime", chance = 1397 },
	{ name = "orb", chance = 1397 },
	{ name = "demonrage sword", chance = 650 },
	{ name = "purple tome", chance = 396 },
	{ id = 7393, chance = 52 },
	{ name = "wand of everblazing", chance = 195 },
	{ name = "magic plate armor", chance = 195 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -500, length = 7, spread = 0, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -600, maxDamage = -750, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_HITBYFIRE, target = true },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -700, radius = 3, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_FIREDAMAGE, minDamage = -850, maxDamage = -1200, radius = 2, effect = CONST_ME_FIREAREA, target = false },
	{ name = "fireball rune", interval = 2000, chance = 18, minDamage = -600, maxDamage = -750, range = 7, target = false },
}

monster.defenses = {
	defense = 78,
	armor = 78,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
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
