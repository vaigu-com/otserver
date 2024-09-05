local mType = Game.createMonsterType("Cobra Vizier")
local monster = {}

monster.description = "a cobra vizier"
monster.experience = 7650
monster.outfit = {
	lookType = 1217,
	lookHead = 19,
	lookBody = 19,
	lookLegs = 86,
	lookFeet = 19,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1824
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Cobra Bastion.",
}

monster.health = 8500
monster.maxHealth = 8500
monster.race = "blood"
monster.corpse = 31639
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
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
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "COMBINE FORCES MY BRETHEN!", yell = false },
	{ text = "Feel the cobras wrath!", yell = false },
	{ text = "OH NO, YOU WON'T!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 73480, maxCount = 4 },
	{ name = "terra rod", chance = 34000 },
	{ name = "snakebite rod", chance = 12070 },
	{ name = "cobra crest", chance = 15130 },
	{ name = "terra hood", chance = 13810 },
	{ name = "cyan crystal fragment", chance = 10805 },
	{ name = "terra boots", chance = 14580 },
	{ id = 281, chance = 6570 }, -- giant shimmering pearl
	{ id = 3039, chance = 6550 },
	{ name = "emerald bangle", chance = 3550 },
	{ name = "gemmed figurine", chance = 4640 },
	{ name = "green crystal fragment", chance = 5230 },
	{ name = "red crystal fragment", chance = 2730 },
	{ name = "serpent sword", chance = 3020 },
	{ name = "violet crystal shard", chance = 4920 },
	{ name = "green gem", chance = 3710 },
	{ name = "onyx chip", chance = 900, maxCount = 3 },
}

monster.events = {
	"VizierSpell",
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 },
	--VizierSpell, --  Death Missile 600-900, range of ~4 sqm, also chains 50% chance to trigger
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -520, radius = 4, range = 5, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_GREEN_RINGS, target = true },
}

monster.defenses = {
	defense = 82,
	armor = 82,
	{ name = "speed", interval = 2000, chance = 6, speedChange = 250, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 100, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
