local mType = Game.createMonsterType("Sight of Surrender")
local monster = {}

monster.description = "Sight of Surrender"
monster.experience = 17000
monster.outfit = {
	lookType = 583,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1012
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Dark Grounds, Guzzlemaw Valley (if less than 100 Blowing Horns tasks \z
		have been done the day before) and the Silencer Plateau (when Silencer Resonating Chambers are used there)."
		}
		
monster.health = 28000
monster.maxHealth = 28000
monster.race = "undead"
monster.corpse = 20144
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20
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
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "BOW LOW!", yell = false},
	{text = "FEEL THE TRUE MEANING OF VANQUISH!", yell = false},
	{text = "HAHAHAHA DO YOU WANT TO AMUSE YOUR MASTER?", yell = false},
	{text = "NOW YOU WILL SURRENDER!", yell = false}
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 20},
	{id = 3048, chance = 8000},
	{id = 3081, chance = 18000},
	{id = 3332, chance = 1380},
	{id = 3333, chance = 5500},
	{id = 3366, chance = 1380},
	{id = 3391, chance = 920},
	{id = 3382, chance = 920},
	{id = 3428, chance = 1380},
	{name = "steel boots", chance = 920},
	{id = 7421, chance = 920},
	{id = 7422, chance = 920},
	{name = "great mana potion", chance = 78000, maxCount = 5},
	{id = 7642, chance = 72000, maxCount = 5},
	{id = 7643, chance = 30000, maxCount = 5},
	{id = 16119, chance = 23000, maxCount = 3},
	{id = 16120, chance = 32000, maxCount = 3},
	{id = 16121, chance = 21600, maxCount = 3},
	{id = 16122, chance = 30000, maxCount = 5},
	{id = 16123, chance = 30410, maxCount = 5},
	{id = 16124, chance = 40000, maxCount = 5},
	{id = 20062, chance = 1800},
	{id = 20183, chance = 100000},
	{id = 20184, chance = 100000},
	{id = 20208, chance = 460}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 100, attack = 200},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -500, maxDamage = -800, length = 8, spread = 0, effect = CONST_ME_YELLOWENERGY, target = true},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -500, radius = 1, shootEffect = CONST_ANI_LARGEROCK, target = true}
}

monster.defenses = {
	defense = 70,
	armor = 70,
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_HEALING, minDamage = 200, maxDamage = 1100, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 520, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = 35},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 30},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 10}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
