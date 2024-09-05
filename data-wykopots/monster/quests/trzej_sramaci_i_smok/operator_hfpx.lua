local mType = Game.createMonsterType("Operator HF-P/X")
local monster = {}

monster.description = "the Operator HF-P/X"
monster.experience = 500000
monster.outfit = {
	lookType = 1142,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 150000
monster.maxHealth = 150000
monster.race = "venom"
monster.corpse = 30151
monster.speed = 600
monster.manaCost = 0

monster.changeTarget = {}

monster.strategiesTarget = {
	nearest = 100,
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
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 300,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {
	"HfpxKill",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {}

monster.loot = {
	{ id = 3025, chance = 13500 }, -- ancient amulet
	{ name = "black pearl", chance = 15000, maxCount = 35 },
	{ name = "boots of haste", chance = 14000 },
	{ name = "crystal necklace", chance = 21500 },
	{ name = "devil helmet", chance = 11000 },
	{ name = "dragon hammer", chance = 34500 },
	{ id = 3051, chance = 13500 }, -- energy ring
	{ name = "fire axe", chance = 17000 },
	{ name = "giant sword", chance = 12500 },
	{ name = "platinum coin", chance = 69900, maxCount = 100 },
	{ name = "platinum coin", chance = 68800, maxCount = 100 },
	{ name = "gold ring", chance = 28000 },
	{ name = "golden legs", chance = 15000 },
	{ name = "giant ruby", chance = 31500 },
	{ name = "giant sapphire", chance = 31500 },
	{ name = "giant emerald", chance = 31500 },
	{ name = "purple tome", chance = 12600 },
	{ name = "silver dagger", chance = 15500 },
	{ name = "skull staff", chance = 25000 },
	{ name = "talon", chance = 14000, maxCount = 27 },
	{ name = "white pearl", chance = 12500, maxCount = 35 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "operator hfpx trigger trains", interval = 1000, chance = 1000, range = 7, target = false },
}

monster.defenses = {
	defense = 40,
	armor = 40,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 120, maxDamage = 225, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 400, range = 7, effect = CONST_ME_SOUND_PURPLE, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 65 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onAppear = function(monster, creature)
	CreatureStateRegistry:register(monster)
	local state = CreatureStateRegistry:getState(monster)
	state.currentColor = 0
	state.penaltyDamage = 0
end

mType.onDisappear = function(monster, creature)
	if monster == creature then
		CreatureStateRegistry:unregister(monster)
	end
end
mType:register(monster)
