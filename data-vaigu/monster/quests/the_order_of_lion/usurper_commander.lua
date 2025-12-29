local mType = Game.createMonsterType("Usurper Commander")
local monster = {}

monster.description = "an usurper commander"
monster.experience = 17200
monster.outfit = {
	lookType = 1317,
	lookHead = 40,
	lookBody = 95,
	lookLegs = 40,
	lookFeet = 95,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 8500
monster.maxHealth = 8500
monster.race = "blood"
monster.corpse = 0
monster.speed = 125
monster.manaCost = 0

monster.faction = FACTION_LIONUSURPERS
monster.enemyFactions = { FACTION_PLAYER, FACTION_LION }

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.events = {
	"UsurperCommanderDeath",
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

monster.summon = {
	maxSummons = 3,
	summons = {
		{ name = "hardened usurper archer", chance = 10, interval = 6000, count = 1 },
		{ name = "hardened usurper warlock", chance = 8, interval = 6000, count = 1 },
		{ name = "hardened usurper knight", chance = 12, interval = 6000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "FORMATION!", yell = true },
}

monster.loot = {
	{ name = "lion spangenhelm", chance = 100 },
	{ name = "lion plate", chance = 100 },
	{ name = "lion shield", chance = 100 },
	{ name = "lion longsword", chance = 100 },
	{ name = "lion hammer", chance = 100 },
	{ name = "lion axe", chance = 100 },
	{ name = "lion longbow", chance = 130 },
	{ name = "lion spellbook", chance = 110 },
	{ name = "lion wand", chance = 100 },
	{ name = "lion amulet", chance = 200 },
	{ name = "lion rod", chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500, effect = CONST_ME_DRAWBLOOD },
	{ name = "combat", interval = 4000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -300, radius = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 4000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -150, maxDamage = -400, length = 4, spread = 0, effect = CONST_ME_ICEATTACK, target = false },
	{ name = "singlecloudchain", interval = 6000, chance = 17, minDamage = -200, maxDamage = -450, range = 4, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "singledeathchain", interval = 6000, chance = 15, minDamage = -250, maxDamage = -530, range = 5, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 86,
	armor = 86,
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)