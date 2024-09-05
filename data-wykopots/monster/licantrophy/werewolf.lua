local mType = Game.createMonsterType("Werewolf")
local monster = {}

monster.description = "a werewolf"
monster.experience = 1900
monster.outfit = {
	lookType = 308,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 510
monster.Bestiary = {
	class = "Lycanthrope",
	race = BESTY_RACE_LYCANTHROPE,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Vengoth Castle, Vengoth Werewolf Cave, Grimvale, were-beasts cave south-west of Edron.",
}

monster.health = 1955
monster.maxHealth = 1955
monster.race = "blood"
monster.corpse = 18098
monster.speed = 140
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10,
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 300,
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

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "War Wolf", chance = 30, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "GRRR", yell = false },
	{ text = "GRROARR", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 99000, maxCount = 230 },
	{ id = 22052, chance = 15200 },
	{ id = 10317, chance = 10000 },
	{ id = 3410, chance = 10000 },
	{ id = 8895, chance = 7900 },
	{ id = 3725, chance = 7000 },
	{ id = 236, chance = 5000 },
	{ id = 3741, chance = 5000 },
	{ id = 5897, chance = 5000 },
	{ id = 3269, chance = 2900 },
	{ id = 7643, chance = 2000 },
	{ id = 7439, chance = 1000 },
	{ id = 3081, chance = 830 },
	{ id = 3055, chance = 720 },
	{ id = 3053, chance = 650 },
	{ id = 3326, chance = 530 },
	{ id = 7383, chance = 440 },
	{ id = 7428, chance = 290 },
	{ id = 7419, chance = 90 },
	{ id = 22083, chance = 350 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -155, radius = 4, effect = CONST_ME_SOUND_RED, target = false },
	{ name = "outfit", interval = 8000, chance = 1, range = 5, effect = CONST_ME_SOUND_BLUE, target = false, duration = 200000, outfitMonster = "Werewolf" },
	{ name = "werewolf skill reducer", interval = 2000, chance = 14, range = 1, effect = CONST_ME_SOUND_RED, target = false },
}

monster.defenses = {
	defense = 34,
	armor = 34,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 10, maxDamage = 125, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_SOUND_PURPLE, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 75 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
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
