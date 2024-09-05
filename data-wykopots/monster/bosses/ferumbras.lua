local mType = Game.createMonsterType("Ferumbras")
local monster = {}

monster.description = "Ferumbras"
monster.experience = 12000
monster.outfit = {
	lookType = 229,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 330000
monster.maxHealth = 330000
monster.race = "venom"
monster.corpse = 6078
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 15,
	health = 5,
	damage = 30,
	random = 50,
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
	targetDistance = 2,
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
		{ name = "Demon", chance = 12, interval = 3000, count = 4 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "NOONE WILL STOP ME THIS TIME!", yell = true },
	{ text = "THE POWER IS MINE!", yell = true },
}

monster.loot = {
	{ id = 5903, chance = 100000, unique = 1 },
	{ name = "gold coin", chance = 98000, maxCount = 184 },
	{ id = 3010, chance = 25000 },
	{ id = 3360, chance = 24000 },
	{ name = "soul orb", chance = 24000, maxCount = 9 },
	{ name = "golden legs", chance = 22000 },
	{ id = 8074, chance = 22000 },
	{ id = 3420, chance = 20000 },
	{ id = 821, chance = 20000 },
	{ id = 3033, chance = 15000, maxCount = 60 },
	{ id = 9057, chance = 15000, maxCount = 60 },
	{ name = "gold ingot", chance = 75000, maxCount = 2 },
	{ id = 3032, chance = 15000, maxCount = 80 },
	{ id = 281, chance = 15000, maxCount = 5 },
	{ id = 282, chance = 15000, maxCount = 5 },
	{ id = 3029, chance = 15000, maxCount = 90 },
	{ id = 3026, chance = 16000, maxCount = 80 },
	{ name = "platinum coin", chance = 12000, maxCount = 60 },
	{ id = 8075, chance = 15000 },
	{ id = 7416, chance = 15000 },
	{ id = 823, chance = 15000 },
	{ id = 822, chance = 15000 },
	{ id = 8090, chance = 15000 },
	{ id = 812, chance = 15000 },
	{ id = 8100, chance = 12000 },
	{ id = 8102, chance = 12000 },
	{ id = 7405, chance = 12000 },
	{ id = 7451, chance = 12000 },
	{ id = 3366, chance = 10000 },
	{ id = 3414, chance = 10000 },
	{ id = 7417, chance = 10000 },
	{ id = 8076, chance = 10000 },
	{ id = 7427, chance = 8000 },
	{ id = 8098, chance = 8000 },
	{ id = 8041, chance = 8000 },
	{ id = 8057, chance = 8000 },
	{ id = 3442, chance = 8000 },
	{ id = 3439, chance = 8000 },
	{ id = 7414, chance = 4000 },
	{ id = 7418, chance = 4000 },
	{ id = 7403, chance = 4000 },
	{ id = 7407, chance = 10000 },
	{ id = 8096, chance = 4000 },
	{ name = "vile axe", chance = 8000 },
	{ id = 7411, chance = 8000 },
	{ id = 8040, chance = 8000 },
	{ id = 7382, chance = 8000 },
	{ id = 3422, chance = 5000 },
	{ id = 7422, chance = 5000 },
	{ id = 7423, chance = 5000 },
	{ id = 3303, chance = 4000 },
	{ id = 2993, chance = 4000 },
	{ id = 7410, chance = 2000 },
	{ id = 7435, chance = 2000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 200 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_MANADRAIN, minDamage = -500, maxDamage = -700, range = 7, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -450, length = 8, spread = 0, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "combat", interval = 2000, chance = 21, type = COMBAT_LIFEDRAIN, minDamage = -450, maxDamage = -500, radius = 6, effect = CONST_ME_POFF, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -900, maxDamage = -1500, range = 4, radius = 3, effect = CONST_ME_POFF, target = false },
	-- conditions
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -250, maxDamage = -520, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	{ name = "ferumbras electrify", interval = 2000, chance = 18, target = false },
	{ name = "ferumbras soulfire", interval = 2000, chance = 20, range = 7, target = false },
}

monster.defenses = {
	defense = 110,
	armor = 90,
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_HEALING, minDamage = 600, maxDamage = 2490, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "combat", interval = 2000, chance = 4, type = COMBAT_HEALING, minDamage = 20000, maxDamage = 35000, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "speed", interval = 2000, chance = 14, speedChange = 700, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 7000 },
	{ name = "invisible", interval = 2000, chance = 10, duration = 9000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 90 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
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
