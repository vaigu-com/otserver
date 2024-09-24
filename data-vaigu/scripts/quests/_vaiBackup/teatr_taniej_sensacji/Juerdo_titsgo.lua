	:Monster(function()
local mType = Game.createMonsterType("Juerdo Titsgo")
local monster = {}

monster.description = "Juerdo Titsgo"
monster.experience = 4999
monster.outfit = {
	lookType = 56,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 4000
monster.maxHealth = 3717
monster.race = "blood"
monster.corpse = 5964
monster.speed = 200
monster.manaCost = 0

monster.changeTarget = {
	interval = 4999,
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {
	"JuerdoDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 10,
	summons = {
		{ name = "Snake", chance = 50, interval = 2000, count = 4 },
		{ name = "Cobra", chance = 50, interval = 2000, count = 3 },
		{ name = "Wyvern", chance = 20, interval = 2000, count = 3 },
	},
}

monster.voices = {}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -140 },
	{ name = "combat", interval = 2000, chance = 70, type = COMBAT_ENERGYDAMAGE, minDamage = -130, maxDamage = -60, range = 1, shootEffect = CONST_ANI_ENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -150, maxDamage = -70, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 60, type = COMBAT_LIFEDRAIN, minDamage = -130, maxDamage = -50, length = 8, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false },
}

monster.defenses = {
	defense = 15,
	armor = 15,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
end)
