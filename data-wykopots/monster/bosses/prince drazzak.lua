local mType = Game.createMonsterType("Prince Drazzak")
local monster = {}

monster.description = "Prince Drazzak"
monster.experience = 210000
monster.outfit = {
	lookType = 12,
	lookHead = 77,
	lookBody = 78,
	lookLegs = 94,
	lookFeet = 54,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 330000
monster.maxHealth = 330000
monster.race = "fire"
monster.corpse = 6068
monster.speed = 240
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 25,
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
	runHealth = 2000,
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
	{ text = "EVEN WITH ALL THAT TIME IN THE PRISON THAT WEAKENED ME, YOU ARE NO MATCH TO ME!", yell = true },
	{ text = "VARIPHOR WILL RULE!", yell = true },
	{ text = "THEY WILL ALL PAY!", yell = true },
	{ text = "NOT EVEN AEONS OF IMPRISONMENT WILL STOP ME!", yell = true },
	{ text = "They used you fools to escape and they left ME behind!!??", yell = false },
}

monster.loot = {
	{ id = 20063, chance = 100000 }, -- dream
	{ id = 20062, chance = 100000, maxCount = 5 }, -- cluster
	{ id = 20264, chance = 93750, maxCount = 3 }, --unrea
	{ name = "demonic essence", chance = 100000, maxCount = 2 },
	{ id = 5954, chance = 50000 }, -- demon horn
	{ name = "platinum coin", chance = 100000, maxCount = 20 },
	{ id = 7643, chance = 100000, maxCount = 10 },
	{ id = 7642, chance = 100000, maxCount = 10 },
	{ name = "great mana potion", chance = 100000, maxCount = 10 },
	{ id = 20279, chance = 25000 }, -- eye pod
	{ id = 20277, chance = 25000 }, -- tapestry
	{ id = 20278, chance = 25000 }, -- tapestry
	{ id = 5741, chance = 5500 }, -- skull helm
	{ id = 7417, chance = 2500, unique = true }, -- runed sword
	{ id = 20276, chance = 7000, unique = true }, -- mask
	{ id = 7418, chance = 10000 }, -- nightmare blade
	{ id = 820, chance = 20000 }, -- light boots
	{ id = 281, chance = 25000 }, -- shimm
	{ id = 282, chance = 25000 }, -- shimm
	{ id = 7414, chance = 1000 }, -- abyss
	{ id = 16119, maxCount = 5, chance = 47060 }, --  blue crystal shard
	{ id = 16120, maxCount = 5, chance = 35290 }, -- violet crystal shard
	{ id = 16125, maxCount = 5, chance = 23530 }, -- cyan crystal fragment
	{ id = 16121, maxCount = 5, chance = 17650 }, -- green crystal shard
	{ id = 282, maxCount = 5, chance = 29410 }, -- red crystal fragment
	{ id = 8050, chance = 5880 }, -- crystalline armor
	{ id = 3019, chance = 5000 }, -- demonbone amulet
	{ id = 3038, chance = 29410 }, -- green gem
	{ id = 825, chance = 29410 }, -- lightning robe
	{ id = 20282, chance = 17650 }, -- night hook
	{ id = 7456, chance = 5880 }, -- noble axe
	{ id = 3098, chance = 5880 }, -- ring of healing
	{ id = 3554, chance = 5880 }, -- steel boots
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 190, attack = 100 },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_DEATHDAMAGE, minDamage = -1000, maxDamage = -2500, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "prince drazzak wave", interval = 2000, chance = 16, minDamage = 0, maxDamage = -1200, target = false },
	{ name = "prince drazzak knight", interval = 2000, chance = 5, target = false },
	{ name = "prince drazzak druid", interval = 2000, chance = 5, target = false },
	{ name = "prince drazzak paladin", interval = 2000, chance = 5, target = false },
	{ name = "prince drazzak sorcerer", interval = 2000, chance = 5, target = false },
	{ name = "prince drazzak tp", interval = 2000, chance = 4, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 3000, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "prince drazzak summon", interval = 2000, chance = 4, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
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
