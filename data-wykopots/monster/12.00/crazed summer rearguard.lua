local mType = Game.createMonsterType("Crazed Summer Rearguard")
local monster = {}

monster.description = "a Crazed Summer Rearguard"
monster.experience = 4700
monster.outfit = {
	lookType = 1136,
	lookHead = 1,
	lookBody = 94,
	lookLegs = 20,
	lookFeet = 119,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1733
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 5,
	Occurrence = 0,
	Locations = "Court of Winter, Dream Labyrinth.",
}

monster.health = 5300
monster.maxHealth = 5300
monster.race = "undead"
monster.corpse = 30081
monster.speed = 200
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

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Is this real life?", yell = false },
	{ text = "Weeeuuu weeeuuu!!!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 80000, maxCount = 11 },
	{ id = 5921, chance = 10400 },
	{ name = "dream essence egg", chance = 7448 },
	{ name = "elvish talisman", chance = 6240 },
	{ name = "violet crystal shard", chance = 4184 },
	{ name = "small enchanted ruby", chance = 6072 },
	{ name = "red crystal fragment", chance = 4856 },
	{ name = "leaf star", chance = 4136, maxCount = 8 },
	{ id = 23529, chance = 2240 },
	{ name = "sun fruit", chance = 920 },
	{ id = 23542, chance = 1040 },
	{ name = "wood cape", chance = 1440 },
	{ name = "small diamond", chance = 672 },
	{ name = "small enchanted sapphire", chance = 688, maxCount = 2 },
	{ name = "yellow gem", chance = 1088 },
	{ name = "crystal crossbow", chance = 500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "fireball rune", interval = 2000, chance = 20, minDamage = -220, maxDamage = -300, range = 7, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -230, maxDamage = -280, range = 5, radius = 4, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_EXPLOSIONHIT, target = true },
}

monster.defenses = {
	defense = 20,
	armor = 76,
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_FIREDAMAGE, percent = 70 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -25 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
