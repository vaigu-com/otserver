local mType = Game.createMonsterType("Sharpclaw")
local monster = {}

monster.description = "a sharpclaw"
monster.experience = 3000
monster.outfit = {
	lookType = 1031,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1562,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 3300
monster.maxHealth = 3300
monster.race = "blood"
monster.corpse = 22067
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
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
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.events = {
	"WereBossDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 1,
	summons = {
		{ name = "Werebadger", chance = 20, interval = 2000, count = 1 },
	},
}
monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "The toughness of badgers will outlast the hostile!", yell = false },
	{ text = "Never underestimate a badger!", yell = false },
}

monster.loot = {
	{ name = "gold Coin", chance = 50000, maxCount = 100 },
	{ name = "platinum Coin", chance = 100000, maxCount = 7 },
	{ name = "brown Mushroom", chance = 5000, maxCount = 5 },
	{ name = "onyx Chip", chance = 80000, maxCount = 9 },
	{ name = "small Enchanted Amethyst", chance = 19000, maxCount = 3 },
	{ name = "beetroot", chance = 28000 },
	{ name = "great Mana Potion", chance = 40000, maxCount = 5 },
	{ name = "platinum Amulet", chance = 400 },
	{ id = 3098, chance = 12000 },
	{ name = "troll Green", chance = 2000, maxCount = 9 },
	{ name = "ultimate Mana Potion", chance = 12000, maxCount = 5 },
	{ name = "werebadger Claws", chance = 100000 },
	{ name = "werebadger Skull", chance = 100000 },
	{ name = "badger Boots", chance = 18000 },
	{ name = "underworld Rod", chance = 4000 },
	{ name = "wand of Voodoo", chance = 4000 },
	{ name = "wolf Backpack", chance = 400 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -290 },
	{ name = "combat", interval = 1000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 100, maxDamage = 720, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -600, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
	{ name = "combat", interval = 1000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -700, length = 5, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "outfit", interval = 1000, chance = 1, radius = 1, target = true, duration = 2000, outfitMonster = "Werebadger" },
	{ name = "ghastly dragon curse", interval = 2000, chance = 5, range = 1, target = false },
}

monster.defenses = {
	defense = 45,
	armor = 40,
	{ name = "combat", interval = 4000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 345, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 15, duration = 3000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 90 },
	{ type = COMBAT_EARTHDAMAGE, percent = 70 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 90 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 80 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
