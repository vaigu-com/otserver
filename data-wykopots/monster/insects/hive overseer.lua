local mType = Game.createMonsterType("Hive Overseer")
local monster = {}

monster.description = "a Hive Overseer"
monster.experience = 5500
monster.outfit = {
	lookType = 458,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 801
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 2,
	Locations = "The Hive towers: on the highest floor of each tower, \z
		and in many of the closed rooms accessed with pheromones; \z
		many in the large underground room of the west tower. \z
		Liberty Bay Hive Outpost: one spawn on the second floor underground."
		}
		
monster.health = 7500
monster.maxHealth = 7500
monster.race = "venom"
monster.corpse = 13937
monster.speed = 57
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
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
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Spidris Elite", chance = 22, interval = 2000, count = 2 }
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Zopp!", yell = false},
	{text = "Kropp!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 40000, maxCount = 100},
	{name = "gold coin", chance = 58000, maxCount = 98},
	{name = "platinum coin", chance = 84000, maxCount = 6},
	{id = 14077, chance = 28000},
	{name = "great mana potion", chance = 18000},
	{id = 14083, chance = 16000},
	{id = 7643, chance = 12000},
	{id = 3030, chance = 16000, maxCount = 2},
	{id = 281, chance = 6000},
	{name = "gold ingot", chance = 29000},
	{id = 14172, chance = 13000, maxCount = 2},
	{id = 14086, chance = 830},
	{id = 14089, chance = 1650},
	{id = 14246, chance = 830},
	{id = 14088, chance = 920},
	{name = "steel boots", chance = 550}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 80, attack = 100},
	{name ="combat", interval = 2000, chance = 14, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -300, range = 7, shootEffect = CONST_ANI_POISON, target = false},
	{name ="effect", interval = 2000, chance = 65, radius = 4, effect = CONST_ME_GREEN_RINGS, target = false},
	{name ="combat", interval = 2000, chance = 65, type = COMBAT_EARTHDAMAGE, minDamage = -50, maxDamage = -90, radius = 4, effect = CONST_ME_POISONAREA, target = false}
}

monster.defenses = {
	defense = 51,
	armor = 39,
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_HEALING, minDamage = 50, maxDamage = 100, effect = CONST_ME_MAGIC_GREEN, target = false},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 500, maxDamage = 700, effect = CONST_ME_MAGIC_GREEN, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 40},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 5},
	{type = COMBAT_HOLYDAMAGE , percent = 10},
	{type = COMBAT_DEATHDAMAGE , percent = 15}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
