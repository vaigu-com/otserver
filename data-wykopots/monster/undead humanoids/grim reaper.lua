local mType = Game.createMonsterType("Grim Reaper")
local monster = {}

monster.description = "a grim reaper"
monster.experience = 5500
monster.outfit = {
	lookType = 300,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 465
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Drefia Grim Reaper Dungeons, deep in Drefia Wyrm Lair (after the Medusa Shield Quest), \z
		Edron (Hero Cave), Yalahar (Cemetery Quarter), Oramond Dungeon, \z
		  Abandoned Sewers and optionally in the Demon Oak Quest."
		}
		
monster.health = 3900
monster.maxHealth = 3900
monster.race = "undead"
monster.corpse = 8127
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
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
	canWalkOnEnergy = false,
	canWalkOnFire = false,
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
	{text = "Death!", yell = false},
	{text = "Come a little closer!", yell = false},
	{text = "The end is near!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 99000, maxCount = 272},
	{name = "flask of demonic blood", chance = 35000},
	{name = "demonic essence", chance = 11040},
	{name = "great mana potion", chance = 9900},
	{id = 7643, chance = 10000},
	{id = 3453, chance = 9910},
	{id = 9660, chance = 5070},
	{name = "platinum coin", chance = 5020, maxCount = 4},
	{id = 3046, chance = 4950},
	{id = 3421, chance = 3040},
	{id = 8896, chance = 2910},
	{name = "orichalcum pearl", chance = 1420, maxCount = 4},
	{id = 8082, chance = 1020},
	{id = 7418, chance = 670},
	{id = 6299, chance = 210},
	{id = 823, chance = 290},
	{id = 8061, chance = 220}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -320},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -50, maxDamage = -150, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false},
	{name ="melee", interval = 6000, chance = 20, minDamage = -200, maxDamage = -800},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -320, maxDamage = -720, length = 8, spread = 0, effect = CONST_ME_DRAWBLOOD, target = false},
	{name ="combat", interval = 2000, chance = 13, type = COMBAT_PHYSICALDAMAGE, minDamage = -210, maxDamage = -290, length = 7, spread = 3, effect = CONST_ME_EXPLOSIONAREA, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -225, maxDamage = -275, radius = 4, effect = CONST_ME_MORTAREA, target = false}
}

monster.defenses = {
	defense = 30,
	armor = 30,
	{name ="combat", interval = 2000, chance = 16, type = COMBAT_HEALING, minDamage = 130, maxDamage = 205, target = false},
	{name ="speed", interval = 2000, chance = 12, speedChange = 540, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 20},
	{type = COMBAT_ENERGYDAMAGE, percent = -10},
	{type = COMBAT_EARTHDAMAGE, percent = 40},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 65},
	{type = COMBAT_HOLYDAMAGE , percent = -10},
	{type = COMBAT_DEATHDAMAGE , percent = 80}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
