local mType = Game.createMonsterType("Jaglak")
local monster = {}

monster.description = "an jaglak"
monster.experience = 200000
monster.outfit = {
	lookType = 857,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "blood"
monster.corpse = 22143
monster.speed = 35
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 15,
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
	illusionable = true,
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

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 3000,
	chance = 20,
	{ text = "No hejka, co tam sie z toba dzieje?", yell = false },
	{ text = "Skad to zwatpienie?", yell = false },
	{ text = "Musisz isc i walczyc!", yell = false },
	{ text = "Najwazniejsze jest to, ze masz tutaj wole zwyciestwa.", yell = false },
	{ text = "Piescia w stol, ide to przodu i osiagam swoj cel. Pozdro!", yell = false },
	{ text = "Nie wazne, ze wszystko dookola jest przeciwko tobie.", yell = false },
	{ text = "Zjedz chociaz kasze, a mieso zostaw!", yell = false },
}

monster.loot = {
	{ name = "golden raid token", chance = 100000, unique = 1 },
	{ name = "silver raid token", chance = 100000, maxCount = 5 },
	{ name = "platinum coin", chance = 100000, maxCount = 35 },

	{ name = "great mana potion", chance = 60000, minCount = 10, maxCount = 35 },
	{ name = "great health potion", chance = 60000, minCount = 10, maxCount = 35 },
	{ name = "great spirit potion", chance = 60000, minCount = 10, maxCount = 35 },
	{ name = "strong mana potion", chance = 60000, minCount = 20, maxCount = 35 },

	--[[{ name = "small diamond", chance = 20000, minCount = 3, maxCount = 9 },
	{ name = "small emerald", chance = 20000, minCount = 3, maxCount = 9 },
	{ name = "small ruby", chance = 20000, minCount = 3, maxCount = 9 },
	{ name = "small sapphire", chance = 20000, minCount = 3, maxCount = 9 },
	{ name = "small amethyst", chance = 20000, minCount = 3, maxCount = 9 },]]

	{ name = "blue gem", chance = 12000 },
	{ id = 3039, chance = 12000 }, -- red gem
	{ name = "violet gem", chance = 12000 },
	{ name = "green gem", chance = 12000 },

	-- Specific loot
	{ name = "light shovel", chance = 12000 },
	{ name = "golem wrench", chance = 6000 },
	{ name = "diapason", chance = 6000 },
	{ id = 12550, chance = 6000 }, -- golden fir cone -->
	{ name = "candle stump", chance = 6000 },
	{ name = "stone skin amulet", chance = 20000 },
	{ name = "giant sword", chance = 5000 },
	{ name = "onyx chip", chance = 60000, maxCount = 7 },
	{ name = "piece of hell steel", chance = 15000 },
	{ name = "piece of draconian steel", chance = 15000 },
	{ name = "piece of royal steel", chance = 15000 },
	{ name = "shaggy ogre bag", chance = 80000 },
	{ name = "ogre choppa", chance = 12000 },
	{ name = "ogre klubba", chance = 12000 },
	{ name = "onyx flail", chance = 8000 },
	{ name = "pair of iron fists", chance = 15000 },
	{ name = "tower shield", chance = 12000 },
	{ name = "ogre scepta", chance = 12000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -1200, maxDamage = -2500 },
	{ name = "groundshaker", interval = 2000, chance = 25, minDamage = -800, maxDamage = -1300, target = false },
	{ name = "phantasm drown", interval = 2000, chance = 15, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = -650, range = 6, shootEffect = CONST_ANI_WHIRLWINDAXE, target = true, duration = 10000 },
}

monster.defenses = {
	defense = 71,
	armor = 71,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 25 },
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
