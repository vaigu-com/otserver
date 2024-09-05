local mType = Game.createMonsterType("Massive Water Elemental")
local monster = {}

monster.description = "a massive water elemental"
monster.experience = 1100
monster.outfit = {
	lookType = 11,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 279
monster.Bestiary = {
	class = "Elemental",
	race = BESTY_RACE_ELEMENTAL,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Calassa, Frozen Trench, Water Elemental Dungeon through the water channels, \z
		before Zugurosh in The Inquisition Quest."
		}
		
monster.health = 1250
monster.maxHealth = 1250
monster.race = "undead"
monster.corpse = 9582
monster.speed = 215
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{name = "gold coin", chance = 99000, maxCount = 100},
	{name = "platinum coin", chance = 39000, maxCount = 2},
	{id = 3578, chance = 40000, maxCount = 2},
	{id = 3028, chance = 5350, maxCount = 2},
	{id = 3032, chance = 5270, maxCount = 2},
	{name = "great health potion", chance = 10000},
	{name = "great mana potion", chance = 10400},
	{id = 3051, chance = 1010},
	{id = 3052, chance = 1110},
	{id = 7158, chance = 1070},
	{id = 7159, chance = 1150}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 70, attack = 60, condition = {type = CONDITION_POISON, totalDamage = 300, interval = 4000}},
	{name ="combat", interval = 2000, chance = 17, type = COMBAT_DROWNDAMAGE, minDamage = -250, maxDamage = -420, radius = 2, shootEffect = CONST_ANI_SNOWBALL, effect = CONST_ME_LOSEENERGY, target = true},
	{name ="combat", interval = 2000, chance = 13, type = COMBAT_ICEDAMAGE, minDamage = -160, maxDamage = -210, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_LOSEENERGY, target = true},
	-- poison
	{name ="condition", type = CONDITION_POISON, interval = 2000, chance = 12, minDamage = -280, maxDamage = -420, radius = 5, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false}
}

monster.defenses = {
	defense = 45,
	armor = 45,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 60, maxDamage = 75, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = -25},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = 30},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
