local mType = Game.createMonsterType("Ushuriel")
local monster = {}

monster.description = "Ushuriel"
monster.experience = 10500
monster.outfit = {
	lookType = 12,
	lookHead = 0,
	lookBody = 95,
	lookLegs = 19,
	lookFeet = 112,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 31500
monster.maxHealth = 31500
monster.race = "fire"
monster.corpse = 7893
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
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
	staticAttackChance = 85,
	targetDistance = 1,
	runHealth = 1500,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.events = {
	"InquisitionBossDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You can't run or hide forever!", yell = true },
	{ text = "I'm the executioner of the Seven!", yell = true },
	{ text = "The final punishment awaits you!", yell = true },
	{ text = "The judgement is guilty! The sentence is death!", yell = true },
}

monster.loot = {
	{ name = "demonic essence", chance = 100000 },
	{ id = 3725, chance = 88000, maxCount = 30 },
	{ name = "gold coin", chance = 88000, maxCount = 190 },
	{ id = 5880, chance = 39000, maxCount = 10 },
	{ id = 5925, chance = 32000, maxCount = 20 },
	{ name = "great health potion", chance = 24000 },
	{ id = 7391, chance = 24000 },
	{ id = 3062, chance = 23000 },
	{ id = 3392, chance = 22000 },
	{ id = 7643, chance = 22000 },
	{ name = "great mana potion", chance = 21000 },
	{ id = 5741, chance = 21000 },
	{ id = 7642, chance = 20000 },
	{ id = 8896, chance = 20000 },
	{ id = 3369, chance = 20000 },
	{ name = "platinum coin", chance = 20000, maxCount = 26 },
	{ name = "gold ingot", chance = 19000 },
	{ id = 3061, chance = 17000 },
	{ id = 3060, chance = 17000 },
	{ id = 3280, chance = 15000 },
	{ id = 5892, chance = 14285 },
	{ id = 5668, chance = 12500 },
	{ id = 3307, chance = 12000 },
	{ id = 7385, chance = 11000 },
	{ id = 3271, chance = 9600 },
	{ id = 5954, chance = 9000, maxCount = 2 },
	{ id = 7402, chance = 10200 },
	{ id = 3373, chance = 8200 },
	{ id = 5891, chance = 7500 },
	{ id = 3281, chance = 7500 },
	{ id = 7417, chance = 6900 },
	{ id = 3385, chance = 6200 },
	{ id = 5885, chance = 5550 },
	{ id = 5884, chance = 6800 },
	{ id = 6103, chance = 2000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 110, attack = 200 },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -500, length = 10, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -600, length = 10, spread = 0, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_ICEDAMAGE, minDamage = -200, maxDamage = -430, length = 10, spread = 1, effect = CONST_ME_ICEATTACK, target = false },
	{ name = "drunk", interval = 2000, chance = 10, radius = 8, effect = CONST_ME_SOUND_PURPLE, target = false, duration = 5000 },
	{ name = "ushuriel electrify", interval = 2000, chance = 15, target = false },
	{ name = "ushuriel curse", interval = 2000, chance = 15, target = false },
}

monster.defenses = {
	defense = 45,
	armor = 50,
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 440, maxDamage = 550, effect = CONST_ME_MAGIC_GREEN, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
