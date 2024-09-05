local mType = Game.createMonsterType("Mazoran")
local monster = {}

monster.description = "a mazoran"
monster.experience = 30000
monster.outfit = {
	lookType = 842,
	lookHead = 77,
	lookBody = 99,
	lookLegs = 97,
	lookFeet = 96,
	lookAddons = 2,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1186,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 390000
monster.maxHealth = 390000
monster.race = "undead"
monster.corpse = 22495
monster.speed = 217
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
	canPushCreatures = false,
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
	"MazoranDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "gold coin", chance = 9000, maxCount = 100 },
	{ name = "platinum coin", chance = 99000, maxCount = 25 },
	{ id = 22516, chance = 100000 },
	{ id = 22760, chance = 1200 },
	{ id = 22866, chance = 3500 },
	{ id = 22867, chance = 3500 },
	{ id = 821, chance = 7500 },
	{ id = 826, chance = 7500 },
	{ id = 817, chance = 45000 },
	{ id = 3320, chance = 45000 },
	{ id = 3442, chance = 700 },
	{ id = 22727, chance = 4000 },
	{ id = 7403, chance = 900 },
	{ id = 3315, chance = 3000 },
	{ id = 7382, chance = 600 },
	{ id = 16115, chance = 5000 },
	{ id = 3041, chance = 16500 },
	{ id = 3038, chance = 16500 },
	{ id = 3041, chance = 16500 },
	{ id = 3037, chance = 16500 },
	{ name = "gold ingot", chance = 16500 },
	{ name = "demonic essence", chance = 11500 },
	{ id = 3051, chance = 9500 },
	{ id = 16126, chance = 19500, maxCount = 6 },
	{ id = 16127, chance = 19500, maxCount = 6 },
	{ id = 16125, chance = 19500, maxCount = 5 },
	{ id = 9057, chance = 19500, maxCount = 5 },
	{ id = 3029, chance = 19500, maxCount = 5 },
	{ id = 3033, chance = 19500, maxCount = 5 },
	{ id = 7643, chance = 45000, maxCount = 10 },
	{ name = "great mana potion", chance = 45000, maxCount = 10 },
	{ id = 7642, chance = 45000, maxCount = 10 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -200, maxDamage = -1550 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -350, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_HITBYFIRE, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -1700, length = 10, spread = 3, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -1300, length = 10, spread = 0, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_PHYSICALDAMAGE, minDamage = -100, maxDamage = -600, length = 8, spread = 0, effect = CONST_ME_EXPLOSIONHIT, target = false },
}

monster.defenses = {
	defense = 160,
	armor = 160,
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_HEALING, minDamage = 200, maxDamage = 400, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "mazoran summon", interval = 120000, chance = 100, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
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
