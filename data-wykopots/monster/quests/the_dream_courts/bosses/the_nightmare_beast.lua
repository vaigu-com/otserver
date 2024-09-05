local mType = Game.createMonsterType("The Nightmare Beast")
local monster = {}

monster.description = "a The Nightmare Beast"
monster.experience = 255000
monster.outfit = {
	lookType = 1144,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1718,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 850000
monster.maxHealth = 850000
monster.race = "blood"
monster.corpse = 30159
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.events = {
	"NightmareBeastDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, minCount = 5, maxCount = 5 },
	{ name = "piggy bank", chance = 90000 },
	{ name = "mysterious remains", chance = 90000 },
	{ name = "energy bar", chance = 90000 },
	{ name = "silver token", chance = 100000, minCount = 3, maxCount = 4 },
	{ name = "gold token", chance = 59980, minCount = 3, maxCount = 3 },
	{ name = "ultimate mana potion", chance = 63310, minCount = 6, maxCount = 19 },
	{ name = "supreme health potion", chance = 53240, minCount = 6, maxCount = 19 },
	{ name = "ultimate spirit potion", chance = 47480, minCount = 6, maxCount = 20 },
	{ name = "huge chunk of crude iron", chance = 40290 },
	{ id = 3039, chance = 32370 },
	{ name = "yellow gem", chance = 28780 },
	{ name = "royal star", chance = 25900, minCount = 50, maxCount = 100 },
	{ name = "berserk potion", chance = 24460, maxCount = 10 },
	{ name = "blue gem", chance = 18710 },
	{ name = "mastermind potion", chance = 17990, maxCount = 10 },
	{ name = "green gem", chance = 17270 },
	{ name = "crystal coin", chance = 17270, maxCount = 2 },
	{ name = "skull staff", chance = 16550 },
	{ name = "bullseye potion", chance = 13670, maxCount = 10 },
	{ name = "ice shield", chance = 9670 },
	{ name = "chaos mace", chance = 9670 },
	{ name = "gold ingot", chance = 12950 },
	{ id = 282, chance = 10790 },
	{ id = 23544, chance = 10070 },
	{ id = 23542, chance = 9350 },
	{ id = 23531, chance = 8630 },
	{ name = "ring of the sky", chance = 8630 },
	{ id = 23543, chance = 7910 },
	{ name = "beast's nightmare-cushion", chance = 1500 },
	{ name = "violet gem", chance = 12470 },
	{ name = "magic sulphur", chance = 8470 },
	{ id = 23529, chance = 5040 },
	{ id = 23533, chance = 5040 },
	{ name = "dragon figurine", chance = 5500 },
	{ name = "giant sapphire", chance = 4320 },
	{ name = "giant emerald", chance = 4320 },
	{ name = "purple tendril lantern", chance = 5000 },
	{ name = "turquoise tendril lantern", chance = 5000 },
	{ name = "dark whispers", chance = 2880 },
	{ id = 3341, chance = 2880 }, -- arcane staff
	{ name = "giant ruby", chance = 2880 },
	{ name = "abyss hammer", chance = 2160 },
	{ id = 29428, chance = 2160 },
	{ name = "unicorn figurine", chance = 1000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -1000, maxDamage = -3500 },
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_DEATHDAMAGE, minDamage = -1000, maxDamage = -2100, length = 6, spread = 0, effect = CONST_ME_MORTAREA, target = false }, --beam
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_SMALLCLOUDS, target = false }, --wave
	{ name = "combat", interval = 2000, chance = 60, type = COMBAT_DEATHDAMAGE, minDamage = -700, maxDamage = -1000, range = 7, radius = 5, effect = CONST_ME_MORTAREA, target = true }, --bomb
}

monster.defenses = {
	defense = 50,
	armor = 50,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 0, maxDamage = 3500, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
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
