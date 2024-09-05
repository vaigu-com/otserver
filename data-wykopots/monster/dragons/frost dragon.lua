local mType = Game.createMonsterType("Frost Dragon")
local monster = {}

monster.description = "a frost dragon"
monster.experience = 2100
monster.outfit = {
	lookType = 248,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 317
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Okolnir, Razzachai, Ice Witch Temple, Frost Dragon Tunnel, \z
		Yakchal Crypt (only during Yakchal's awakening ritual), Dragonblaze Peaks, Deeper Banuta, Chyllfroest."
		}
		
monster.health = 1800
monster.maxHealth = 1800
monster.race = "undead"
monster.corpse = 7091
monster.speed = 106
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
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 250,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 4,
	color = 71
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "YOU WILL FREEZE!", yell = true},
	{text = "ZCHHHHH!", yell = true},
	{text = "I am so cool", yell = false},
	{text = "Chill out!.", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 95000, maxCount = 248},
	{id = 3583, chance = 80370, maxCount = 5},
	{id = 3450, chance = 6000, maxCount = 6},
	{id = 3732, chance = 12000},
	{id = 2842, chance = 8500},
	{id = 3029, chance = 10400, maxCount = 2},
	{id = 7441, chance = 4000},
	{id = 3051, chance = 5000},
	{id = 2903, chance = 3000},
	{id = 7290, chance = 550},
	{id = 3061, chance = 580},
	{id = 3386, chance = 120},
	{id = 3373, chance = 450},
	{id = 3392, chance = 230},
	{id = 3428, chance = 340},
	{id = 7402, chance = 120},
	{id = 3284, chance = 350}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 78, attack = 50},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -350, length = 8, spread = 3, effect = CONST_ME_POFF, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = 0, maxDamage = -120, radius = 3, effect = CONST_ME_ICETORNADO, target = false},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = 0, maxDamage = -240, radius = 4, effect = CONST_ME_ICEAREA, target = true},
	{name ="combat", interval = 2000, chance = 7, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -200, length = 1, spread = 0, effect = CONST_ME_POFF, target = false},
	{name ="frost dragon paralyze 2", interval = 2000, chance = 18, range = 7, target = false},
	{name ="frost dragon paralyze 1", interval = 2000, chance = 5, target = false},
	{name ="frost dragon paralyze 3", interval = 2000, chance = 12, target = false}
}

monster.defenses = {
	defense = 38,
	armor = 38,
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 12, speedChange = 290, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 7},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 10}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
