local mType = Game.createMonsterType("Ferumbras Mortal Shell")
local monster = {}

monster.description = "ferumbras mortal shell"
monster.experience = 42000
monster.outfit = {
	lookType = 229,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 700000
monster.maxHealth = 700000
monster.race = "venom"
monster.corpse = 6078
monster.speed = 195
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 15,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 2500,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.events = {
	"FerumbrasMortalDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "Demon", chance = 11, interval = 2000, count = 4 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "INSECTS!", yell = true },
	{ text = "I' STILL POWERFUL ENOUGH TO CRUSH YOU!", yell = true },
	{ text = "If you strike me down, I shall become more powerful than you could possibly imagine!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 70000, maxCount = 200 },
	{ name = "platinum coin", chance = 70000, maxCount = 25 },
	{ name = "small amethyst", chance = 40000, maxCount = 10 },
	{ name = "small sapphire", chance = 40000, maxCount = 10 },
	{ name = "small topaz", chance = 40000, maxCount = 10 },
	{ name = "small emerald", chance = 40000, maxCount = 10 },
	{ name = "small diamond", chance = 40000, maxCount = 10 },
	{ name = "white pearl", chance = 30000, maxCount = 10 },
	{ name = "black pearl", chance = 30000, maxCount = 10 },
	{ name = "silver token", chance = 100000, minCount = 3, maxCount = 3 },
	{ name = "gold ingot", chance = 23000 },
	{ name = "soul orb", chance = 23000 },
	{ name = "emerald bangle", chance = 23000 },
	{ name = "blue gem", chance = 23000 },
	{ id = 3039, chance = 23000 },
	{ name = "green gem", chance = 23000 },
	{ id = 281, chance = 23000 }, -- shimmering pearl
	{ name = "glacier kilt", chance = 16000 },
	{ name = "terra legs", chance = 16000 },
	{ name = "magma legs", chance = 16000 },
	{ name = "lightning legs", chance = 16000 },
	{ name = "chaos mace", chance = 4000 },
	{ name = "hellforged axe", chance = 4000 },
	{ name = "haunted blade", chance = 8000 },
	{ name = "mastermind shield", chance = 4000 },
	{ name = "demon shield", chance = 8000 },
	{ name = "golden armor", chance = 8000 },
	{ name = "golden legs", chance = 8000 },
	{ name = "jade hammer", chance = 8000 },
	{ name = "spellbook of mind control", chance = 23000 },
	{ name = "rift bow", chance = 12000 },
	{ name = "rift crossbow", chance = 12000 },
	{ name = "rift lance", chance = 12000 },
	{ name = "rift shield", chance = 35000 },
	{ name = "runed sword", chance = 12000 },
	{ name = "shadow sceptre", chance = 12000 },
	{ name = "vile axe", chance = 12000 },
	{ name = "demonrage sword", chance = 12000 },
	{ name = "magic plate armor", chance = 8000 },
	{ name = "divine plate", chance = 8000 },
	{ name = "spellbook of dark mysteries", chance = 4000 },
	{ name = "spellbook of lost souls", chance = 4000 },
	{ name = "spellscroll of prophecies", chance = 4000 },
	{ name = "bloody edge", chance = 8000 },
	{ name = "nightmare blade", chance = 8000 },
	{ name = "queen's sceptre", chance = 8000 },
	{ name = "greenwood coat", chance = 8000 },
	{ name = "phoenix shield", chance = 4000 },
	{ name = "skullcrusher", chance = 4000 },
	{ name = "berserker", chance = 4000 },
	{ name = "ornamented axe", chance = 4000 },
	{ id = 22735, chance = 8000 }, -- rift lamp
	{ name = "death gaze", chance = 4000 },
	--{name = "scroll of ascension", chance = 800},
	{ id = 22767, chance = 30000 }, -- feru amulet
	{ id = 22773, chance = 8000 }, -- boots of homecoming
	{ id = 22764, chance = 15000 }, -- feru staff
	{ name = "folded rift carpet", chance = 20000 },
	{ id = 22731, chance = 20000 }, -- tapestry
	{ name = "obsidian truncheon", chance = 8000 },
	{ name = "emerald sword", chance = 8000 },
	{ name = "havoc blade", chance = 8000 },
	{ name = "great axe", chance = 3000 },
	{ name = "demonwing axe", chance = 2000 },
	{ name = "great shield", chance = 1000 },
	{ name = "velvet mantle", chance = 20000 },
	{ name = "abyss hammer", chance = 10000 },
	{ name = "impaler", chance = 2000 },
	{ id = 5903, chance = 5000, unique = true }, -- feru hat
	--{name = "mysterious scroll", chance = 800},
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1200 },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -250, maxDamage = -520, radius = 6, effect = CONST_ME_POISONAREA, target = false },
	{ name = "ferumbras electrify", interval = 2000, chance = 18, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = -225, maxDamage = -700, radius = 6, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = -425, maxDamage = -810, radius = 9, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -1350, radius = 9, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "combat", interval = 2000, chance = 21, type = COMBAT_LIFEDRAIN, minDamage = -500, maxDamage = -1600, radius = 6, effect = CONST_ME_POFF, target = false },
	{ name = "ferumbras soulfire", interval = 2000, chance = 15, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_LIFEDRAIN, minDamage = -1000, maxDamage = -2050, length = 8, spread = 0, effect = CONST_ME_HITBYPOISON, target = false },
}

monster.defenses = {
	defense = 120,
	armor = 100,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 600, maxDamage = 2490, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "combat", interval = 2000, chance = 1, type = COMBAT_HEALING, minDamage = 20000, maxDamage = 35000, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "speed", interval = 2000, chance = 14, speedChange = 700, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 7000 },
	{ name = "invisible", interval = 2000, chance = 10, duration = 9000, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -40 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 80 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onThink = function(monster, interval) end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
