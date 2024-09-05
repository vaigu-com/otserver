local mType = Game.createMonsterType("Hirintror")
local monster = {}

monster.description = "Hirintror"
monster.experience = 800
monster.outfit = {
	lookType = 261,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 1500
monster.maxHealth = 1500
monster.race = "undead"
monster.corpse = 7282
monster.speed = 95
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5,
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
	canPushCreatures = false,
	staticAttackChance = 90,
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
	{ text = "Srk.", yell = false },
	{ text = "Krss!", yell = false },
	{ text = "snirr!", yell = false },
	{ text = "Chrrk! Krk!", yell = false },
}

monster.loot = {
	{ id = 19363, chance = 10000 },
	{ name = "gold coin", chance = 70000, maxCount = 100 },
	{ id = 19083, chance = 250 },
	{ id = 19362, chance = 2000 },
	{ id = 3373, chance = 1200 },
	{ id = 3284, chance = 2200 },
	{ id = 7290, chance = 42000 },
	{ id = 7441, chance = 22000 },
	{ id = 819, chance = 29000 },
	{ id = 829, chance = 29000 },
	{ id = 7449, chance = 19000 },
	{ id = 5912, chance = 19000 },
	{ id = 237, chance = 20000, maxCount = 5 },
	{ id = 236, chance = 20000, maxCount = 5 },
	{ id = 3028, chance = 75000, maxCount = 5 },
	{ name = "platinum coin", chance = 890000, maxCount = 10 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 140, attack = 40 },
	{ name = "hirintror freeze", interval = 2000, chance = 15, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -75, maxDamage = -350, range = 7, radius = 3, shootEffect = CONST_ANI_ICE, effect = CONST_ME_BLOCKHIT, target = true },
	{ name = "ice golem paralyze", interval = 2000, chance = 11, target = false },
	{ name = "hirintror skill reducer", interval = 2000, chance = 10, target = false },
}

monster.defenses = {
	defense = 26,
	armor = 25,
	{ name = "hirintror summon", interval = 2000, chance = 18, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 900, maxDamage = 1100, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 100 },
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
