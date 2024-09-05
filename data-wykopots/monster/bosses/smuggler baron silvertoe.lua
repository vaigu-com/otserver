local mType = Game.createMonsterType("Smuggler Baron Silvertoe")
local monster = {}

monster.description = "Smuggler Baron Silvertoe"
monster.experience = 170
monster.outfit = {
	lookType = 134,
	lookHead = 38,
	lookBody = 0,
	lookLegs = 94,
	lookFeet = 95,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 280
monster.maxHealth = 280
monster.race = "blood"
monster.corpse = 18225
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 15,
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

monster.summon = {
	maxSummons = 3,
	summons = {
		{ name = "Wild Warrior", chance = 20, interval = 2000, count = 3 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I will make your death look like an accident!", yell = false },
	{ text = "You should not have interferred with my bussiness!", yell = false },
	{ text = "Bribes are expensive, murder is cheap!", yell = false },
	{ text = "I see some profit in your death!", yell = false },
	{ text = "I expect you to die!", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 100000 },
	{ name = "platinum coin", chance = 90000, maxCount = 20 },
	{ id = 2920, chance = 30200, maxCount = 2 },
	{ id = 3559, chance = 14000 },
	{ name = "ham", chance = 10000 },
	{ id = 3294, chance = 10000 },
	{ id = 3355, chance = 10000 },
	{ id = 3291, chance = 10000 },
	{ id = 3264, chance = 5000 },
	{ id = 8012, chance = 5000, maxCount = 5 },
	{ id = 3292, chance = 4000 },
	{ id = 7397, chance = 11000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -50 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -40, range = 7, shootEffect = CONST_ANI_THROWINGKNIFE, target = false },
}

monster.defenses = {
	defense = 15,
	armor = 15,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 10, maxDamage = 50, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
