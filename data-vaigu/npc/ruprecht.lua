local internalNpcName = "Ruprecht"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 153,
	lookHead = 59,
	lookBody = 115,
	lookLegs = 115,
	lookFeet = 38,
	lookAddons = 3,
}

npcConfig.flags = { floorchange = false }

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

local storeTable = {}
local itemsTable = {
	["gingerbreadman"] = { itemId = 6500, count = 1 },
	["christmas cookie tray"] = { itemId = 20310, count = 1 },
	["gingerbread recipe"] = { itemId = 6522, count = 10 },
	["jewel case"] = { itemId = 7527, count = 15 },
	["santa hat"] = { itemId = 6531, count = 20 },
	["santa backpack"] = { itemId = 10346, count = 25 },
	["snowflake tapestry"] = { itemId = 20315, count = 15 },
	["santa doll"] = { itemId = 6511, count = 30 },
	["snowman doll"] = { itemId = 10339, count = 50 },
	["snow globe"] = { itemId = 20311, count = 50 },
	["frazzlemaw santa"] = { itemId = 20308, count = 80 },
	["leaf golem santa"] = { itemId = 20309, count = 80 },
	["santa music box"] = { itemId = 20313, count = 80 },
	["santa teddy"] = { itemId = 10338, count = 120 },
	["maxxen santa"] = { itemId = 21952, count = 80 },
	["orclops santa"] = { itemId = 24394, count = 80 },
	["santa fox"] = { itemId = 27591, count = 80 },
	["nightmare beast santa"] = { itemId = 29947, count = 80 },
	["present bag"] = { itemId = 6496, count = 1 },
	["ferumbras' teddy santa"] = { itemId = 22879, count = 80 },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "oferte") or MsgContains(message, "oferta") or MsgContains(message, "christmas tokens") then
		local text = "Oto moja oferta: "
		if getPlayerLanguage(player) == "EN" then
			text = "I have these offers: "
		end
		for i, v in pairs(itemsTable) do
			text = text .. "{" .. i .. "}, "
		end
		npcHandler:say(text, npc, creature)
	end

	if npcHandler:getTopic(playerId) == 0 then
		local table = itemsTable[message]
		if table then
			if table.itemId ~= 6496 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wiec chcesz otrzymac " .. message .. ", za " .. table.count .. " christmas token?" or "So you want to exchange " .. message .. ", for " .. table.count .. " christmas tokens?", npc, creature)
				storeTable[playerId] = message
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wiec chcesz oddac " .. message .. " za " .. table.count .. " christmas token?" or "So you want to exchange " .. message .. " to " .. table.count .. " christmas token(s)?", npc, creature)
				storeTable[playerId] = 6527
				npcHandler:setTopic(playerId, 1)
			end
		end
	elseif npcHandler:getTopic(playerId) == 1 then
		if MsgContains(message, "yes") or MsgContains(message, "tak") then
			if tonumber(storeTable[playerId]) == 6527 then
				if player:removeItem(6496, 1) then
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Dzieki, oto token dla ciebie!" or "Thank you, here is your 1 christmas token.", npc, creature)
					player:addItem(6526, 1)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie posiadasz present baga." or "You don't have a present bag.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
				return false
			end
			if player:removeItem(6526, itemsTable[storeTable[playerId]].count) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Dzieki, oto twoj " .. storeTable[playerId] .. "." or "Thank you, here is your " .. storeTable[playerId] .. ".", npc, creature)
				player:addItem(itemsTable[storeTable[playerId]].itemId, 1)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz wystarczajacej liczby tokenow." or "You don't have enough of tokens.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif npcHandler:getTopic(playerId) > 0 then
		if MsgContains(message, "no") or MsgContains(message, "nie") then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc z jakimis tokenami!" or "Come back when you are ready to trade some tokens!", npc, creature)
		end
	end
	if MsgContains(message, "santa claus") then
		npcHandler:say({ "He does not exist." }, npc, creature)
	end
	return true
end

local function onReleaseFocus(npc, creature)
	local playerId = creature:getId()
	storeTable[playerId] = nil
end

npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)

npcHandler:setMessage(MESSAGE_GREET, "Wesolych swiat, |PLAYERNAME|. By wymienic Christmas Tokeny popros o {oferte}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Zegnaj, |PLAYERNAME|!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Merry christmas, |PLAYERNAME|. Would you like to exchange some {christmas tokens}? ')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye, |PLAYERNAME|!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
