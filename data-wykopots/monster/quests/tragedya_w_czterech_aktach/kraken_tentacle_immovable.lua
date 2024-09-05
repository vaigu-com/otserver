local mType = Game.createMonsterType("Kraken tentacles")
local monster = {}

monster.description = "a Kraken tentacle"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 11350,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 40000
monster.maxHealth = 40000
monster.race = "blood"
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 3717,
	chance = 0,
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
	canPushItems = false,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -120, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
	{ name = "kraken tentacle spawn slammer", interval = 4200, chance = 100, target = false, range = 7 },
}

monster.defenses = {
	defense = 5,
	armor = 5,
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
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true },
}

local function setOutfit(creature, itemId)
	local condition = Condition(CONDITION_OUTFIT)
	condition:setTicks(15 * 60 * 1000)
	condition:setOutfit({ lookTypeEx = itemId })
	creature:addCondition(condition)
end

mType.onAppear = function(monster, creature)
	setOutfit(monster, 11351)
end

mType:register(monster)
