local mType = Game.createMonsterType("Juggernaut")
local monster = {}

monster.description = "a juggernaut"
monster.experience = 14000
monster.outfit = {
	lookType = 244,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 296
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Deep in Pits of Inferno (Apocalypse's throne room), The Dark Path, \z
		The Blood Halls, The Vats, The Hive, The Shadow Nexus, a room deep in Formorgar Mines, Roshamuul Prison, Oramond Dungeon, Grounds of Destruction."
		}
		
monster.health = 20000
monster.maxHealth = 20000
monster.race = "blood"
monster.corpse = 6335
monster.speed = 170
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
	staticAttackChance = 60,
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
	{text = "RAAARRR!", yell = false},
	{text = "GRRRRRR!", yell = false},
	{text = "WAHHHH!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 100000, maxCount = 200},
	{name = "platinum coin", chance = 100000, maxCount = 15},
	{name = "ham", chance = 60000, maxCount = 8},
	{name = "demonic essence", chance = 45333},
	{name = "soul orb", chance = 33333},
	{name = "flask of demonic blood", chance = 29000, maxCount = 4},
	{name = "great health potion", chance = 32000},
	{id = 3030, chance = 20000, maxCount = 5},
	{id = 3033, chance = 17700, maxCount = 5},
	{id = 9057, chance = 17700, maxCount = 5},
	{id = 3028, chance = 20000, maxCount = 5},
	{name = "assassin star", chance = 25000, maxCount = 10},
	{name = "great mana potion", chance = 35000},
	{id = 3032, chance = 20000, maxCount = 5},
	{id = 8896, chance = 3000},
	{id = 7365, chance = 11111, maxCount = 15},
	{id = 3039, chance = 14650},
	{name = "gold ingot", chance = 7692, maxCount = 2},
	{id = 7452, chance = 5961},
	{id = 3036, chance = 1700},
	{id = 3019, chance = 550},
	{id = 3360, chance = 740},
	{id = 3038, chance = 3069},
	{id = 3481, chance = 590},
	{id = 3370, chance = 5890},
	{id = 3414, chance = 500},
	{id = 3322, chance = 9000},
	{id = 7413, chance = 4430},
	{name = "golden legs", chance = 500},
	{id = 3113, chance = 600},
	{id = 8061, chance = 400},
	{id = 3340, chance = 270},
	{id = 3342, chance = 2700}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 190, attack = 100},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -780, range = 7, shootEffect = CONST_ANI_LARGEROCK, target = false}
}

monster.defenses = {
	defense = 70,
	armor = 70,
	{name ="speed", interval = 2000, chance = 9, speedChange = 570, effect = CONST_ME_MAGIC_RED, target = false, duration = 10000},
	{name ="combat", interval = 2000, chance = 11, type = COMBAT_HEALING, minDamage = 400, maxDamage = 900, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = -10},
	{type = COMBAT_EARTHDAMAGE, percent = 20},
	{type = COMBAT_FIREDAMAGE, percent = 30},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
