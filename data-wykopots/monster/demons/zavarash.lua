local mType = Game.createMonsterType("Zavarash")
local monster = {}

monster.description = "Zavarash"
monster.experience = 21000
monster.outfit = {
	lookType = 12,
	lookHead = 19,
	lookBody = 0,
	lookLegs = 77,
	lookFeet = 79,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 35000
monster.maxHealth = 35000
monster.race = "blood"
monster.corpse = 6068
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 25,
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
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "dark torturer", chance = 25, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Harrr, Harrr!", yell = true },
}

monster.loot = {
	{ id = 20062, chance = 100000 }, -- cluster
	{ name = "gold coin", chance = 100000, maxCount = 197 },
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ id = 5954, chance = 100000 },
	{ id = 20264, chance = 90000 }, -- unrea
	{ name = "demonic essence", chance = 60000 },
	{ id = 281, chance = 40000 },
	{ id = 16120, chance = 40000, maxCount = 8 },
	{ name = "great mana potion", chance = 34440, maxCount = 10 },
	{ id = 7643, chance = 34440, maxCount = 10 },
	{ id = 7642, chance = 34440, maxCount = 5 },
	{ id = 16119, chance = 30000, maxCount = 8 },
	{ id = 16121, chance = 30000, maxCount = 8 },
	{ id = 3038, chance = 20000 },
	{ id = 3415, chance = 15030 }, -- guardian shield
	{ id = 3315, chance = 19030 }, -- guardian halberd
	{ id = 3041, chance = 15030 },
	{ name = "gold ingot", chance = 15030 },
	{ id = 7428, chance = 12030 }, -- bonebreaker
	{ id = 3340, chance = 6040 }, -- heavy mace
	{ id = 3419, chance = 11540 },
	{ id = 20276, chance = 14000 }, -- mask
	{ id = 8063, chance = 8620 }, -- pall arm
	{ id = 7387, chance = 9390 },
	{ id = 3420, chance = 3990 },
	{ id = 3414, chance = 1400 },
	{ id = 7431, chance = 750 },
	{ id = 8049, chance = 1200 },
	{ id = 8100, chance = 170 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -600, range = 7, shootEffect = CONST_ANI_THROWINGKNIFE, target = false },
	{ name = "heavy magic missile rune", interval = 2000, chance = 20, minDamage = 0, maxDamage = -350, range = 7, target = true },
	{ name = "berserk", interval = 2000, chance = 15, minDamage = 0, maxDamage = -400, target = false },
	{ name = "great energy beam", interval = 2000, chance = 15, minDamage = 0, maxDamage = -400, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_HEALING, minDamage = 400, maxDamage = 600, radius = 8, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 18, speedChange = 784, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 7000 },
	{ name = "invisible", interval = 2000, chance = 20, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
