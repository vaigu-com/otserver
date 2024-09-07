local mType = Game.createMonsterType("Duch Mirkotsa")
local monster = {}

monster.description = "duch mirkotsa"
monster.experience = 35000
monster.outfit = {
	lookType = 319,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "undead"
monster.corpse = 11675
monster.speed = 500
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	staticAttackChance = 20,
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
	{ text = "Jestem duchem, ktory doprowadzi do upadku tego swiata..", yell = false },
	{ text = "Ten swiat upadnie, jesli mnie nie pokonacie..", yell = false },
	{ text = "Nikt mnie nie pokona..", yell = false },
	{ text = "Nie oddam mapy..", yell = false },
	{ text = "Poki zyje, nie wyjdzie wam zaden ots..", yell = false },
	{ text = "Mapa? Po moim trupie..", yell = false },
}

monster.loot = {
	{ name = "golden raid token", chance = 100000, unique = 1 },
	{ name = "silver raid token", chance = 100000, maxCount = 5 },
	{ name = "platinum coin", chance = 100000, maxCount = 25 },

	{ name = "great mana potion", chance = 60000, minCount = 10, maxCount = 35 },
	{ name = "great health potion", chance = 60000, minCount = 10, maxCount = 35 },
	{ name = "great spirit potion", chance = 60000, minCount = 10, maxCount = 35 },
	{ name = "strong mana potion", chance = 60000, minCount = 20, maxCount = 35 },

	--[[{ name = "small diamond", chance = 25000, minCount = 3, maxCount = 9 },
	{ name = "small emerald", chance = 25000, minCount = 3, maxCount = 9 },
	{ name = "small ruby", chance = 25000, minCount = 3, maxCount = 9 },
	{ name = "small sapphire", chance = 25000, minCount = 3, maxCount = 9 },
	{ name = "small amethyst", chance = 25000, minCount = 3, maxCount = 9 },]]

	{ name = "blue gem", chance = 12000 },
	{ id = 3039, chance = 12000 }, -- red gem
	{ name = "violet gem", chance = 12000 },
	{ name = "green gem", chance = 12000 },

	-- Specific loot
	{ id = 6569, chance = 60000, maxCount = 20 }, --candy -->
	{ id = 5710, chance = 20000 }, --light shovel -->
	{ id = 646, chance = 20000 }, --elvenhair rope -->
	{ id = 8177, chance = 60000, maxCount = 10 }, -- yummi worms -->
	{ id = 3599, chance = 60000, maxCount = 10 }, -- candy cane -->
	{ id = 12519, chance = 10000 }, -- slug drug -->
	{ id = 12548, chance = 20000 }, -- bag of apple slices -->
	{ id = 12549, chance = 12000 }, -- bamboo leaves -->
	{ id = 12550, chance = 6000 }, -- golden fir cone -->
	{ id = 5907, chance = 20000 }, -- slingshot -->
	{ id = 17858, chance = 6000 }, -- pijawka -->
	{ id = 9605, chance = 15000 }, -- bp -->
	{ id = 10202, chance = 15000 }, -- bp -->
	{ id = 16100, chance = 15000 }, -- bp -->
	{ id = 9604, chance = 15000 }, -- bp -->
	{ id = 2991, chance = 10000 }, -- lalka -->
	{ id = 3553, chance = 10000 }, -- bunny -->
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 40, attack = 90 },
	{ name = "effect", interval = 2000, chance = 12, length = 7, spread = 3, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 20, minDamage = -1100, maxDamage = -2200, radius = 6, effect = CONST_ME_INSECTS, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -250, length = 6, spread = 2, effect = CONST_ME_POISONAREA, target = false },
	{ name = "drunk", interval = 2000, chance = 20, radius = 8, effect = CONST_ME_STUN, target = false, duration = 5000 },
	{ name = "effect", interval = 2000, chance = 14, length = 6, spread = 3, effect = CONST_ME_SOUND_RED, target = false },
	{ name = "outfit", interval = 2000, chance = 20, range = 7, target = false, duration = 4000, outfitMonster = "rat" },
	{ name = "outfit", interval = 2000, chance = 20, range = 7, target = false, duration = 4000, outfitMonster = "rotworm" },
	{ name = "outfit", interval = 2000, chance = 20, range = 7, target = false, duration = 4000, outfitMonster = "snake" },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -50, maxDamage = -100, radius = 8, effect = CONST_ME_MAGIC_GREEN, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 200, maxDamage = 300, effect = CONST_ME_SLEEP, target = false },
	{ name = "combat", interval = 2000, chance = 6, type = COMBAT_HEALING, minDamage = 2000, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 15, duration = 2000, effect = CONST_ME_POFF },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
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
