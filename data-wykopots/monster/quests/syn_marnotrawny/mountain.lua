local mType = Game.createMonsterType("Syn Marnotrawny Fake Mountain")
local monster = {}

monster.description = "a mountain"
monster.experience = 0
monster.outfit = { lookType = 884, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }

monster.health = 500
monster.maxHealth = 500
monster.race = "undead"
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = { interval = 3717, chance = 10 }

monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

monster.flags = {
	summonable = false,
	attackable = false,
	hostile = false,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = true,
	staticAttackChance = 20,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = true,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = { level = 0, color = 0 }

monster.voices = { interval = 4000, chance = 10 }

monster.loot = {}

monster.attacks = {}

monster.defenses = { defense = 25, armor = 25 }

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 100 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType.onSay = function(listener, talker, type, message) end

mType.onAppear = function(monster, creature) end

mType:register(monster)
