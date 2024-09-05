local mType = Game.createMonsterType("Crystal Spider")
local monster = {}

monster.description = "a crystal spider"
monster.experience = 900
monster.outfit = {
	lookType = 263,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 330
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Atop of the Formorgar Glacier and deep inside Formorgar Mines, Frost Dragon Tunnel, \z
		Ice Witch Temple, Nibelor Ice Cave, the Crystal Caves in The Inquisition Quest, Mushroom Gardens."
		}
		
monster.health = 1250
monster.maxHealth = 1250
monster.race = "undead"
monster.corpse = 7344
monster.speed = 115
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 15
}

monster.strategiesTarget = {
	nearest = 70,
	health = 20,
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
	canPushCreatures = false,
	staticAttackChance = 80,
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
	level = 3,
	color = 71
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Screeech!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 78000, maxCount = 197},
	{id = 237, chance = 14810},
	{id = 3357, chance = 10000},
	{id = 7364, chance = 6250, maxCount = 6},
	{id = 7441, chance = 5263},
	{id = 3351, chance = 4545},
	{id = 7449, chance = 2564},
	{id = 3008, chance = 1730},
	{id = 3007, chance = 1560},
	{id = 5879, chance = 1950},
	{id = 3053, chance = 1587},
	{id = 7290, chance = 750},
	{id = 3371, chance = 860},
	{id = 3370, chance = 560},
	{id = 829, chance = 650},
	{id = 3055, chance = 120},
	{id = 7437, chance = 130},
	{name = "jewelled backpack", chance = 120}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 40, attack = 100, condition = {type = CONDITION_POISON, totalDamage = 175, interval = 4000}},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -50, maxDamage = -100, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true},
	{name ="crystal spider paralyze 1", interval = 2000, chance = 12, target = false},
	{name ="crystal spider paralyze 2", interval = 2000, chance = 10, target = false}
}

monster.defenses = {
	defense = 43,
	armor = 43,
	{name ="speed", interval = 2000, chance = 8, speedChange = 350, effect = CONST_ME_MAGIC_RED, target = false, duration = 15000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -20},
	{type = COMBAT_EARTHDAMAGE, percent = 20},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
