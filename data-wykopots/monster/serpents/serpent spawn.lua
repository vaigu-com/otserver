local mType = Game.createMonsterType("Serpent Spawn")
local monster = {}

monster.description = "a serpent spawn"
monster.experience = 2650
monster.outfit = {
	lookType = 220,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 220
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Deeper Banuta, Forbidden Islands: Talahu (Medusa Cave) and Kharos (at level -1), Razzachai, \z
		Deep below the Crystal Lakes in Foreigner Quarter, Cult's cave in the Magician Quarter, Medusa Tower."
		}
		
monster.health = 3000
monster.maxHealth = 3000
monster.race = "venom"
monster.corpse = 6061
monster.speed = 117
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 70,
	health = 30,
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
	runHealth = 275,
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
	{text = "Sssssouls for the one", yell = false},
	{text = "HISSSS", yell = true},
	{text = "Tsssse one will risssse again", yell = false},
	{text = "I bring your deathhh, mortalssss", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 100000, maxCount = 249},
	{id = 3407, chance = 200},
	{id = 3381, chance = 490},
	{id = 2903, chance = 3010},
	{name = "great mana potion", chance = 1970},
	{id = 3732, chance = 17990},
	{id = 3061, chance = 800},
	{id = 3052, chance = 6000},
	{id = 7386, chance = 2080},
	{id = 7456, chance = 830},
	{id = 3450, chance = 5940},
	{id = 3392, chance = 110},
	{id = 3029, chance = 12130},
	{id = 3066, chance = 1000},
	{id = 8074, chance = 110},
	{id = 3373, chance = 570},
	{id = 8052, chance = 110},
	{id = 3428, chance = 810},
	{id = 3369, chance = 590},
	{id = 9694, chance = 15050},
	{id = 10313, chance = 970},
	{id = 5956, chance = 510},
	{id = 3051, chance = 5970}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -252},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -300, range = 7, shootEffect = CONST_ANI_POISON, target = false},
	{name ="outfit", interval = 2000, chance = 5, range = 7, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 3000, outfitMonster = "clay guardian" },
	{name ="serpent spawn paralyze", interval = 2000, chance = 15, range = 8, target = false},
	{name ="combat", interval = 2000, chance = 14, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -400, length = 8, spread = 0, effect = CONST_ME_SOUND_RED, target = false},
	{name ="combat", interval = 2000, chance = 17, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -500, length = 8, spread = 5, effect = CONST_ME_POISONAREA, target = false}
}

monster.defenses = {
	defense = 40,
	armor = 35,
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 250, maxDamage = 400, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 10, speedChange = 380, effect = CONST_ME_MAGIC_RED, target = false, duration = 3000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -10},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 20},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
