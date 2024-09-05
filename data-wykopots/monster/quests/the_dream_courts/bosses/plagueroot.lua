local mType = Game.createMonsterType("Plagueroot")
local monster = {}

monster.description = "a Plagueroot"
monster.experience = 55000
monster.outfit = {
	lookType = 1121,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 200000
monster.maxHealth = 200000
monster.race = "venom"
monster.corpse = 30022
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
	{ name = "platinum coin", chance = 100000, maxCount = 5 },
	{ name = "crystal Coin", chance = 26000, maxCount = 3 },
	{ name = "piggy Bank", chance = 90000 },
	{ name = "mysterious Remains", chance = 90000 },
	{ name = "energy Bar", chance = 85000 },
	{ name = "silver Token", chance = 100000, minCount = 2, maxCount = 5 },
	{ name = "gold Token", chance = 54000, minCount = 2, maxCount = 2 },
	{ name = "supreme Health Potion", chance = 60000 },
	{ name = "ultimate Mana Potion", chance = 60000 },
	{ name = "huge Chunk of Crude Iron", chance = 27550 },
	{ name = "royal Star", chance = 15770, minCount = 50, maxCount = 100 },
	{ name = "green Gem", chance = 12800, maxCount = 2 },
	{ name = "yellow Gem", chance = 12000, maxCount = 2 },
	{ id = 3039, chance = 12700, maxCount = 2 },
	{ name = "bullseye Potion", chance = 25000, maxCount = 10 },
	{ name = "pomegranate", chance = 16000 },
	{ name = "skull Staff", chance = 20000 },
	{ name = "chaos Mace", chance = 2400 },
	{ id = 3341, chance = 2400 }, -- arcane staff
	{ name = "gold Ingot", chance = 24000 },
	{ id = 23543, chance = 2500 },
	{ id = 281, chance = 2600 },
	{ name = "blue Gem", chance = 11000 },
	{ name = "giant emerald", chance = 4700 },
	{ name = "violet Gem", chance = 7000, maxCount = 2 },
	{ name = "living Armor", chance = 4000 },
	{ name = "magic Sulphur", chance = 4700 },
	{ name = "mastermind Potion", chance = 8000, maxCount = 10 },
	{ id = 23529, chance = 8000 },
	{ name = "ring of the Sky", chance = 2400 },
	{ name = "living Vine Bow", chance = 4000 },
	{ name = "abyss Hammer", chance = 2400 },
	{ id = 23531, chance = 9000 },
	{ name = "plagueroot Offshoot", chance = 2400 },
	{ name = "turquoise Tendril Lantern", chance = 1000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1000 },
	{ name = "terra strike", interval = 2000, chance = 50, minDamage = -300, maxDamage = -900, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -1300, length = 8, spread = 0, effect = CONST_ME_GREEN_RINGS, target = false },
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -1500, length = 8, spread = 0, effect = CONST_ME_STONE_STORM, target = false },
}

monster.defenses = {
	defense = 150,
	armor = 165,
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_HEALING, minDamage = 500, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_HEALING, minDamage = 200, maxDamage = 300, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 1000, chance = 10, speedChange = 700, effect = CONST_ME_MAGIC_RED, target = false, duration = 3000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
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
