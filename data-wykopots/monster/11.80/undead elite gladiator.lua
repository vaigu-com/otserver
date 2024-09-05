local mType = Game.createMonsterType("Undead Elite Gladiator")
local monster = {}

monster.description = "a undead elite gladiator"
monster.experience = 6715
monster.outfit = {
	lookType = 306,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1675
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Deep Desert.",
}

monster.health = 8000
monster.maxHealth = 8000
monster.race = "undead"
monster.corpse = 8909
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
	chance = 10,
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
	canWalkOnFire = true,
	canWalkOnPoison = false,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Let's battle it out in a duel!", yell = false },
	{ text = "Bring it!", yell = false },
	{ text = "I'll fight here in eternity and beyond.", yell = false },
	{ text = "I will not give up!", yell = false },
	{ text = "Another foolish adventurer who tries to beat me.", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 75000, maxCount = 30 },
	{ id = 8044, chance = 18487 },
	{ id = 3287, chance = 11062, maxCount = 18 },
	{ id = 3307, chance = 8422 },
	{ name = "ultimate health potion", chance = 6090 },
	{ id = 3318, chance = 5902 },
	{ id = 3557, chance = 3817 },
	{ id = 9656, chance = 3810 },
	{ name = "great health potion", chance = 3787 },
	{ id = 5885, chance = 3675 },
	{ id = 3347, chance = 3525 },
	{ id = 3357, chance = 1575 },
	{ id = 3265, chance = 1425 },
	{ id = 3084, chance = 1650 },
	{ id = 3384, chance = 1350 },
	{ id = 3049, chance = 720 },
	{ id = 7383, chance = 202 },
	{ id = 3391, chance = 157 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -550, range = 7, shootEffect = CONST_ANI_WHIRLWINDSWORD, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -400, radius = 3, effect = CONST_ME_BLOCKHIT, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -350, length = 3, spread = 2, effect = CONST_ME_YELLOW_RINGS, target = false },
}

monster.defenses = {
	defense = 85,
	armor = 85,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 80 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
