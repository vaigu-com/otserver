local mType = Game.createMonsterType("Shadowpelt")
local monster = {}

monster.description = "Shadowpelt"
monster.experience = 9600
monster.outfit = {
	lookType = 1040,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 6000
monster.maxHealth = 6000
monster.race = "blood"
monster.corpse = 27722
monster.speed = 215
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 11,
}

monster.bosstiary = {
	bossRaceId = 1561,
	bossRace = RARITY_ARCHFOE,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 300,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 3,
	summons = {
		{ name = "Werebear", chance = 30, interval = 6000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "gold coin", chance = 77000, maxCount = 100 },
	{ name = "platinum coin", chance = 88000, maxCount = 5 },
	{ name = "black pearl", chance = 13880, maxCount = 2 },
	{ name = "ham", chance = 88000, maxCount = 2 },
	{ name = "opal", chance = 71000, maxCount = 2 },
	{ name = "small enchanted sapphire", chance = 19000, maxCount = 2 },
	{ name = "bear paw", chance = 92000, maxCount = 2 },
	{ name = "furry club", chance = 80000 },
	{ id = 281, chance = 5000 }, -- giant shimmering pearl (green)
	{ name = "great health potion", chance = 36000, maxCount = 5 },
	{ name = "honeycomb", chance = 73000, maxCount = 2 },
	{ name = "spiked squelcher", chance = 13600 },
	{ name = "ultimate health potion", chance = 13600, maxCount = 5 },
	{ name = "werebear fur", chance = 33600, maxCount = 2 },
	{ name = "werebear skull", chance = 40000, maxCount = 2 },
	{ name = "dreaded cleaver", chance = 1550 },
	{ name = "fur armor", chance = 8550 },
	{ name = "relic sword", chance = 1550 },
	{ name = "silver token", chance = 7150 },
	{ id = 22103, chance = 1150 }, -- werebear trophy
	{ name = "wolf backpack", chance = 1100 },
	{ id = 8907, chance = 1150 },
	{ id = 3343, chance = 1150 },
	{ id = 22083, chance = 500 }, -- moonlight crystals
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 70, attack = 50 },
	{ name = "combat", interval = 100, chance = 22, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -310, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "outfit", interval = 1000, chance = 8, radius = 1, target = true, duration = 8000, outfitMonster = "Werebear" },
	{ name = "combat", interval = 100, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -200, radius = 3, effect = CONST_ME_SOUND_WHITE, target = false },
}

monster.defenses = {
	defense = 50,
	armor = 30,
	--	mitigation = ???,
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_HEALING, minDamage = 120, maxDamage = 310, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = 520, effect = CONST_ME_POFF, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
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
