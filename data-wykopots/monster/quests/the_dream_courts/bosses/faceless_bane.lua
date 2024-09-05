local mType = Game.createMonsterType("Faceless Bane")
local monster = {}

monster.description = "a Faceless Bane"
monster.experience = 14000
monster.outfit = {
	lookType = 1122,
	lookHead = 0,
	lookBody = 4,
	lookLegs = 95,
	lookFeet = 4,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1727,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 30000
monster.maxHealth = 30000
monster.race = "blood"
monster.corpse = 30013
monster.speed = 125
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
	"FacelessDeath",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "platinum coin", chance = 90000, maxCount = 10 },
	{ name = "gold ingot", chance = 10000 },
	{ name = "small sapphire", chance = 35000, maxCount = 3 },
	{ name = "red crystal fragment", chance = 12000 },
	{ name = "cyan crystal fragment", chance = 8000 },
	{ name = "green crystal shard", chance = 8000 },
	{ name = "violet crystal shard", chance = 8000 },
	{ id = 3039, chance = 5000 },
	{ name = "yellow gem", chance = 4000 },
	{ name = "blue gem", chance = 4000 },
	{ name = "green gem", chance = 4000 },
	{ name = "violet gem", chance = 1000 },
	{ name = "life crystal", chance = 100000 },
	{ name = "hexagonal ruby", chance = 1500 },
	{ name = "flash arrow", chance = 10000, minCount = 10, maxCount = 20 },
	{ name = "twin hooks", chance = 15000 },
	{ name = "strange talisman", chance = 10000 },
	{ name = "lightning pendant", chance = 8000 },
	{ name = "ice rapier", chance = 20000 },
	{ name = "necrotic rod", chance = 5000 },
	{ name = "wand of everblazing", chance = 1400 },
	{ name = "dream blossom staff", chance = 1400 },
	{ name = "hailstorm rod", chance = 15000 },
	{ name = "terra rod", chance = 15000 },
	{ name = "underworld rod", chance = 10000 },
	{ name = "ectoplasmic shield", chance = 2700 },
	{ name = "book backpack", chance = 1300 },
	{ name = "spirit guide", chance = 1200 },
	{ id = 29429, chance = 1300 }, -- pendulet
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 },
	{ name = "energy strike", interval = 2000, chance = 28, minDamage = -300, maxDamage = -600, range = 7, target = false },
	{ name = "death strike", interval = 2000, chance = 28, minDamage = -300, maxDamage = -900, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_LIFEDRAIN, minDamage = -500, maxDamage = -800, length = 7, spread = 0, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 30,
	{ name = "faceless bane summon", interval = 8000, chance = 40, target = false },
}

monster.reflects = {
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
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
	{ type = COMBAT_DEATHDAMAGE, percent = 90 },
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
