local internalNpcName = "Namir"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 150
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2500
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 154,
	lookHead = 42,
	lookBody = 42,
	lookLegs = 76,
	lookFeet = 42,
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
	{ text = "Ale dzis goraco.." },
	{ text = "Chyba pora sie zdrzemnac.." },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({
		"ryz",
		"rice",
		"kulka ryzowa",
		"bunch of ripe rice",
		"rice ball",
		"ryzu",
	}, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Ahh! Skonczyl mi sie wlasnie caly ryz.. Masz moze jakies wiazki ryzowe przy sobie?" or "I've just run out of all the rice.. Do you have any bunch of ripe rice with you?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "yes", "tak" }, message) then
		if npcHandler:getTopic(playerId) == 1 then
			if player:removeItem(10328, 1) then
				player:addItem(10329, 1)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze, oto kulka dla ciebie." or "Here is rice ball for you", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Ehh, masz za malo.." or "You don't have enough..", npc, creature)
			end
		end
		return true
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Hej |PLAYERNAME|. Pewnie jestes spragniony? Mozesz sie u mnie czegos napic lub zjesc troche {ryzu}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Nara!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Do zobaczenia...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. Its so hot today, youre probably really thirsty. You can buy chilled drinks there or eat some {rice}.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Bye!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "juice squeezer", clientId = 5865, sell = 50 },
	{ itemName = "Lemonade", clientId = 2874, subType = 12, buy = 25 },
	{ itemName = "Wine", clientId = 2874, subType = 2, buy = 10 },
	{ itemName = "Meat", clientId = 3577, buy = 5 },
	{ itemName = "Cheese", clientId = 3607, buy = 5 },
	{ itemName = "Bread", clientId = 3600, buy = 3 },
	{ itemName = "juice squeezer", clientId = 5865, buy = 350 },
	{ itemName = "Bug Milk", clientId = 8758, buy = 550 },
	{ itemName = "Water", clientId = 2875, subType = 1, buy = 20 },
	{ itemName = "Mug of beer", clientId = 2880, subType = 3, buy = 5 },
	{ itemName = "Mug of wine", clientId = 2880, subType = 2, buy = 10 },
	{ itemName = "Empty mead horn", clientId = 7140, buy = 320 },
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
