local mType = Game.createMonsterType("Glooth Brigand")
local monster = {}

monster.description = "a glooth brigand"
monster.experience = 1900
monster.outfit = {
	lookType = 137,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 110,
	lookFeet = 114,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1120
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Underground Glooth Factory.",
}

monster.health = 2400
monster.maxHealth = 2400
monster.race = "blood"
monster.corpse = 21888
monster.speed = 160
monster.manaCost = 490

monster.changeTarget = {
	interval = 5000,
	chance = 5,
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
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Toks utat.", yell = false },
	{ text = "Youh ah trak!", yell = false },
	{ text = "Let da mashing begin!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 44100, maxCount = 100 },
	{ name = "platinum coin", chance = 72000, maxCount = 3 },
	{ name = "glooth capsule", chance = 2950 },
	{ name = "tainted glooth capsule", chance = 8000 },
	{ id = 21203, chance = 5013 },
	{ id = 21143, chance = 2250 },
	{ id = 21146, chance = 2340 },
	{ name = "great mana potion", chance = 3150, maxCount = 3 },
	{ id = 7642, chance = 3060, maxCount = 3 },
	{ id = 21180, chance = 900 },
	{ id = 21158, chance = 900 },
	{ id = 7643, chance = 3060 },
	{ id = 21183, chance = 900 },
	{ id = 21179, chance = 900 },
	{ id = 21178, chance = 900 },
	{ id = 3038, chance = 190 },
	{ id = 830, chance = 666 },
	{ id = 812, chance = 450 },
	{ id = 811, chance = 567 },
	{ id = 21165, chance = 576 },
	{ id = 21167, chance = 135 },
	{ id = 814, chance = 380 },
	{ id = 7386, chance = 144 },
	{ id = 7419, chance = 90 },
	{ name = "butcher's axe", chance = 50 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -315 },
	{ name = "combat", interval = 2000, chance = 33, type = COMBAT_PHYSICALDAMAGE, minDamage = -40, maxDamage = -200, range = 7, shootEffect = CONST_ANI_ARROW, target = false },
}

monster.defenses = {
	defense = 51,
	armor = 51,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 200, maxDamage = 240, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
