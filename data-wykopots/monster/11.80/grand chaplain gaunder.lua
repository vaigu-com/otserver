local mType = Game.createMonsterType("Grand Chaplain Gaunder")
local monster = {}

monster.description = "a grand chaplain gaunder"
monster.experience = 14000
monster.outfit = {
	lookType = 1071,
	lookHead = 57,
	lookBody = 75,
	lookLegs = 5,
	lookFeet = 86,
	lookAddons = 1,
	lookMount = 0,
}

monster.health = 18000
monster.maxHealth = 18000
monster.race = "undead"
monster.corpse = 28733
monster.speed = 155
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
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
	staticAttackChance = 70,
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
	{ name = "ham", chance = 62000, maxCount = 3 },
	{ name = "small diamond", chance = 15000, maxCount = 3 },
	{ name = "small ruby", chance = 8000, maxCount = 3 },
	{ name = "small emerald", chance = 8000, maxCount = 3 },
	{ name = "small amethyst", chance = 8000, maxCount = 3 },
	{ name = "small enchanted amethyst", chance = 100000 },
	{ name = "small topaz", chance = 8000, maxCount = 3 },
	{ id = 282, chance = 2500 },
	{ name = "assassin star", chance = 25000, maxCount = 10 },
	{ name = "great mana potion", chance = 33000, maxCount = 3 },
	{ name = "great health potion", chance = 33000, maxCount = 3 },
	{ name = "onyx arrow", chance = 14500, maxCount = 15 },
	{ name = "mastermind shield", chance = 700 },
	{ name = "knight armor", chance = 1600 },
	{ name = "titan axe", chance = 4500 },
	{ name = "spiked squelcher", chance = 4500 },
	{ name = "heavy mace", chance = 700 },
	{ name = "violet gem", chance = 2300 },
	{ name = "green gem", chance = 2300 },
	{ name = "falcon crest", chance = 2200 },
	{ name = "patch of fine cloth", chance = 3500 },
	{ name = "damaged armor plates", chance = 2000 },
	{ name = "falcon longsword", chance = 150 },
	{ name = "falcon mace", chance = 150 },
	{ name = "falcon battleaxe", chance = 150 },
	{ name = "falcon shield", chance = 150 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -150, maxDamage = -600 },
	{ name = "combat", interval = 2000, chance = 28, type = COMBAT_HOLYDAMAGE, minDamage = -150, maxDamage = -900, length = 5, spread = 0, effect = CONST_ME_HOLYDAMAGE, target = false },
	{ name = "combat", interval = 2000, chance = 28, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -850, radius = 5, effect = CONST_ME_GROUNDSHAKER, target = false },
}

monster.defenses = {
	defense = 50,
	armor = 82,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 200, maxDamage = 550, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 20, speedChange = 220, effect = CONST_ME_POFF, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 50 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 55 },
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
