local mType = Game.createMonsterType("Gochabaal")
local monster = {}

monster.description = "Gochabaal"
monster.experience = 50000
monster.outfit = {
	lookType = 201,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 120000
monster.maxHealth = 120000
monster.race = "fire"
monster.corpse = 4097
monster.speed = 190
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 201,
	bossRace = RARITY_NEMESIS,
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
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 2500,
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
	maxSummons = 4,
	summons = {
		{ name = "demon", chance = 10, interval = 1000, count = 4 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "ZAMKNIJ PIZDE!", yell = false },
	{ text = "CICHO BADZ!", yell = false },
	{ text = "IDZ SPAC!", yell = false },
	{ text = "ZAMKNIJ SIE!", yell = false },
	{ text = "WYPIERDALAJ!", yell = false },
	{ text = "GUT GUT", yell = false },
	{ text = "SENKJU RICZARD", yell = false },
	{ text = "DEBILU", yell = false },
}

monster.loot = {
	{ name = "golden raid token", chance = 100000, unique = 1 },
	{ name = "silver raid token", chance = 100000, maxCount = 5 },
	{ name = "demonic essence", chance = 100000 },
	{ name = "platinum coin", chance = 100000, maxCount = 69 },
	{ id = 6299, chance = 50000 },
	{ id = 5954, chance = 50000 },
	{ id = 3026, chance = 33333, maxCount = 15 },
	{ id = 3356, chance = 33333 },
	{ name = "great mana potion", chance = 33333 },
	{ id = 3098, chance = 33333 },
	{ id = 3029, chance = 33333, maxCount = 8 },
	{ id = 7643, chance = 33333 },
	{ id = 3027, chance = 25000, maxCount = 8 },
	{ id = 3420, chance = 25000 },
	{ id = 3281, chance = 25000 },
	{ id = 3032, chance = 25000, maxCount = 7 },
	{ id = 3041, chance = 20000 },
	{ id = 3008, chance = 20000 },
	{ name = "great health potion", chance = 20000 },
	{ id = 3062, chance = 20000 },
	{ id = 3084, chance = 20000 },
	{ id = 2848, chance = 20000 },
	{ id = 3054, chance = 20000 },
	{ id = 3033, chance = 20000, maxCount = 17 },
	{ id = 3028, chance = 20000, maxCount = 5 },
	{ id = 3058, chance = 20000 },
	{ id = 3034, chance = 20000, maxCount = 3 },
	{ name = "assassin star", chance = 12500, maxCount = 42 },
	{ id = 3079, chance = 12500 },
	{ id = 3320, chance = 12500 },
	{ name = "golden legs", chance = 12500 },
	{ id = 2903, chance = 12500 },
	{ id = 7642, chance = 12500 },
	{ id = 3061, chance = 12500 },
	{ id = 3055, chance = 12500 },
	{ id = 3265, chance = 12500 },
	{ id = 3322, chance = 6666 },
	{ name = "gold ingot", chance = 6666 },
	{ id = 3309, chance = 6666 },
	{ id = 3306, chance = 6666 },
	{ id = 3038, chance = 6666 },
	{ id = 3046, chance = 6666 },
	{ id = 3366, chance = 6666 },
	{ id = 3414, chance = 6666 },
	{ id = 3048, chance = 6666 },
	{ id = 3060, chance = 6666 },
	{ id = 5808, chance = 6666 },
	{ id = 3290, chance = 6666 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 190, attack = 199 },
	{ name = "combat", interval = 1000, chance = 13, type = COMBAT_MANADRAIN, minDamage = -300, maxDamage = -600, range = 7, target = false },
	{ name = "combat", interval = 1000, chance = 6, type = COMBAT_MANADRAIN, minDamage = -150, maxDamage = -350, radius = 5, effect = CONST_ME_POISONAREA, target = false },
	{ name = "effect", interval = 1000, chance = 6, radius = 5, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 1000, chance = 34, type = COMBAT_FIREDAMAGE, minDamage = -310, maxDamage = -600, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "firefield", interval = 1000, chance = 10, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_LIFEDRAIN, minDamage = -500, maxDamage = -850, length = 8, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -250, maxDamage = -400, range = 1, radius = 1, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true },
}

monster.defenses = {
	defense = 111,
	armor = 90,
	{ name = "combat", interval = 1000, chance = 9, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 2500, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 1000, chance = 20, type = COMBAT_HEALING, minDamage = 600, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 1000, chance = 5, speedChange = 1901, effect = CONST_ME_MAGIC_RED, target = false, duration = 7000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -1 },
	{ type = COMBAT_HOLYDAMAGE, percent = -1 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
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
