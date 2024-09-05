local mType = Game.createMonsterType("Alptramun")
local monster = {}

monster.description = "Alptramun"
monster.experience = 55000
monster.outfit = {
	lookType = 1143,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 200000
monster.maxHealth = 200000
monster.race = "blood"
monster.corpse = 30155
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	"DreamBossDeath",
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
	{ name = "silver token", chance = 100000, minCount = 3, maxCount = 4 },
	{ name = "skull staff", chance = 30000 },
	{ name = "energy bar", chance = 90000 },
	{ name = "purple Tendril Lantern", chance = 8000 },
	{ name = "crystal coin", chance = 11000 },
	{ name = "blue gem", chance = 25000 },
	{ name = "platinum coin", chance = 90000, maxCount = 5 },
	{ name = "supreme health potion", chance = 21540, maxCount = 20 },
	{ name = "ultimate spirit potion", chance = 22540, maxCount = 20 },
	{ name = "royal star", chance = 25000, minCount = 50, maxCount = 100 },
	{ id = 281, chance = 28540 },
	{ name = "gold Token", chance = 65000, maxCount = 2 },
	{ name = "berserk potion", chance = 10000, maxCount = 10 },
	{ name = "bullseye potion", chance = 10000, maxCount = 10 },
	{ id = 23542, chance = 23520 },
	{ id = 23544, chance = 15000 },
	{ name = "gold Ingot", chance = 11000 },
	{ name = "huge Chunk of Crude Iron", chance = 40000 },
	{ name = "mysterious Remains", chance = 90000 },
	{ name = "piggy Bank", chance = 90000 },
	{ name = "green gem", chance = 20000 },
	{ id = 3039, chance = 20000 },
	{ name = "crunor Idol", chance = 5000 },
	{ name = "giant Ruby", chance = 3000 },
	{ name = "magic Sulphur", chance = 3000 },
	{ name = "yellow gem", chance = 40000 },
	{ name = "mastermind potion", chance = 11000, maxCount = 10 },
	{ name = "violet gem", chance = 15000 },
	{ name = "alptramun's Toothbrush", chance = 11000 },
	{ name = "dream Shroud", chance = 8000 },
	{ name = "chaos mace", chance = 7500 },
	{ name = "pair of Dreamwalkers", chance = 4000 },
	{ id = 23529, chance = 15000 },
	{ name = "pomegranate", chance = 25000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -700, maxDamage = -2000, length = 6, spread = 0, effect = CONST_ME_SMALLCLOUDS, target = false }, --beam
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -700, range = 5, radius = 3, effect = CONST_ME_MORTAREA, target = true }, --bomb
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -700, length = 6, spread = 3, effect = CONST_ME_MAGIC_RED, target = false }, --wave
	{ name = "stone shower rune", interval = 2000, chance = 20, minDamage = -230, maxDamage = -450, range = 7, target = false },
}

monster.defenses = {
	defense = 80,
	armor = 80,
	{ name = "invisible", interval = 2000, chance = 5, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
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
