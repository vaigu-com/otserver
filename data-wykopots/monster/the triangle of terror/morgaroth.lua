local mType = Game.createMonsterType("Morgaroth")
local monster = {}

monster.description = "a morgaroth"
monster.experience = 15000
monster.outfit = {
	lookType = 12,
	lookHead = 0,
	lookBody = 94,
	lookLegs = 79,
	lookFeet = 79,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 229,
	bossRace = RARITY_NEMESIS,
}

monster.health = 55000
monster.maxHealth = 55000
monster.race = "undead"
monster.corpse = 6068
monster.speed = 225
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 1500,
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

monster.summon = {
	maxSummons = 6,
	summons = {
		{ name = "Demon", chance = 33, interval = 4000, count = 6 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I AM MORGAROTH, LORD OF THE TRIANGLE... AND YOU ARE LOST!", yell = true },
	{ text = "MY SEED IS FEAR AND MY HARVEST ARE YOUR SOULS!", yell = true },
	{ text = "ZATHROTH! LOOK AT THE DESTRUCTION I AM CAUSING IN YOUR NAME!", yell = true },
	{ text = "THE TRIANGLE OF TERROR WILL RISE!", yell = true },
}

monster.loot = {
	{ name = "golden raid token", chance = 100000, unique = 1 },
	{ name = "silver raid token", chance = 100000, maxCount = 3 },
	{ name = "demonic essence", chance = 50000 },
	{ name = "platinum coin", chance = 50000, maxCount = 74 },
	{ name = "great mana potion", chance = 50000 },
	{ id = 3038, chance = 33333 },
	{ id = 3033, chance = 33333, maxCount = 18 },
	{ id = 8024, chance = 36333 },
	{ id = 3098, chance = 25000 },
	{ id = 3029, chance = 25000, maxCount = 8 },
	{ id = 8025, chance = 25000 },
	{ id = 8022, chance = 22000 },
	{ id = 8037, chance = 20000 },
	{ id = 5954, chance = 20000, maxCount = 2 },
	{ id = 3366, chance = 20000 },
	{ id = 3048, chance = 20000 },
	{ id = 2852, chance = 20000 },
	{ id = 3032, chance = 20000, maxCount = 6 },
	{ id = 7643, chance = 20000 },
	{ name = "assassin star", chance = 16666, maxCount = 28 },
	{ id = 3027, chance = 16666, maxCount = 15 },
	{ id = 6299, chance = 16666 },
	{ id = 7431, chance = 16666 },
	{ id = 3275, chance = 16666 },
	{ id = 8053, chance = 18666 },
	{ id = 2903, chance = 16666 },
	{ id = 3062, chance = 16666 },
	{ id = 5943, chance = 16666 },
	{ id = 8100, chance = 16666 },
	{ id = 3034, chance = 16666, maxCount = 7 },
	{ id = 3041, chance = 11111 },
	{ id = 3281, chance = 11111 },
	{ name = "golden legs", chance = 11111 },
	{ id = 3061, chance = 11111 },
	{ id = 3061, chance = 11111 },
	{ id = 132, chance = 11111 },
	{ id = 8023, chance = 18111 },
	{ id = 3049, chance = 11111 },
	{ name = "steel boots", chance = 11111 },
	{ id = 3058, chance = 11111 },
	{ id = 2993, chance = 18111 },
	{ id = 3026, chance = 11111, maxCount = 13 },
	{ id = 3007, chance = 5882 },
	{ id = 8039, chance = 5882 },
	{ id = 3051, chance = 5882 },
	{ id = 3422, chance = 5882 },
	{ id = 3063, chance = 5882 },
	{ name = "great health potion", chance = 5882 },
	{ id = 7642, chance = 5882 },
	{ id = 3414, chance = 5882 },
	{ id = 8058, chance = 5882 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 215, attack = 200 },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -755, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "morgaroth skill reducer 2", interval = 2000, chance = 7, range = 4, target = false },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_DEATHDAMAGE, minDamage = -455, maxDamage = -880, radius = 8, effect = CONST_ME_MORTAREA, target = false },
	{ name = "morgaroth skill reducer 1", interval = 2000, chance = 8, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -1000, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -400, maxDamage = -630, radius = 8, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "morgaroth paralyze", interval = 2000, chance = 13, target = false },
}

monster.defenses = {
	defense = 130,
	armor = 130,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 825, maxDamage = 1200, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_HEALING, minDamage = 3090, maxDamage = 5780, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 6, speedChange = 920, effect = CONST_ME_MAGIC_RED, target = false, duration = 7000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 80 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 80 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onThink = function(monster, interval) end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
