local mType = Game.createMonsterType("Pinata Dragon")
local monster = {}

monster.description = "a Pinata Dragon"
monster.experience = 5000
monster.outfit = {
	lookTypeEx = 25062,
}

monster.health = 10000
monster.maxHealth = 10000
monster.race = "undead"
monster.corpse = 25064
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 0,
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
	canPushItems = false,
	canPushCreatures = false,
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

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You can't have my treasures!", yell = false },
	{ text = "Hit me one more time!", yell = false },
	{ text = "Na Nana Naaa Naaa!", yell = false },
	{ text = "You'll never get my stuff!", yell = false },
	{ text = "Do you really want to hurt me?", yell = false },
	{ text = "Bring it on!", yell = false },
}

monster.loot = {
	{ name = "silver raid token", chance = 40000, maxCount = 3 },
	{ name = "candy", chance = 100000, maxCount = 5 },
	{ id = 6570, maxCount = 2, chance = 50000 }, -- surprise bag
	{ name = "cookie", maxCount = 5, chance = 50000 },
	{ name = "winterberry liquor", chance = 14000 },
	{ name = "meringue cake", chance = 10000 },
	{ name = "bar of chocolate", chance = 7000 },
	{ name = "pinata", chance = 6000 },
	{ id = 653, chance = 20000 },
	{ id = 655, chance = 4000 },
	{ id = 654, chance = 6000 },
	{ id = 24949, chance = 5000 },
	{ name = "festive backpack", chance = 5000 },
	{ name = "party cake", chance = 5000 },
	{ name = "chocolatey dragon scale legs", chance = 3000 },
	{ name = "ferumbras' candy hat", chance = 2000 },
	{ id = 2991, chance = 800 }, -- doll
	{ name = "toy mouse", chance = 300 },
	{ name = "ferumbras puppet", chance = 250 },
	{ id = 5791, chance = 30 }, -- stuffed dragon
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -10, maxDamage = -30, range = 7, shootEffect = CONST_ANI_CAKE, target = true },
	{ name = "outfit", interval = 2000, chance = 8, range = 7, target = true, duration = 6000, outfitMonster = "chicken" },
}

monster.defenses = {
	defense = 10,
	armor = 10,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 100, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -30 },
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

mType:register(monster)
