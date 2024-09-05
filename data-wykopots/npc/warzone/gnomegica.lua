local internalNpcName = "Gnomegica"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 507,
	lookHead = 79,
	lookBody = 94,
	lookLegs = 94,
	lookFeet = 52,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = 0,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. I sell potions, runes, rods and wands!")
--npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. I sell potions, runes, rods and wands!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "Avalanche Rune", clientId = 3161, buy = 45 },
	{ itemName = "Blank Rune", clientId = 3147, buy = 10 },
	{ itemName = "Chameleon Rune", clientId = 3178, buy = 210 },
	{ itemName = "Convince Creature Rune", clientId = 3177, buy = 80 },
	{ itemName = "Destroy Field Rune", clientId = 3148, buy = 15 },
	{ itemName = "Energy Field Rune", clientId = 3164, buy = 38 },
	{ itemName = "Energy Wall Rune", clientId = 3166, buy = 85 },
	{ itemName = "Explosion Rune", clientId = 3200, buy = 31 },
	{ itemName = "Fire Bomb Rune", clientId = 3192, buy = 117 },
	{ itemName = "Fire Field Rune", clientId = 3188, buy = 28 },
	{ itemName = "Fire Wall Rune", clientId = 3190, buy = 61 },
	{ itemName = "Great Fireball Rune", clientId = 3191, buy = 45 },
	{ itemName = "Great Health Potion", clientId = 239, buy = 190 },
	{ itemName = "Great Mana Potion", clientId = 238, buy = 120 },
	{ itemName = "Great Spirit Potion", clientId = 7642, buy = 190 },
	{ itemName = "Health Potion", clientId = 266, buy = 45 },
	{ itemName = "Heavy Magic Missile Rune", clientId = 3198, buy = 12 },
	{ itemName = "Light Magic Missile Rune", clientId = 3174, buy = 4 },
	{ itemName = "Mana Potion", clientId = 268, buy = 50 },
	{ itemName = "Moonlight Rod", clientId = 3070, buy = 1000 },
	{ itemName = "Necrotic Rod", clientId = 3069, buy = 5000 },
	{ itemName = "Poison Field Rune", clientId = 3172, buy = 21 },
	{ itemName = "Poison Wall Rune", clientId = 3176, buy = 52 },
	{ itemName = "Snakebite Rod", clientId = 3066, buy = 500 },
	{ itemName = "Spellbook", clientId = 3101, buy = 150 },
	{ itemName = "Stalagmite Rune", clientId = 3179, buy = 12 },
	{ itemName = "Strong Health Potion", clientId = 236, buy = 100 },
	{ itemName = "Strong Mana Potion", clientId = 237, buy = 80 },
	{ itemName = "Sudden Death Rune", clientId = 3155, buy = 108 },
	{ itemName = "Terra Rod", clientId = 3065, buy = 10000 },
	{ itemName = "Ultimate Health Potion", clientId = 7643, buy = 310 },
	{ itemName = "Wand of Cosmic Energy", clientId = 3073, buy = 10000 },
	{ itemName = "Wand of Decay", clientId = 3072, buy = 5000 },
	{ itemName = "Wand of Dragonbreath", clientId = 3075, buy = 1000 },
	{ itemName = "Wand of Vortex", clientId = 3074, buy = 500 },
	{ itemName = "Spellwand", clientId = 651, sell = 299 },
	{ itemName = "Vial", clientId = 2874, sell = 5 },
	{ itemName = "empty great potion flask", clientId = 284, sell = 15 },
	{ itemName = "empty strong potion flask", clientId = 283, sell = 10 },
	{ itemName = "empty small potion flask", clientId = 285, sell = 5 },
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
