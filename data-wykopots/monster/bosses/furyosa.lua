local mType = Game.createMonsterType("Furyosa")
local monster = {}

monster.description = "Furyosa"
monster.experience = 11500
monster.outfit = {
	lookType = 149,
	lookHead = 94,
	lookBody = 77,
	lookLegs = 96,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 35000
monster.maxHealth = 35000
monster.race = "blood"
monster.corpse = 18118
monster.speed = 205
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 8,
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

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "Fury", chance = 10, interval = 2000, count = 4 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "MUHAHA!", yell = false },
	{ text = "Die!", yell = false },
	{ text = "Dieeee!", yell = false },
	{ text = "Caaarnaaage!", yell = false },
	{ text = "Ahhhhrrrr!", yell = false },
}

monster.loot = {
	{ name = "golden raid token", chance = 100000, unique = 1 },
	{ name = "silver raid token", chance = 40000, maxCount = 2 },
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ id = 8016, chance = 100000, maxCount = 5 },
	{ name = "platinum coin", chance = 85000, maxCount = 25 },
	{ name = "flask of demonic blood", chance = 35000, maxCount = 3 },
	{ name = "demonic essence", chance = 42500 },
	{ name = "golden legs", chance = 8000 },
	{ name = "great health potion", chance = 10500 },
	{ id = 3577, chance = 25000 },
	{ id = 7456, chance = 20000 },
	{ name = "orichalcum pearl", chance = 1500, maxCount = 4 },
	{ id = 5911, chance = 8000 },
	{ id = 8899, chance = 19200 },
	{ id = 3003, chance = 80000, maxCount = 3 },
	{ name = "soul orb", chance = 21500 },
	{ name = "steel boots", chance = 7900 },
	{ id = 3065, chance = 25000 },
	{ id = 7404, chance = 6600 },
	{ name = "soul orb", chance = 5000 },
	{ id = 3007, chance = 4100 },
	{ id = 6300, chance = 6000 },
	{ id = 3439, chance = 1000 },
	{ id = 19391, chance = 4000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 115, attack = 100 },
	{ name = "furyosa deathball", interval = 2000, chance = 26, minDamage = -260, maxDamage = -480, target = false },
	{ name = "furyosa manadrain", interval = 2000, chance = 13, minDamage = -50, maxDamage = -210, target = false },
	{ name = "furyosa soulfire", interval = 2000, chance = 13, target = false },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -800, length = 8, spread = 0, target = false },
	{ name = "furyosa skill reducer", interval = 2000, chance = 12, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -150, range = 7, radius = 3, shootEffect = CONST_ANI_WHIRLWINDCLUB, effect = CONST_ME_GROUNDSHAKER, target = true },
}

monster.defenses = {
	defense = 39,
	armor = 32,
	{ name = "invisible", interval = 2000, chance = 15, duration = 5000, effect = CONST_ME_TELEPORT },
	{ name = "furyosa heal", interval = 1000, chance = 100, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 40 },
	{ type = COMBAT_HOLYDAMAGE, percent = 40 },
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
