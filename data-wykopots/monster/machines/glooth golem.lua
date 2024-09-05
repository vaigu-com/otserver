local mType = Game.createMonsterType("Glooth Golem")
local monster = {}

monster.description = "a glooth golem"
monster.experience = 2200
monster.outfit = {
	lookType = 600,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1038
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Glooth Factory, Underground Glooth Factory, Rathleton Sewers, Jaccus Maxxens Dungeon, \z
		Oramond Dungeon (depending on Magistrate votes)."
		}
		
monster.health = 2700
monster.maxHealth = 2700
monster.race = "venom"
monster.corpse = 20972
monster.speed = 130
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8
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
	{text = "*slosh*", yell = false},
	{text = "*clank*", yell = false}
}

monster.loot = {
	{id = 5880, chance = 2000},
	{id = 21183, chance = 1460},
	{id = 21170, chance = 950},
	{id = 21165, chance = 950},
	{name = "gold coin", chance = 100000, maxCount = 200},
	{id = 21755, chance = 3160},
	{id = 8775, chance = 1510},
	{id = 21143, chance = 10040},
	{name = "platinum coin", chance = 60000, maxCount = 4},
	{id = 21103, chance = 15530},
	{id = 7643, chance = 4980},
	{name = "great mana potion", chance = 11960},
	{id = 21167, chance = 1490},
	{id = 21179, chance = 1470},
	{id = 21178, chance = 950},
	{id = 21180, chance = 1610},
	{id = 3037, chance = 860},
	{id = 3038, chance = 100},
	{id = 9057, chance = 7950, maxCount = 4},
	{id = 3032, chance = 8230, maxCount = 4}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300},
	{name ="melee", interval = 2000, chance = 2, skill = 86, attack = 100}, -- melee max
	{name ="combat", interval = 2000, chance = 24, type = COMBAT_ENERGYDAMAGE, minDamage = -210, maxDamage = -250, range = 7, shootEffect = CONST_ANI_ENERGY, target = false}, -- ene strike
	{name ="war golem skill reducer", interval = 2000, chance = 16, target = false}, -- reduce shielding
	{name ="war golem electrify", interval = 2000, chance = 9, range = 7, target = false} -- electrify
}

monster.defenses = {
	defense = 43,
	armor = 43,
	{name ="speed", interval = 2000, chance = 13, speedChange = 404, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 100, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 5},
	{type = COMBAT_ENERGYDAMAGE, percent = 5},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 15},
	{type = COMBAT_DEATHDAMAGE , percent = 35}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
