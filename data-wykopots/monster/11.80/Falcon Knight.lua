local mType = Game.createMonsterType("Falcon Knight")
local monster = {}

monster.description = "a falcon knight"
monster.experience = 5985
monster.outfit = {
	lookType = 1071,
	lookHead = 57,
	lookBody = 96,
	lookLegs = 38,
	lookFeet = 105,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 1646
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Falcon Bastion.",
}

monster.health = 9000
monster.maxHealth = 9000
monster.race = "undead"
monster.corpse = 28622
monster.speed = 110
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
	illusionable = true,
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
	{ name = "ham", chance = 55200 },
	{ name = "soul orb", chance = 28000 },
	{ name = "great mana potion", chance = 26672, maxCount = 3 },
	{ name = "great health potion", chance = 25352, maxCount = 3 },
	{ name = "flask of demonic blood", chance = 24256, maxCount = 4 },
	{ name = "assassin star", chance = 20432, maxCount = 10 },
	{ name = "small amethyst", chance = 19888, maxCount = 3 },
	{ name = "small diamond", chance = 12000, maxCount = 3 },
	{ name = "small emerald", chance = 12000, maxCount = 3 },
	{ name = "small ruby", chance = 11840, maxCount = 3 },
	{ name = "onyx arrow", chance = 11792, maxCount = 15 },
	{ name = "small topaz", chance = 4016, maxCount = 3 },
	{ name = "titan axe", chance = 2392 },
	{ id = 281, chance = 2344 },
	{ name = "knight armor", chance = 1656 },
	{ name = "spiked squelcher", chance = 1456 },
	{ id = 28822, chance = 72000 },
	{ name = "green gem", chance = 888 },
	{ name = "war axe", chance = 832 },
	{ name = "golden armor", chance = 808 },
	{ name = "falcon crest", chance = 800 },
	{ name = "violet gem", chance = 760 },
	{ name = "mastermind shield", chance = 500 },
	{ id = 3481, chance = 248 },
	{ id = 3019, chance = 176 },
	{ name = "heavy mace", chance = 168 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -400, maxDamage = -500, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_HOLYDAMAGE, minDamage = -250, maxDamage = -400, length = 4, spread = 0, effect = CONST_ME_HOLYDAMAGE, target = false },
}

monster.defenses = {
	defense = 86,
	armor = 86,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 55 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
