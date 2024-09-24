	:Monster(function()
local mType = Game.createMonsterType("Jan Kockodan")
local monster = {}

monster.description = "Jan Kockodan"
monster.experience = 8000
monster.outfit = {
	lookType = 4,
	lookHead = 91,
	lookBody = 3,
	lookLegs = 33,
	lookFeet = 92,
	lookAddons = 1,
	lookMount = 0,
}

monster.health = 5700
monster.maxHealth = 5700
monster.race = "blood"
monster.corpse = 22023
monster.speed = 280
monster.manaCost = 392

monster.changeTarget = { interval = 4000, chance = 20 }

monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = { level = 0, color = 0 }

monster.voices = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 100, maxDamage = -666 }, -- bleed
	{
		name = "condition",
		type = CONDITION_BLEEDING,
		interval = 2000,
		chance = 60,
		minDamage = -150,
		maxDamage = -225,
		radius = 5,
		effect = CONST_ME_HOLYAREA,
		shootEffect = CONST_ANI_THROWINGKNIFE,
		target = true,
	},
}

monster.defenses = {
	defense = 50,
	armor = 35,
	{
		name = "combat",
		interval = 3717,
		chance = 15,
		type = COMBAT_HEALING,
		minDamage = 220,
		maxDamage = 280,
		effect = CONST_ME_MAGIC_BLUE,
		target = false,
	},
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
end)
