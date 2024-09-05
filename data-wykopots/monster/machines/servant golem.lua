local mType = Game.createMonsterType("Servant Golem")
local monster = {}

monster.description = "a servant golem"
monster.experience = 5
monster.outfit = {
	lookType = 304,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 100
monster.maxHealth = 100
monster.race = "venom"
monster.corpse = 8887
monster.speed = 100
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
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
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
	{ text = "Do you think I might become a real boy one day?", yell = false },
	{ text = "How may I serve you, Sir or Ma'am?", yell = false },
	{ text = "Washing procedure initiated!", yell = false },
	{ text = "Can I help you?", yell = false },
	{ text = "Scan result: dusty human! Cleansing initiated!", yell = false },
	{ text = "I am listening!", yell = false },
	{ text = "Awaiting orders!", yell = false },
	{ text = "Where are we going, Sir or Ma'am?", yell = false },
	{ text = "How are you, Sir or Ma'am?", yell = false },
	{ text = "Praise the Yalahari!", yell = false },
	{ text = "Is that love or do you have a magnet in your pocket?", yell = false },
	{ text = "Move on! There's nothing to see!", yell = false },
	{ text = "Do you want to taste a sample of the newest dish?", yell = false },
	{ text = "I hope I am not annoying, Sir or Ma'am?", yell = false },
	{ text = "WARNING: BAD HAIRCUT DETECTED! Initializing haircut procedure!", yell = false },
	{ text = "Warning: This human is extremely handsome!", yell = false },
	{ text = "Mommy?", yell = false },
	{ text = "Everything is working as intended!", yell = false },
	{ text = "Rrrtttarrrttarrrtta", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "speed", interval = 2000, chance = 10, speedChange = 300, length = 8, spread = 0, effect = CONST_ME_POFF, target = false, duration = 1000 },
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 240, effect = CONST_ME_PURPLEENERGY, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
