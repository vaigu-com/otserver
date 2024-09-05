local mType = Game.createMonsterType("Maxxenius")
local monster = {}

monster.description = "a Maxxenius"
monster.experience = 55000
monster.outfit = {
	lookType = 1142,
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
monster.corpse = 30151
monster.speed = 125
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
	{ name = "platinum Coin", chance = 100000, maxCount = 5 },
	{ name = "mysterious Remains", chance = 80000 },
	{ name = "piggy Bank", chance = 85000 },
	{ name = "brain in a Jar", chance = 3000 },
	{ name = "maxxenius Head", chance = 8000 },
	{ name = "silver Token", chance = 96000, minCount = 2, maxCount = 3 },
	{ name = "energy Bar", chance = 80000 },
	{ name = "crystal Coin", chance = 13790, maxCount = 3 },
	{ name = "gold Ingot", chance = 17240 },
	{ name = "bullseye Potion", chance = 24114, maxCount = 10 },
	{ name = "mastermind Potion", chance = 17240, maxCount = 10 },
	{ name = "royal Star", chance = 55000, minCount = 50, maxCount = 100 },
	{ name = "supreme Health Potion", chance = 41380, maxCount = 20 },
	{ name = "ultimate Spirit Potion", chance = 48280, maxCount = 20 },
	{ name = "ultimate Mana Potion", chance = 68970, maxCount = 14 },
	{ name = "giant Ruby", chance = 3450 },
	{ name = "ornate Locket", chance = 3450 },
	{ name = "gold Token", chance = 60000, minCount = 2, maxCount = 2 },
	{ id = 281, chance = 28540 },
	{ name = "pomegranate", chance = 24140 },
	{ name = "chaos Mace", chance = 8000 },
	{ id = 23544, chance = 17240 },
	{ id = 23543, chance = 13790 },
	{ name = "green Gem", chance = 31030 },
	{ name = "yellow Gem", chance = 31030 },
	{ name = "violet Gem", chance = 6900 },
	{ name = "blue Gem", chance = 13000 },
	{ name = "huge Chunk of Crude Iron", chance = 40000 },
	{ id = 23529, chance = 3450 },
	{ name = "skull Staff", chance = 20000 },
	{ name = "energized Limb", chance = 4000 },
	{ name = "purple Tendril Lantern", chance = 1500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1300 },
	{ name = "energy beam", interval = 2000, chance = 35, minDamage = -500, maxDamage = -1500, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "energy wave", interval = 2000, chance = 35, minDamage = -500, maxDamage = -1500, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = false },
}

monster.defenses = {
	defense = 100,
	armor = 100,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
