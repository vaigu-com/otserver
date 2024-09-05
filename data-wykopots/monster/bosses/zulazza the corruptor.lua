local mType = Game.createMonsterType("Zulazza the Corruptor")
local monster = {}

monster.description = "a zulazza the corruptor"
monster.experience = 9800
monster.outfit = {
	lookType = 334,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 38000
monster.maxHealth = 38000
monster.race = "blood"
monster.corpse = 10190
monster.speed = 145
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 30,
}

monster.strategiesTarget = {
	nearest = 60,
	health = 15,
	damage = 15,
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
	staticAttackChance = 80,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I'm Zulazza, and you won't forget me that fazzt.", yell = false },
	{ text = "Oh, HE will take revenge on zzizz azzault when you zztep in front of HIZZ fazze!", yell = false },
}

monster.loot = {
	{ name = "golden raid token", chance = 100000, unique = 1 },
	{ name = "silver raid token", chance = 100000, maxCount = 3 },
	{ name = "great health potion", chance = 30500 },
	{ name = "platinum coin", chance = 41325, maxCount = 30 },
	{ name = "gold coin", chance = 49650, maxCount = 100 },
	{ id = 8894, chance = 50500 },
	{ name = "gold ingot", chance = 60000, maxCount = 4 },
	{ id = 3041, chance = 30500 },
	{ id = 3038, chance = 20500 },
	{ id = 7643, chance = 10500 },
	{ id = 10201, chance = 5500 },
	{ name = "soul orb", chance = 19250, maxCount = 4 },
	{ id = 3428, chance = 15500 },
	{ id = 7366, chance = 8100, maxCount = 67 },
	{ id = 281, chance = 28000, maxCount = 2 },
	{ id = 3037, chance = 20500 },
	{ id = 3039, chance = 20500 },
	{ id = 7440, chance = 10500 },
	{ id = 3036, chance = 25500 },
	{ name = "great mana potion", chance = 20500 },
	{ id = 8054, chance = 5500 },
	{ id = 3414, chance = 8000 },
	{ id = 3010, chance = 10500 },
	{ id = 8063, chance = 11000 },
	{ id = 3415, chance = 11000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 200, attack = 200 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -900, length = 8, spread = 0, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -500, range = 7, radius = 3, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_SMALLPLANTS, target = true },
	{ name = "zulazza the corruptor skill reducer", interval = 2000, chance = 12, range = 7, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -400, maxDamage = -800, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -250, range = 7, radius = 4, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_GROUNDSHAKER, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -250, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_CARNIPHILA, target = true },
	{ name = "zulazza the corruptor paralyze", interval = 2000, chance = 10, range = 7, target = false },
}

monster.defenses = {
	defense = 67,
	armor = 51,
	{ name = "combat", interval = 2000, chance = 60, type = COMBAT_HEALING, minDamage = 225, maxDamage = 270, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 70 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
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
