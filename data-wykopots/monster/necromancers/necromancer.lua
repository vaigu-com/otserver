local mType = Game.createMonsterType("Necromancer")
local monster = {}

monster.description = "a necromancer"
monster.experience = 580
monster.outfit = {
	lookType = 9,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 9
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "All the Tombs, Lich Hell, Drefia, Medusa Shield Quest room, Old Fortress, Old Masonry, \z
		beneath Fenrock, Cemetery Quarter and Magician Quarter."
		}
		
monster.health = 580
monster.maxHealth = 580
monster.race = "blood"
monster.corpse = 18174
monster.speed = 94
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
	staticAttackChance = 85,
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
		{ name = "Ghoul", chance = 15, interval = 2000, count = 1 },
		{ name = "Ghost", chance = 5,  interval = 2000, count = 1 },
		{ name = "Mummy", chance = 5,  interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Your corpse will be mine!", yell = false},
	{text = "Taste the sweetness of death!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 30350, maxCount = 90},
	{id = 3448, chance = 15000, maxCount = 5},
	{id = 3732, chance = 1470},
	{id = 3311, chance = 390},
	{id = 237, chance = 400},
	{id = 3574, chance = 510},
	{id = 3324, chance = 100},
	{id = 7456, chance = 10},
	{id = 8073, chance = 130},
	{id = 3079, chance = 270},
	{id = 10320, chance = 10200},
	{id = 11475, chance = 1001}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 20, attack = 30, condition = {type = CONDITION_POISON, totalDamage = 160, interval = 4000}},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -10, maxDamage = -120, range = 1, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_SMALLCLOUDS, target = true},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -20, maxDamage = -120, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false}
}

monster.defenses = {
	defense = 40,
	armor = 50,
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 50, maxDamage = 80, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -5},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -5},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
