local mType = Game.createMonsterType("Malofur Mangrinder")
local monster = {}

monster.description = "Malofur Mangrinder"
monster.experience = 55000
monster.outfit = {
	lookType = 1120,
	lookHead = 19,
	lookBody = 22,
	lookLegs = 76,
	lookFeet = 22,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 200000
monster.maxHealth = 200000
monster.race = "blood"
monster.corpse = 30017
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 18,
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
	{ text = "BOOOM!", yell = false },
	{ text = "BOOOOM!!!", yell = false },
	{ text = "BOOOOOM!!!", yell = false },
}

monster.loot = {
	{ name = "ultimate Spirit Potion", chance = 50000, maxCount = 20 },
	{ name = "crystal Coin", chance = 20000 },
	{ name = "ultimate Mana Potion", chance = 50000, maxCount = 20 },
	{ name = "supreme Health Potion", chance = 50000, maxCount = 20 },
	{ name = "gold Token", chance = 50000, minCount = 2, maxCount = 2 },
	{ name = "silver Token", chance = 90000, minCount = 2, maxCount = 3 },
	{ id = 281, chance = 100000 },
	{ name = "green Gem", chance = 50000 },
	{ name = "gold ingot", chance = 24000 },
	{ id = 3039, chance = 50000 },
	{ name = "blue Gem", chance = 40000 },
	{ id = 23529, chance = 50000 },
	{ name = "platinum Coin", chance = 100000, maxCount = 5 },
	{ name = "bullseye Potion", chance = 25000, maxCount = 10 },
	{ name = "piggy Bank", chance = 90000 },
	{ name = "mysterious Remains", chance = 85000 },
	{ name = "energy Bar", chance = 80000 },
	{ id = 23543, chance = 20000 },
	{ name = "ring of the Sky", chance = 10000 },
	{ name = "crunor Idol", chance = 6000 },
	{ name = "resizer", chance = 3000 },
	{ name = "shoulder Plate", chance = 4000 },
	{ name = "malofur's Lunchbox", chance = 5000 },
	{ name = "pomegranate", chance = 50000 },
	{ name = "chaos mace", chance = 5000 },
	{ name = "skull staff", chance = 12000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -600, range = 6, shootEffect = CONST_ANI_LARGEROCK, target = true },
	{ name = "groundshaker", interval = 2000, chance = 30, minDamage = -400, maxDamage = -1800, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -1800, length = 7, spread = 0, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "vampire paralyze", interval = 2000, chance = 13, range = 7, target = false },
}

monster.defenses = {
	defense = 80,
	armor = 80,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 80 },
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
