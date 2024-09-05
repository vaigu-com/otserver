local mType = Game.createMonsterType("Crazed Winter Rearguard")
local monster = {}

monster.description = "a Crazed Winter Rearguard"
monster.experience = 4700
monster.outfit = {
	lookType = 1136,
	lookHead = 86,
	lookBody = 85,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1731
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Court of Winter, Dream Labyrinth.",
}

monster.health = 5200
monster.maxHealth = 5200
monster.race = "undead"
monster.corpse = 30123
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
}

monster.loot = {
	{ name = "platinum coin", chance = 80000, maxCount = 5 },
	{ name = "ice rapier", chance = 15520 },
	{ name = "ultimate health potion", chance = 15888 },
	{ name = "great spirit potion", chance = 13728 },
	{ id = 30058, chance = 7952, maxCount = 2 },
	{ name = "life crystal", chance = 7280 },
	{ name = "dream essence egg", chance = 8000 },
	{ name = "elven astral observer", chance = 6808 },
	{ name = "glacier mask", chance = 4984 },
	{ name = "moonlight rod", chance = 5064 },
	{ name = "small enchanted sapphire", chance = 3720, maxCount = 7 },
	{ name = "northwind rod", chance = 2304 },
	{ name = "glacier amulet", chance = 2952 },
	{ name = "hailstorm rod", chance = 2496 },
	{ name = "glacier robe", chance = 1784 },
	{ name = "cyan crystal fragment", chance = 1912 },
	{ name = "elven amulet", chance = 1496 },
	{ name = "blue gem", chance = 408 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_ICEDAMAGE, minDamage = -230, maxDamage = -300, range = 6, radius = 3, effect = CONST_ME_ICEATTACK, target = true },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_ICEDAMAGE, minDamage = -240, maxDamage = -350, range = 7, shootEffect = CONST_ANI_SNOWBALL, target = true },
}

monster.defenses = {
	defense = 20,
	armor = 76,
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_ICEDAMAGE, percent = 70 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = -20 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 40 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
