local mType = Game.createMonsterType("The Mutated Pumpkin")
local monster = {}

monster.description = "a mutated pumpkin"
monster.experience = 55000
monster.outfit = {
	lookType = 292,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 300000
monster.maxHealth = 300000
monster.race = "undead"
monster.corpse = 8133
monster.speed = 290
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
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
	staticAttackChance = 85,
	targetDistance = 1,
	runHealth = 10000,
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
	{ text = "I had the Halloween Hare for breakfast!", yell = false },
	{ text = "Your soul will be mine...wait, wrong line", yell = false },
	{ text = "Trick or treat? I saw death!", yell = false },
	{ text = "No wait! Don't kill me! It's me, your friend!", yell = false },
	{ text = "Bunnies, bah! I'm the real thing!", yell = false },
	{ text = "Muahahahaha!", yell = false },
	{ text = "I've come to avenge all those mutilated pumpkins!", yell = false },
	{ text = "Wait until I get you!", yell = false },
	{ text = "Fear the spirit of Halloween!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, minCount = 10, maxCount = 25 },
	{ id = 22721, chance = 30000, maxCount = 2 },
	{ id = 22516, chance = 30000, maxCount = 2 },
	{ id = 3594, chance = 100000, maxCount = 5 },
	{ id = 8032, chance = 30000 },
	{ id = 6525, chance = 30000 },
	{ id = 22118, chance = 20000 },
	{ id = 8178, chance = 30000 },
	{ id = 6491, chance = 25000 },
	{ id = 6574, chance = 25000 },
	{ id = 3594, chance = 25000 },
	{ id = 2977, chance = 25000 },
	{ id = 3599, chance = 30000, maxCount = 20 },
	{ id = 6569, chance = 30000, maxCount = 30 },
	{ id = 8177, chance = 100000, minCount = 20, maxCount = 30 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
	{ name = "effect", interval = 2000, chance = 12, length = 7, spread = 3, target = false },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_MANADRAIN, minDamage = -5, maxDamage = -12, length = 7, spread = 3, effect = CONST_ME_FIREWORK_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -10, maxDamage = -15, length = 6, spread = 2, effect = CONST_ME_POISONAREA, target = false },
	{ name = "outfit", interval = 2000, chance = 11, length = 8, spread = 0, effect = CONST_ME_SMALLPLANTS, target = false, duration = 4000, outfitItem = 2977 },
	{ name = "drunk", interval = 2000, chance = 13, radius = 8, effect = CONST_ME_STUN, target = false, duration = 25000 },
	{ name = "effect", interval = 2000, chance = 14, length = 6, spread = 3, effect = CONST_ME_SOUND_RED, target = false },
	{ name = "outfit", interval = 2000, chance = 20, range = 7, target = false, duration = 4000, outfitMonster = "the mutated pumpkin" },
}

monster.defenses = {
	defense = 25,
	armor = 18,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 200, maxDamage = 300, effect = CONST_ME_SLEEP, target = false },
	{ name = "invisible", interval = 2000, chance = 9, duration = 5000, effect = CONST_ME_POFF },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 90 },
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
