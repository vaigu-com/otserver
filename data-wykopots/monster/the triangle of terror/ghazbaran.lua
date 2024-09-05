local mType = Game.createMonsterType("Ghazbaran")
local monster = {}

monster.description = "a ghazbaran"
monster.experience = 15000
monster.outfit = {
	lookType = 12,
	lookHead = 0,
	lookBody = 123,
	lookLegs = 97,
	lookFeet = 94,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 180000
monster.maxHealth = 180000
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
	runHealth = 3500,
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
		{ name = "Deathslicer", chance = 20, interval = 4000, count = 4 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "COME AND GIVE ME SOME AMUSEMENT", yell = false },
	{ text = "IS THAT THE BEST YOU HAVE TO OFFER?", yell = true },
	{ text = "I AM GHAZBARAN OF THE TRIANGLE... AND I AM HERE TO CHALLENGE YOU ALL.", yell = true },
	{ text = "FLAWLESS VICTORY!", yell = true },
}

monster.loot = {
	{ name = "golden raid token", chance = 100000, unique = 1 },
	{ name = "silver raid token", chance = 100000, maxCount = 3 },
	{ name = "demonic essence", chance = 100000 },
	{ name = "platinum coin", chance = 100000, maxCount = 69 },
	{ id = 5954, chance = 33333, maxCount = 2 },
	{ id = 3028, chance = 25000, maxCount = 5 },
	{ id = 6299, chance = 25000 },
	{ id = 7642, chance = 25000 },
	{ id = 8076, chance = 25000 },
	{ id = 7643, chance = 25000 },
	{ id = 3026, chance = 25000, maxCount = 15 },
	{ name = "great health potion", chance = 20000 },
	{ id = 3098, chance = 20000 },
	{ id = 3032, chance = 25000, maxCount = 10 },
	{ id = 2850, chance = 20000 },
	{ name = "great mana potion", chance = 20000 },
	{ id = 3038, chance = 20000 },
	{ id = 3062, chance = 20000 },
	{ id = 132, chance = 20000 },
	{ id = 3033, chance = 25000, maxCount = 17 },
	{ id = 3029, chance = 25000, maxCount = 10 },
	{ id = 8073, chance = 20000 },
	{ id = 3063, chance = 20000 },
	{ id = 8090, chance = 20000 },
	{ id = 7405, chance = 16666 },
	{ id = 8056, chance = 16666 },
	{ id = 8075, chance = 16666 },
	{ id = 3041, chance = 14285 },
	{ id = 7433, chance = 14285 },
	{ id = 6553, chance = 14285 },
	{ name = "assassin star", chance = 12500, maxCount = 44 },
	{ id = 3420, chance = 12500 },
	{ id = 3061, chance = 12500 },
	{ id = 3048, chance = 12500 },
	{ id = 3049, chance = 12500 },
	{ id = 3034, chance = 12500, maxCount = 7 },
	{ id = 2993, chance = 12500 },
	{ id = 3027, chance = 11111, maxCount = 14 },
	{ id = 8074, chance = 11111 },
	{ id = 3058, chance = 11111 },
	{ id = 3335, chance = 11111 },
	{ id = 3007, chance = 8333 },
	{ id = 8059, chance = 8333 },
	{ id = 823, chance = 8333 },
	{ id = 3360, chance = 8333 },
	{ id = 3555, chance = 8333 },
	{ id = 3366, chance = 8333 },
	{ id = 3422, chance = 5882 },
	{ id = 3414, chance = 4000 },
	{ id = 3281, chance = 4000 },
	{ id = 7455, chance = 8000 },
	{ name = "golden legs", chance = 7000 },
	{ id = 7454, chance = 6500 },
	{ id = 8042, chance = 9000 },
	{ id = 8038, chance = 9000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 290, attack = 200 },
	{ name = "ghazbaran paralyze", interval = 2000, chance = 12, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -430, maxDamage = -800, radius = 7, effect = CONST_ME_BIGPLANTS, target = false },
	{ name = "combat", interval = 2000, chance = 9, type = COMBAT_MANADRAIN, minDamage = -535, maxDamage = -965, radius = 7, effect = CONST_ME_LOSEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_DEATHDAMAGE, minDamage = -510, maxDamage = -800, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "melee", interval = 3000, chance = 17, minDamage = -120, maxDamage = -2000 },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 19, type = COMBAT_HEALING, minDamage = 440, maxDamage = 6400, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 5000, chance = 14, type = COMBAT_HEALING, minDamage = 1900, maxDamage = 5000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 9, speedChange = 1000, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
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
