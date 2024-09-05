local mType = Game.createMonsterType("Zul Szczurow")
local monster = {}

monster.description = "the Zul Szczurow"
monster.experience = 200000
monster.outfit = { lookType = 305, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }

monster.health = 20000
monster.maxHealth = 20000
monster.race = "blood"
monster.corpse = 6312
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = { interval = 4000, chance = 10 }

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
	canPushCreatures = true,
	staticAttackChance = 20,
	targetDistance = 1,
	runHealth = 3500,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = { level = 0, color = 0 }

monster.events = { "ZulSzczurowDeath" }

monster.voices = { interval = 5000, chance = 10 }

monster.loot = { { name = "emerald bangle", chance = 3500 } }

monster.attacks = {
	{ name = "zul szczurow increment", interval = 2000, chance = 100 },
	{
		name = "combat",
		interval = 2000,
		chance = 15,
		type = COMBAT_MANADRAIN,
		minDamage = 0,
		maxDamage = -920,
		range = 1,
		target = false,
	},
}

monster.defenses = {
	defense = 25,
	armor = 25,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
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

mType.onAppear = function(monster, creature)
	CreatureStateRegistry:register(monster)
	local state = CreatureStateRegistry:getState(monster)
	state.baseZulZulowDmg = 30
	state.currentZulZulowDmg = state.baseZulZulowDmg
	state.zulZulowDmgIncreasePerTick = 20
end

mType.onDisappear = function(monster, creature)
	if monster == creature then
		CreatureStateRegistry:unregister(monster)
	end
end
mType:register(monster)
