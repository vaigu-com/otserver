local mType = Game.createMonsterType("Merikh the Slaughterer")
local monster = {}

monster.description = "Merikh the Slaughterer"
monster.experience = 9000
monster.outfit = {
	lookType = 103,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3000
monster.maxHealth = 3000
monster.race = "blood"
monster.corpse = 6032
monster.speed = 90
monster.manaCost = 0

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
	rewardBoss = true,
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

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 3,
	summons = {
		{ name = "green djinn", chance = 30, interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Your death will be slow and painful.", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 97250, maxCount = 120 },
	{ name = "green piece of cloth", chance = 100000, maxCount = 4 },
	{ name = "noble turban", chance = 63900 },
	{ name = "heavy machete", chance = 41650 },
	{ name = "magma monocle", chance = 8400 },
	{ name = "seeds", chance = 21100 },
	{ name = "jewelled belt", chance = 90000 },
	{ name = "shiny stone", chance = 58300 },
	{ name = "strong mana potion", chance = 41650, maxCount = 3 },
	{ name = "small emerald", chance = 2800, maxCount = 2 },
	{ name = "small oil lamp", chance = 11100 },
	{ name = "mystic turban", chance = 36100 },
	{ name = "green gem", chance = 12800 },
	{ name = "pear", chance = 10000, maxCount = 8 },
	{ id = 25088, chance = 7230 }, -- porcelain mask
	{ id = 3014, chance = 6590 }, -- star amulet
	{ id = 12669, chance = 16220 }, -- star ring
	{ id = 11701, chance = 11220 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -204 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -160, maxDamage = -290, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -125, maxDamage = -250, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_ENERGYDAMAGE, minDamage = -100, maxDamage = -300, length = 4, spread = 0, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "drunk", interval = 2000, chance = 10, range = 7, shootEffect = CONST_ANI_ENERGY, target = false, duration = 6000 },
	{ name = "djinn electrify", interval = 2000, chance = 15, range = 5, target = false },
}

monster.defenses = {
	defense = 0,
	armor = 0,
	mitigation = 1.29,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 50, maxDamage = 100, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 18 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
