local mType = Game.createMonsterType("Plagirath")
local monster = {}

monster.description = "a plagirath"
monster.experience = 30000
monster.outfit = {
	lookType = 862,
	lookHead = 84,
	lookBody = 80,
	lookLegs = 79,
	lookFeet = 80,
	lookAddons = 1,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1199,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 290000
monster.maxHealth = 290000
monster.race = "undead"
monster.corpse = 22495
monster.speed = 222
monster.manaCost = 200

monster.changeTarget = {
	interval = 2000,
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
	staticAttackChance = 80,
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
	"PlagirathDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "Disgusting Ooze", chance = 75, interval = 90000, count = 4 },
		{ name = "Disgusting Ooze", chance = 65, interval = 90000, count = 4 },
		{ name = "Disgusting Ooze", chance = 65, interval = 90000, count = 4 },
		{ name = "Disgusting Ooze", chance = 45, interval = 90000, count = 4 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "BOOOOOOOMMM!!!!!", yell = true },
	{ text = "WITHER AND DIE", yell = false },
	{ text = "DEATH AND DECAY", yell = false },
	{ text = "I CAN SENSE YOUR BODIES ROOTING!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 9000, maxCount = 200 },
	{ name = "platinum coin", chance = 95000, maxCount = 25 },
	{ id = 22516, chance = 100000 },
	{ id = 22759, chance = 600 },
	{ id = 22867, chance = 3000 },
	{ id = 22866, chance = 3000 },
	{ id = 814, chance = 33500 },
	{ id = 8073, chance = 7700 },
	{ id = 10389, chance = 3500 },
	{ id = 7386, chance = 1000 },
	{ id = 16117, chance = 6500 },
	{ id = 812, chance = 16000 },
	{ id = 3036, chance = 16500 },
	{ id = 3038, chance = 16500 },
	{ id = 3041, chance = 16500 },
	{ id = 3037, chance = 16500 },
	{ id = 3098, chance = 6500 },
	{ name = "demonic essence", chance = 7000 },
	{ id = 281, chance = 9000 },
	{ id = 7643, chance = 40500, maxCount = 10 },
	{ name = "great mana potion", chance = 40500, maxCount = 10 },
	{ id = 7642, chance = 40500, maxCount = 10 },
	{ id = 3030, chance = 19500, maxCount = 5 },
	{ id = 3032, chance = 19500, maxCount = 5 },
	{ id = 3033, chance = 19500, maxCount = 5 },
	{ id = 3028, chance = 19500, maxCount = 5 },
	{ id = 16126, chance = 15000, maxCount = 6 },
	{ id = 16127, chance = 15000, maxCount = 6 },
	{ id = 16125, chance = 15000, maxCount = 5 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1350 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -350, radius = 4, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -700, maxDamage = -800, length = 10, spread = 3, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -450, maxDamage = -900, length = 8, spread = 0, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "combat", interval = 8000, chance = 35, type = COMBAT_EARTHDAMAGE, minDamage = -1300, maxDamage = -1500, radius = 8, effect = CONST_ME_BIGPLANTS, target = true },
}

monster.defenses = {
	defense = 160,
	armor = 160,
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -25 },
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
