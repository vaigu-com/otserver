local mType = Game.createMonsterType("The Enraged Thorn Knight")
local monster = {}

monster.description = "a The Enraged Thorn Knight"
monster.experience = 15000
monster.outfit = {
	lookType = 512,
	lookHead = 81,
	lookBody = 121,
	lookLegs = 121,
	lookFeet = 121,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 20000
monster.maxHealth = 20000
monster.race = "blood"
monster.corpse = 9402
monster.speed = 125
monster.manaCost = 290

monster.changeTarget = {
	interval = 5000,
	chance = 0,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = true,
	rewardBoss = false,
	illusionable = true,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 15,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "NOOOOO!", yell = false },
	{ text = "You killed my only friend!", yell = false },
	{ text = "You will pay for this!", yell = false },
	{ text = "I will hurt you!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 50320, maxCount = 165 },
	{ name = "platinum coin", chance = 50320, maxCount = 30 },
	{ name = "orichalcum pearl", chance = 50320, maxCount = 2 },
	{ id = 16119, chance = 9660, maxCount = 5 },
	{ id = 16120, chance = 9660, maxCount = 5 },
	{ id = 16121, chance = 9660, maxCount = 5 },
	{ id = 3032, chance = 9660, maxCount = 5 },
	{ id = 3030, chance = 7360, maxCount = 5 },
	{ id = 9057, chance = 7350, maxCount = 5 },
	{ id = 3033, chance = 7150, maxCount = 5 },
	{ id = 5888, chance = 5888, maxCount = 2 },
	{ id = 5999, chance = 5909, maxCount = 2 },
	{ id = 5887, chance = 5909, maxCount = 2 },
	{ name = "great mana potion", chance = 22120, maxCount = 3 },
	{ id = 7643, chance = 19500, maxCount = 3 },
	{ id = 7642, chance = 18250, maxCount = 3 },
	{ id = 3041, chance = 5000 },
	{ id = 3039, chance = 2200 },
	{ id = 3038, chance = 5000 },
	{ id = 3036, chance = 5000 },
	{ id = 3037, chance = 5000 },
	{ name = "demonic essence", chance = 14460 },
	{ id = 7439, chance = 14460 },
	{ id = 7443, chance = 14460 },
	{ id = 281, chance = 7000 },
	{ id = 3295, chance = 20000 },
	{ id = 7453, chance = 100 },
	{ id = 24954, chance = 1000 },
	{ id = 5014, chance = 1000 },
	{ id = 3436, chance = 1000 },
	{ id = 9302, chance = 1000 },
	{ id = 5875, chance = 1000 },
	{ id = 5884, chance = 1000 },
	{ id = 8052, chance = 1000 },
	{ id = 20203, chance = 1000 },
	{ id = 24953, chance = 1000 },
	{ id = 24942, chance = 1000 },
	{ id = 22721, chance = 1970 },
	{ id = 22516, chance = 1970 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 200, attack = 120 },
	{ name = "combat", interval = 3000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -700, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
}

monster.defenses = {
	defense = 10,
	armor = 10,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 1 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
