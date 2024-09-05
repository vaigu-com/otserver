local mType = Game.createMonsterType("Minotaur Amazon")
local monster = {}

monster.description = "a minotaur amazon"
monster.experience = 2200
monster.outfit = {
	lookType = 608,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1045
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Underground Glooth Factory, Oramond Minotaur Camp, Oramond Dungeon.",
}

monster.health = 2600
monster.maxHealth = 2600
monster.race = "blood"
monster.corpse = 21000
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 11,
}

monster.strategiesTarget = {
	nearest = 100,
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
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 240,
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
	{ text = "I'll protect the herd!", yell = false },
	{ text = "Never surrender!", yell = false },
	{ text = "You won't hurt us!", yell = false },
	{ text = "I will not allow your evil to continue!", yell = false },
}

monster.loot = {
	{ name = "assassin star", chance = 3040, maxCount = 5 },
	{ id = 21204, chance = 19830 },
	{ name = "gold coin", chance = 100000, minCount = 9, maxCount = 196 },
	{ name = "ham", chance = 60780 },
	{ id = 3577, chance = 4920 },
	{ name = "platinum coin", chance = 62080, maxCount = 3 },
	{ name = "gold ingot", chance = 290 },
	{ id = 5878, chance = 17950 },
	{ name = "great health potion", chance = 7670 },
	{ name = "great mana potion", chance = 7380 },
	{ id = 11472, chance = 6800, maxCount = 2 },
	{ id = 3098, chance = 3040 },
	{ id = 3030, chance = 5500, maxCount = 2 },
	{ id = 9057, chance = 5500, maxCount = 2 },
	{ id = 3033, chance = 5070, maxCount = 2 },
	{ id = 3032, chance = 4050, maxCount = 2 },
	{ id = 21175, chance = 3040 },
	{ id = 21174, chance = 1740 },
	{ id = 5911, chance = 1010 },
	{ id = 3039, chance = 430 },
	{ id = 3081, chance = 1450 },
	{ id = 3037, chance = 870 },
	{ id = 3369, chance = 1160 },
	{ id = 7443, chance = 720 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 50 },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -480, length = 8, spread = 0, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_LIFEDRAIN, minDamage = -50, maxDamage = -150, radius = 4, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -150, range = 7, shootEffect = CONST_ANI_HUNTINGSPEAR, effect = CONST_ME_EXPLOSIONAREA, target = false },
	-- bleed
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 20, minDamage = -300, maxDamage = -400, radius = 4, shootEffect = CONST_ANI_THROWINGKNIFE, effect = CONST_ME_MAGIC_RED, target = true },
	{ name = "minotaur amazon paralyze", interval = 2000, chance = 10, target = false },
}

monster.defenses = {
	defense = 37,
	armor = 37,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
