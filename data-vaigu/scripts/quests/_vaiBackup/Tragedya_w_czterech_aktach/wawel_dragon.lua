	:Monster(function()
local mType = Game.createMonsterType("Wawel Dragon")
local monster = {}

monster.description = "a Wawel Dragon"
monster.experience = 4999
monster.outfit = {
	lookType = 1190,
	lookHead = 143,
	lookBody = 2,
	lookLegs = 94,
	lookFeet = 94,
}

monster.health = 3500
monster.maxHealth = 3500
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 3500,
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 20,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.events = {
	"WawelDragonDeath",
}

monster.voices = {
	interval = 4999,
	chance = 10,
}

monster.loot = {
	{ name = "demonic essence", chance = 100000, maxCount = 2 },
	{ id = 4086, chance = 100000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -420 },
	{ name = "combat", interval = 1245, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -180, maxDamage = -220, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 1787, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -180, maxDamage = -220, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 1345, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -150, maxDamage = -180, length = 8, spread = 3, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 1962, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -150, maxDamage = -180, length = 8, spread = 3, effect = CONST_ME_FIREAREA, target = false },
	{ name = "firefield", interval = 2000, chance = 40, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, target = true },
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 100, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
end)
