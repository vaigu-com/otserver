local mType = Game.createMonsterType("Mawhawk")
local monster = {}

monster.description = "Mawhawk"
monster.experience = 15000
monster.outfit = {
	lookType = 595,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1028,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 25000
monster.maxHealth = 25000
monster.race = "blood"
monster.corpse = 20295
monster.speed = 135
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.strategiesTarget = {
	nearest = 60,
	health = 15,
	damage = 15,
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
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.events = {
	"MawhawkDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Knorrrr!", yell = false },
}

monster.summon = {
	maxSummons = 1,
	summons = {
		{ name = "guzzlemaw", chance = 20, interval = 2000, count = 1 },
	},
}

monster.loot = {
	{ id = 20062, chance = 100000, maxCount = 2 }, -- cluster
	{ id = 20198, chance = 50000 },
	{ id = 20264, chance = 100000, maxCount = 2 }, -- unrealized
	{ name = "gold coin", chance = 10000, maxCount = 100 },
	{ name = "platinum coin", chance = 10000, maxCount = 25 },
	{ id = 3280, chance = 50000 }, -- fire sword
	{ id = 5880, chance = 15000 }, -- iron ore
	{ id = 5895, chance = 33000 }, -- fish fin
	{ id = 5911, chance = 33000 }, -- red poc
	{ id = 5925, chance = 16000 }, -- bone
	{ id = 7404, chance = 16000 }, -- assa
	{ id = 7407, chance = 16000 }, -- hau
	{ id = 7418, chance = 8000 }, -- nightmare b
	{ id = 16120, chance = 33000, maxCount = 5 },
	{ id = 16121, chance = 33000, maxCount = 5 },
	{ id = 16122, chance = 33000, maxCount = 5 },
	{ id = 16124, chance = 33000, maxCount = 5 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 90 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -685, length = 7, spread = 0, effect = CONST_ME_STONES, target = false },
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 15, minDamage = -1000, maxDamage = -1500, radius = 3, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -900, length = 5, spread = 0, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "mawhawk ue", interval = 1000, chance = 100, minDamage = -1500, maxDamage = -1700, target = true },
	{ name = "frazzlemaw paralyze", interval = 2000, chance = 15, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 200, maxDamage = 800, effect = CONST_ME_MAGIC_BLUE, target = false },
	--{name ="mawhawk summon", interval = 2000, chance = 1, target = false}
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
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
