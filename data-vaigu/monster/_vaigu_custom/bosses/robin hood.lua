local mType = Game.createMonsterType("Robin Hood")
local monster = {}

monster.name = "Robin Hood"
monster.description = "a robin hood"
monster.experience = 85000
monster.outfit = {
	lookType = 129,
	lookHead = 95,
	lookBody = 101,
	lookLegs = 78,
	lookFeet = 75,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 200000
monster.maxHealth = 200000
monster.race = "blood"
monster.corpse = 18138
monster.speed = 550
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 25,
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
	staticAttackChance = 60,
	targetDistance = 5,
	runHealth = 699990,
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
	maxSummons = 3,
	summons = {
		{ name = "glooth bandit", chance = 20, interval = 1000, count = 3 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Haha, no zlap mnie!", yell = false },
	{ text = "No co jest?", yell = false },
	{ text = "Dzis wale kazdego!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 40000, maxCount = 99 },
	{ name = "platinum coin", chance = 90800, maxCount = 50 },
	{ name = "platinum coin", chance = 90800, maxCount = 50 },
	{ name = "demonic essence", chance = 30000, maxCount = 4 },
	{ id = 7643, chance = 80000, maxCount = 65 },
	{ name = "great mana potion", chance = 80000, maxCount = 65 },
	{ id = 7642, chance = 80000, maxCount = 65 },
	{ id = 6528, chance = 50000, maxCount = 30 },
	{ name = "assassin star", chance = 60000, maxCount = 35 },
	{ id = 761, chance = 60000, maxCount = 55 },
	{ id = 15793, chance = 90000, maxCount = 100 },
	{ id = 3449, chance = 60000, maxCount = 55 },
	{ id = 3033, chance = 6380, maxCount = 5 },
	{ name = "steel boots", chance = 380 },
	{ id = 8029, chance = 20000 },
	{ id = 21982, chance = 2000 },
	{ id = 17858, chance = 7000 },
	{ id = 20274, chance = 3000 },
	{ id = 9597, chance = 8000 },
	{ id = 22084, chance = 4000 },
	{ id = 8028, chance = 500 },
	{ id = 20278, chance = 6000 },
	{ id = 20062, chance = 20000, maxCount = 4 },
	{ id = 9605, chance = 3000 },
	{ id = 10202, chance = 3000 },
	{ id = 16100, chance = 7000 },
	{ id = 9604, chance = 3000 },
	{ id = 2991, chance = 1000 },
	{ id = 3553, chance = 500 },
	{ id = 8027, chance = 5000 },
	{ id = 12519, chance = 3000 },
	{ id = 12548, chance = 3000 },
	{ id = 12549, chance = 3000 },
	{ id = 12550, chance = 3000 },
	{ id = 5907, chance = 3000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -500, maxDamage = -200 },
	{ name = "combat", interval = 2000, chance = 65, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -1300, range = 7, shootEffect = CONST_ANI_ARROW, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -1300, maxDamage = -2800, range = 7, shootEffect = CONST_ANI_ARROW, target = false },
	{ name = "ghastly dragon curse", interval = 2000, chance = 22, range = 6, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -850, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 30000 },
}

monster.defenses = {
	defense = 45,
	armor = 45,
	{ name = "speed", interval = 2000, chance = 25, speedChange = 600, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000 },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 5000, effect = CONST_ME_SLEEP, target = false },
	{ name = "combat", interval = 2000, chance = 2, type = COMBAT_HEALING, minDamage = 10000, maxDamage = 18000, effect = CONST_ME_SLEEP, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
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
