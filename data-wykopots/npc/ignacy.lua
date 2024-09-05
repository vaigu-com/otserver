local internalNpcName = "Ignatz"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 514,
	lookHead = 59,
	lookBody = 40,
	lookLegs = 78,
	lookFeet = 99,
	lookAddons = 0,
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Mam szpadle, liny, maczety, kosy i inne przydatne gadzety..." },
	{ text = "Wedki plecaki, robaki w korzystnej cenie ! " },
	{
		text = "Jesli potrzebujesz sprzet niezbedny do eksplorowania terenu to dobrze trafiles.",
	},
	{ text = "Bez sprzetu na wyprawe? " },
	{
		text = "Ludzie to nie maja wyobrazni mam nadzieje ze w koncu wejdzie ta ustawa i na zwiedzanie bedzie mozna chodzic tylko z licencja...",
	},
}

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
	{ itemName = "quiver", clientId = 35562, buy = 400 },
	{ itemName = "red quiver", clientId = 35849, buy = 400 },
	{ itemName = "blue quiver", clientId = 35848, buy = 400 },
	{ itemName = "bow", clientId = 3350, sell = 100 },
	{ itemName = "crossbow", clientId = 3349, sell = 120 },
	{ itemName = "silkweaver bow", clientId = 8029, sell = 4000 },
	{ itemName = "elvish bow", clientId = 7438, sell = 2000 },
	{ itemName = "spear", clientId = 3277, sell = 3 },
	{ itemName = "modified crossbow", clientId = 8021, sell = 8000 },
	{ itemName = "crystal crossbow", clientId = 16163, sell = 35000 },
	{ itemName = "hive bow", clientId = 14246, sell = 28000 },
	{ itemName = "leaf star", clientId = 25735, sell = 50 },
	{ itemName = "chain bolter", clientId = 8022, sell = 40000 },
	{ itemName = "prismatic bolt", clientId = 16141, buy = 20 },
	{ itemName = "arrow", clientId = 3447, buy = 3 },
	{ itemName = "small stone", clientId = 1781, buy = 30 },
	{ itemName = "bolt", clientId = 3446, buy = 4 },
	{ itemName = "bow", clientId = 3350, buy = 400 },
	{ itemName = "crossbow", clientId = 3349, buy = 500 },
	{ itemName = "crystalline arrow", clientId = 15793, buy = 20 },
	{ itemName = "drill bolt", clientId = 16142, buy = 12 },
	{ itemName = "earth arrow", clientId = 774, buy = 5 },
	{ itemName = "envenomed arrow", clientId = 16143, buy = 12 },
	{ itemName = "assassin star", clientId = 7368, buy = 100 },
	{ itemName = "flaming arrow", clientId = 763, buy = 5 },
	{ itemName = "flash arrow", clientId = 761, buy = 5 },
	{ itemName = "onyx arrow", clientId = 7365, buy = 7 },
	{ itemName = "piercing bolt", clientId = 7363, buy = 5 },
	{ itemName = "power bolt", clientId = 3450, buy = 7 },
	{ itemName = "royal spear", clientId = 7378, buy = 15 },
	{ itemName = "shiver arrow", clientId = 762, buy = 5 },
	{ itemName = "sniper arrow", clientId = 7364, buy = 5 },
	{ itemName = "spear", clientId = 3277, buy = 9 },
	{ itemName = "tarsal arrow", clientId = 14251, buy = 6 },
	{ itemName = "throwing star", clientId = 3287, buy = 21 },
	{ itemName = "vortex bolt", clientId = 14252, buy = 6 },
	{ itemName = "diamond arrow", clientId = 35901, buy = 90 },
	{ itemName = "spectral bolt", clientId = 35902, buy = 70 },
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
