local mType = Game.createMonsterType("mad mage")
local monster = {}

monster.description = "a mad mage"
monster.experience = 1800
monster.outfit = {
	lookType = 394,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 2200
monster.maxHealth = 2200
monster.race = "blood"
monster.corpse = 12079
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
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
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 1000,
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
	maxSummons = 1,
	summons = {
		{ name = "stone golem", chance = 10, interval = 1000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "assassin star", chance = 2400, maxCount = 4 },
	{ id = 5911, chance = 800 },
	{ id = 237, chance = 1200, maxCount = 2 },
	{ id = 236, chance = 1300, maxCount = 5 },
	{ name = "gold coin", chance = 100000, maxCount = 66 },
	{ id = 3728, chance = 5000, maxCount = 5 },
	{ name = "gold coin", chance = 100000, maxCount = 20 },
	{ id = 822, chance = 800 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 32, attack = 37 },
	{ name = "combat", interval = 1000, chance = 12, type = COMBAT_FIREDAMAGE, minDamage = -50, maxDamage = -185, range = 7, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "combat", interval = 1400, chance = 24, type = COMBAT_MANADRAIN, minDamage = -30, maxDamage = -90, range = 6, shootEffect = CONST_ANI_ICE, target = false },
	{ name = "firefield", interval = 1600, chance = 20, range = 7, radius = 2, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "combat", interval = 1900, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -70, maxDamage = -150, length = 8, spread = 0, effect = CONST_ME_BIGCLOUDS, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 20,
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_HEALING, minDamage = 35, maxDamage = 80, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = true },
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
