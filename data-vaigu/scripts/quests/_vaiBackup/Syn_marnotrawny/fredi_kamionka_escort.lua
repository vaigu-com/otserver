	:Monster(function()
local mType = Game.createMonsterType("Fredi kamionka Escort")
local monster = {}

monster.name = "Fredi kamionka"
monster.description = "a Fredi kamionka"
monster.experience = 1000
monster.outfit = { lookType = 1136, lookHead = 95, lookBody = 100, lookLegs = 60, lookFeet = 58, lookAddons = 0 }

monster.health = 9000
monster.maxHealth = 9000
monster.corpse = 4240
monster.speed = 100

monster.faction = FACTION_PLAYER

monster.changeTarget = {
	interval = 4000,
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 0,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 0,
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = -10, maxDamage = -100, range = 7, shootEffect = CONST_ANI_BURSTARROW, target = true },
	{ name = "combat", interval = 6000, chance = 35, type = COMBAT_HOLYDAMAGE, minDamage = -200, maxDamage = -900, range = 8, radius = 4, effect = CONST_ME_HOLYAREA, target = true },
}

monster.defenses = {
	defense = 86,
	armor = 86,
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

mType.onMove = function(monster, _, _, toPosition)
	local rand = math.random(1, 10)
	if rand > 2 then
		return
	end
	
	local spectators = getSpectators(toPosition, 7, 6, false, false)
	IterateSpectators(spectators, function(cid)
		local creature = Creature(cid)
		if not creature then
			return
		end
		if creature:getName():lower() == "areczek" then
			doTargetCombatHealth(monster, creature, COMBAT_FIREDAMAGE, -1, -1, CONST_ME_NONE)
		end
	end)
end

mType:register(monster)
end)
