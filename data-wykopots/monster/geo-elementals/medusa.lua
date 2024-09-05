local mType = Game.createMonsterType("Medusa")
local monster = {}

monster.description = "a medusa"
monster.experience = 3500
monster.outfit = {
	lookType = 330,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 570
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 5,
	Occurrence = 0,
	Locations = "Vandura Mountain (single spawn), Talahu (Medusa Cave), Deeper Banuta, Medusa Tower.",
}

monster.health = 4500
monster.maxHealth = 4500
monster.race = "blood"
monster.corpse = 9607
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20,
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
	runHealth = 600,
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
	{ text = "You will make ssuch a fine ssstatue!", yell = false },
	{ text = "There isss no chhhanccce of esscape", yell = false },
	{ text = "Jusssst look at me!", yell = false },
	{ text = "Are you tired or why are you moving thhat sslow<chuckle>", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 99000, maxCount = 190 },
	{ name = "platinum coin", chance = 75190, maxCount = 6 },
	{ id = 3032, chance = 4030, maxCount = 4 },
	{ id = 814, chance = 3960 },
	{ id = 7643, chance = 10150, maxCount = 2 },
	{ id = 3436, chance = 3050 },
	{ name = "great mana potion", chance = 10000, maxCount = 2 },
	{ id = 10309, chance = 10000 },
	{ id = 812, chance = 440 },
	{ id = 7413, chance = 1200 },
	{ id = 811, chance = 820 },
	{ id = 9302, chance = 890 },
	{ id = 3370, chance = 1990 },
	{ id = 8896, chance = 310 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350, condition = { type = CONDITION_POISON, totalDamage = 840, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -10, maxDamage = -136, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 2250, chance = 23, type = COMBAT_LIFEDRAIN, minDamage = -10, maxDamage = -94, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 2500, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -15, maxDamage = -62, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 2750, chance = 28, type = COMBAT_LIFEDRAIN, minDamage = -5, maxDamage = -38, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 3000, chance = 30, type = COMBAT_LIFEDRAIN, minDamage = -5, maxDamage = -20, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 2000, chance = 7, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -450, length = 10, spread = 3, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "medusa paralyze", interval = 2000, chance = 13, range = 7, target = false },
	{ name = "outfit", interval = 2000, chance = 8, range = 7, target = true, duration = 3000, outfitMonster = "clay guardian" },
}

monster.defenses = {
	defense = 42,
	armor = 42,
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HEALING, minDamage = 150, maxDamage = 300, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
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
