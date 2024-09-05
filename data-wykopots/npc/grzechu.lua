local internalNpcName = "Greg"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 76,
	lookBody = 31,
	lookLegs = 20,
	lookFeet = 20,
	lookAddons = 1,
}

npcConfig.flags = { floorchange = 0 }

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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Czesc, tu Greg. Sprzedaje rozmaite narzedzia. Napisz {trade}, aby zobaczyc oferte.")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello, im Greg. I {trade} with various equipment.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "light shovel", clientId = 5710, sell = 300 },
	{ itemName = "crowbar", clientId = 3304, sell = 190 },
	{ itemName = "fishing rod", clientId = 3483, sell = 65 },
	{ itemName = "worm", clientId = 3492, sell = 1 },
	{ itemName = "backpack", clientId = 2854, sell = 5 },
	{ itemName = "rope", clientId = 3003, sell = 20 },
	{ itemName = "scythe", clientId = 3453, sell = 20 },
	{ itemName = "pick", clientId = 3456, sell = 20 },
	{ itemName = "shovel", clientId = 3457, sell = 20 },
	{ itemName = "rust remover", clientId = 9016, sell = 45 },
	{ itemName = "machete", clientId = 3308, buy = 40 },
	{ itemName = "sickle", clientId = 3293, buy = 8 },
	{ itemName = "crowbar", clientId = 3304, buy = 260 },
	{ itemName = "fishing rod", clientId = 3483, buy = 150 },
	{ itemName = "worm", clientId = 3492, buy = 1 },
	{ itemName = "backpack", clientId = 2854, buy = 20 },
	{ itemName = "bag", clientId = 2853, buy = 5 },
	{ itemName = "rope", clientId = 3003, buy = 50 },
	{ itemName = "scythe", clientId = 3453, buy = 50 },
	{ itemName = "pick", clientId = 3456, buy = 50 },
	{ itemName = "shovel", clientId = 3457, buy = 50 },
	{ itemName = "rust remover", clientId = 9016, buy = 100 },
	{ itemName = "blue backpack", clientId = 2869, buy = 20 },
	{ itemName = "golden backpack", clientId = 2871, buy = 20 },
	{ itemName = "green backpack", clientId = 2865, buy = 20 },
	{ itemName = "grey backpack", clientId = 2870, buy = 20 },
	{ itemName = "orange backpack", clientId = 9602, buy = 20 },
	{ itemName = "purple backpack", clientId = 2868, buy = 20 },
	{ itemName = "red backpack", clientId = 2867, buy = 20 },
	{ itemName = "yellow backpack", clientId = 2866, buy = 20 },
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
