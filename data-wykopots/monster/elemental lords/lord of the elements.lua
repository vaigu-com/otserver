local mType = Game.createMonsterType("Lord of the Elements")
local monster = {}

monster.description = "lord of the elements"
monster.experience = 8000
monster.outfit = {
	lookType = 290,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 454,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 8000
monster.maxHealth = 8000
monster.race = "undead"
monster.corpse = 8181
monster.speed = 185
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
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
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.events = {
	"ElementalSpheresOverlordDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Blistering Fire Elemental", chance = 50, interval = 4000, count = 1 },
		{ name = "Jagged Earth Elemental", chance = 50, interval = 4000, count = 1 },
		{ name = "Roaring Water Elemental", chance = 50, interval = 4000, count = 1 },
		{ name = "Overcharged Energy Elemental", chance = 50, interval = 4000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "WHO DARES CALLING ME?", yell = true },
	{ text = "I'LL FREEZE YOU THEN I CRUSH YOU!", yell = true },
}

monster.loot = {
	{ name = "platinum coin", chance = 95730, maxCount = 10 },
	{ name = "gold ingot", chance = 31620 },
	{ id = 3032, chance = 10260, maxCount = 8 },
	{ id = 3033, chance = 7690, maxCount = 8 },
	{ id = 3030, chance = 8550, maxCount = 8 },
	{ id = 3029, chance = 7690, maxCount = 8 },
	{ id = 8054, chance = 2410 },
	{ id = 8053, chance = 2420 },
	{ id = 8056, chance = 3230 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 60 },
	{ name = "lord of the elements paralyze", interval = 2000, chance = 15, target = false },
	{ name = "lord of the elements skill reducer", interval = 2000, chance = 10, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -155, maxDamage = -725, shootEffect = CONST_ANI_SHIVERARROW, target = false },
	{ name = "lord of the elements soulfire", interval = 2000, chance = 15, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 13, minDamage = -300, maxDamage = -800, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_CARNIPHILA, target = false },
}

monster.defenses = {
	defense = 99,
	armor = 81,
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_YELLOWENERGY, target = false, duration = 3000, outfitMonster = "energy overlord" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_FIREAREA, target = false, duration = 3000, outfitMonster = "fire overlord" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_SMALLPLANTS, target = false, duration = 3000, outfitMonster = "earth overlord" },
	{ name = "outfit", interval = 2000, chance = 10, effect = CONST_ME_GIANTICE, target = false, duration = 3000, outfitMonster = "ice overlord" },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 45 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 100 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
