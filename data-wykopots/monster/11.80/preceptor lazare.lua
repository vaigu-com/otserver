local mType = Game.createMonsterType("Preceptor Lazare")
local monster = {}

monster.description = "a preceptor lazare"
monster.experience = 10000
monster.outfit = {
	lookType = 1078,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 15000
monster.maxHealth = 15000
monster.race = "blood"
monster.corpse = 28644
monster.speed = 155
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
	"FalconBossDeath",
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
	{ name = "gold coin", chance = 100000, maxCount = 185 },
	{ name = "platinum coin", chance = 100000, maxCount = 15 },
	{ name = "small enchanted amethyst", chance = 95000 },
	{ name = "ham", chance = 60000, maxCount = 2 },
	{ name = "great health potion", chance = 50000, maxCount = 3 },
	{ name = "soul orb", chance = 42000 },
	{ name = "demonic essence", chance = 31000 },
	{ name = "small emerald", chance = 29000, maxCount = 5 },
	{ id = 3039, chance = 25000 },
	{ name = "assassin star", chance = 25000, maxCount = 10 },
	{ name = "flask of demonic blood", chance = 25000 },
	{ name = "small diamond", chance = 21000, maxCount = 5 },
	{ name = "great mana potion", chance = 21000, maxCount = 3 },
	{ name = "onyx arrow", chance = 17000, maxCount = 15 },
	{ name = "small ruby", chance = 17000, maxCount = 5 },
	{ name = "small topaz", chance = 14000, maxCount = 5 },
	{ name = "small amethyst", chance = 14000, maxCount = 5 },
	{ name = "knight armor", chance = 14000 },
	{ name = "gold ingot", chance = 10000, maxCount = 2 },
	{ id = 282, chance = 8500 },
	{ name = "titan axe", chance = 6400 },
	{ name = "golden armor", chance = 2000 },
	{ name = "spiked squelcher", chance = 2000 },
	{ name = "patch of fine cloth", chance = 2000 },
	{ id = 3019, chance = 1500 },
	{ name = "violet gem", chance = 2000 },
	{ name = "green gem", chance = 2000 },
	{ name = "war axe", chance = 800 },
	{ name = "mastermind shield", chance = 200 },
	{ name = "falcon rod", chance = 100 },
	{ name = "falcon greaves", chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HOLYDAMAGE, minDamage = -500, maxDamage = -700, length = 5, spread = 0, effect = CONST_ME_HOLYDAMAGE, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HOLYDAMAGE, minDamage = -300, maxDamage = -800, range = 7, radius = 5, effect = CONST_ME_HOLYAREA, target = false },
}

monster.defenses = {
	defense = 60,
	armor = 60,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 200, maxDamage = 800, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
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
