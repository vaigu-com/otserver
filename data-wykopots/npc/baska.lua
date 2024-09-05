local internalNpcName = "Barbara"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 150
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 10000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 136,
	lookHead = 58,
	lookBody = 42,
	lookLegs = 21,
	lookFeet = 42,
	lookAddons = 2,
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
	{ text = "Ten Lidl ciagle probuje kopiowac moje promocje..." },
	{ text = "Promocja na piersi z kurczaka i stejki ! Robcie zapasy !" },
	{ text = "Swieze warzywa i owoce w korzystnych cenach !" },
	{
		text = "Dostawcy bananow dalej nie spelniaja wymogow unijnych wzgledem ich krzywizny...A kare zaplace ja !",
	},
	{ text = "Kukurydza, ziemniaki, marchew, rzodkiew, wszystko bez GMO ! " },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Czesc ptysiu! Sprawdz moje nowe receptury i skladniki, wpisujac {trade}.")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Oh hello! Check out my new recipes, we can {trade} a little.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "Meat", clientId = 3577, sell = 2 },
	{ itemName = "Ham", clientId = 3582, sell = 4 },
	{ itemName = "Cheese", clientId = 3607, sell = 2 },
	{ itemName = "Carrot", clientId = 3595, sell = 1 },
	{ itemName = "Salmon", clientId = 3579, sell = 2 },
	{ itemName = "Blueberry", clientId = 3588, sell = 1 },
	{ itemName = "Cherry", clientId = 3590, sell = 1 },
	{ itemName = "Cookie", clientId = 3598, sell = 1 },
	{ itemName = "Cocktail Glass", clientId = 9232, sell = 50 },
	{ itemName = "Golden Mug", clientId = 2903, sell = 250 },
	{ itemName = "Green Mushroom", clientId = 3732, sell = 100 },
	{ itemName = "Baking Tray", clientId = 3464, buy = 20 },
	{ itemName = "Meat", clientId = 3577, buy = 10 },
	{ itemName = "Pumpkin", clientId = 3594, buy = 10 },
	{ itemName = "Ham", clientId = 3582, buy = 15 },
	{ itemName = "Bread", clientId = 3600, buy = 8 },
	{ itemName = "Brown Bread", clientId = 3602, buy = 4 },
	{ itemName = "Cake", clientId = 6277, buy = 50 },
	{ itemName = "Dragon Ham", clientId = 3583, buy = 25 },
	{ itemName = "Ice Cream Cone", clientId = 7372, buy = 10 },
	{ itemName = "Melon", clientId = 3593, buy = 13 },
	{ itemName = "Cheese", clientId = 3607, buy = 12 },
	{ itemName = "Mango", clientId = 5096, buy = 10 },
	{ itemName = "Scarab Cheese", clientId = 169, buy = 100 },
	{ itemName = "Fish", clientId = 3578, buy = 6 },
	{ itemName = "Valentine's Cake", clientId = 6392, buy = 100 },
	{ itemName = "Corncob", clientId = 3597, buy = 3 },
	{ itemName = "Roll", clientId = 3601, buy = 2 },
	{ itemName = "Carrot", clientId = 3595, buy = 8 },
	{ itemName = "Salmon", clientId = 3579, buy = 7 },
	{ itemName = "Jalapeno Pepper", clientId = 8016, buy = 2 },
	{ itemName = "Cucumber", clientId = 8014, buy = 5 },
	{ itemName = "Grapes", clientId = 3592, buy = 8 },
	{ itemName = "Onion", clientId = 8015, buy = 2 },
	{ itemName = "Pear", clientId = 3584, buy = 5 },
	{ itemName = "Beetroot", clientId = 8017, buy = 2 },
	{ itemName = "Plum", clientId = 8011, buy = 3 },
	{ itemName = "Red Apple", clientId = 3585, buy = 5 },
	{ itemName = "Banana", clientId = 3587, buy = 5 },
	{ itemName = "Blueberry", clientId = 3588, buy = 1 },
	{ itemName = "Cherry", clientId = 3590, buy = 1 },
	{ itemName = "Lemon", clientId = 8013, buy = 3 },
	{ itemName = "Raspberry", clientId = 8012, buy = 1 },
	{ itemName = "Potato", clientId = 8010, buy = 5 },
	{ itemName = "Tomato", clientId = 3596, buy = 10 },
	{ itemName = "Red Mushroom", clientId = 3724, buy = 12 },
	{ itemName = "Strawberry", clientId = 3591, buy = 2 },
	{ itemName = "Orange", clientId = 3586, buy = 10 },
	{ itemName = "Cookie", clientId = 3598, buy = 5 },
	{ itemName = "White Mushroom", clientId = 3723, buy = 10 },
	{ itemName = "Brown Mushroom", clientId = 3725, buy = 10 },
	{ itemName = "Amphora", clientId = 2893, buy = 4 },
	{ itemName = "Bottle", clientId = 2875, buy = 3 },
	{ itemName = "Bucket", clientId = 2873, buy = 4 },
	{ itemName = "Cup", clientId = 2881, buy = 3 },
	{ itemName = "Jug", clientId = 2882, buy = 10 },
	{ itemName = "Mug", clientId = 2880, buy = 4 },
	{ itemName = "Pot", clientId = 3465, buy = 30 },
	{ itemName = "Rum Flask", clientId = 5552, buy = 150 },
	{ itemName = "Vase", clientId = 2876, buy = 3 },
	{ itemName = "Waterskin", clientId = 2901, buy = 10 },
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
