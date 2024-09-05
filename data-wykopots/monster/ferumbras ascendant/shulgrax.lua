local mType = Game.createMonsterType("Shulgrax")
local monster = {}

monster.description = "a shulgrax"
monster.experience = 80000
monster.outfit = {
	lookType = 842,
	lookHead = 19,
	lookBody = 118,
	lookLegs = 21,
	lookFeet = 21,
	lookAddons = 1,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1191,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 290000
monster.maxHealth = 290000
monster.race = "undead"
monster.corpse = 22495
monster.speed = 242
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
	"ShulgraxDeath",
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
	{ name = "gold coin", chance = 9000, maxCount = 200 },
	{ name = "platinum coin", chance = 99000, maxCount = 30 },
	{ id = 22516, chance = 100000 },
	{ id = 3037, chance = 14500 },
	{ id = 3036, chance = 14500 },
	{ id = 3039, chance = 14500 },
	{ id = 3038, chance = 14500 },
	{ id = 3041, chance = 14500 },
	{ id = 22756, chance = 600 },
	{ id = 22726, chance = 2000 },
	{ id = 22727, chance = 3000 },
	{ id = 22867, chance = 2500 },
	{ id = 22866, chance = 2500 },
	{ id = 7451, chance = 5000 },
	{ id = 17828, chance = 9000 },
	{ id = 816, chance = 35000 },
	{ id = 822, chance = 7000 },
	{ id = 7416, chance = 3800 },
	{ id = 7419, chance = 3900 },
	{ id = 8092, chance = 9000 },
	{ id = 8082, chance = 9000 },
	{ id = 7427, chance = 900 },
	{ id = 9152, chance = 900 },
	{ id = 3420, chance = 1900 },
	{ id = 3366, chance = 900 },
	{ id = 6553, chance = 900 },
	{ name = "demonic essence", chance = 10000 },
	{ id = 6299, chance = 10000 },
	{ id = 7643, chance = 39500, maxCount = 10 },
	{ id = 7642, chance = 39500, maxCount = 10 },
	{ name = "great mana potion", chance = 39500, maxCount = 10 },
	{ name = "flask of demonic blood", chance = 45000, maxCount = 5 },
	{ id = 9057, chance = 16000, maxCount = 5 },
	{ id = 3032, chance = 16000, maxCount = 5 },
	{ id = 3030, chance = 16000, maxCount = 5 },
	{ id = 3028, chance = 16000, maxCount = 5 },
	{ id = 22194, chance = 37000, maxCount = 5 },
	{ id = 22193, chance = 37000, maxCount = 5 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -350, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_HITBYFIRE, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -700, maxDamage = -900, length = 10, spread = 3, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -1300, length = 10, spread = 0, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_PHYSICALDAMAGE, minDamage = -100, maxDamage = -600, length = 8, spread = 0, effect = CONST_ME_EXPLOSIONHIT, target = false },
}

monster.defenses = {
	defense = 160,
	armor = 160,
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HEALING, minDamage = 100, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "shulgrax summon", interval = 90000, chance = 100, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
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
