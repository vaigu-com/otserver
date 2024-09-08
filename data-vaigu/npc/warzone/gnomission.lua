local internalNpcName = "Gnomission"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 493,
	lookHead = 41,
	lookBody = 115,
	lookLegs = 100,
	lookFeet = 95,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "warzones") then
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) == 18 then
			npcHandler:say({
				"There are three warzones. In each warzone you will find fearsome foes. At the end you'll find their mean master. The masters is well protected though. ...",
				"Make sure to talk to our gnomish agent in there for specifics of its' protection. ...",
				"Oh, and to be able to enter the second warzone you have to best the first. To enter the third you have to best the second. ...",
				"And you can enter each one only once every twenty hours. Your normal teleport crystals won't work on these teleporters. You will have to get {mission} crystals from Gnomally.",
			}, npc, creature)
			player:setStorageValue(Storage.BigfootBurden.Warzone1Entry, 1)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "job") then
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) >= 18 then
			npcHandler:say("I am responsible for our war missions, to trade with seasoned soldiers and rewarding war {heroes}. You have to be rank 4 to enter the warzones.", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "heroes") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say({
				"You can trade special spoils of war to get a permission to use the war teleporters to the area of the corresponding boss without need of mission crystals. ...",
				"Which one would you like to trade: the deathstrike's {snippet}, gnomevil's {hat} or the abyssador {lash}?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 3)
		end
	elseif MsgContains(message, "snippet") then
		if npcHandler:getTopic(playerId) == 3 then
			if player:removeItem(16136, 1) then
				player:setStorageValue(Storage.BigfootBurden.Warzone1Access, 1)
				npcHandler:say("As a war hero you are allowed to use the warzone teleporter one for free!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "lash") then
		if npcHandler:getTopic(playerId) == 3 then
			if player:removeItem(16206, 1) then
				player:setStorageValue(Storage.BigfootBurden.Warzone3Access, 1)
				npcHandler:say("As a war hero you are allowed to use the warzone teleporter three for free!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "hat") then
		if npcHandler:getTopic(playerId) == 3 then
			if player:removeItem(16205, 1) then
				player:setStorageValue(Storage.BigfootBurden.Warzone2Access, 1)
				npcHandler:say("As a war hero you are allowed to use the warzone teleporter two for free!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "mission") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Fine, I grant you the permission to enter the warzones. Be warned though, this will be not a picnic. Better bring some friends with you. Bringing a lot of them sounds like a good idea.", npc, creature)
			player:setStorageValue(Storage.BigfootBurden.QuestLine, 19)
			player:setStorageValue(Storage.BigfootBurden.WarzoneStatus, 1)
			player:setStorageValue(Storage.Finished.BigfootsBurden, 1)
			player:addItem(16242, 3)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. You are probably eager to enter the {warzones}. Or you want to know, whats my {job}?")
--npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. You are probably eager to enter the {warzones}. Or you want to know, whats my {job}?')
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye!")
--npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "mushroom pie", clientId = 16103, buy = 150 },
	{ itemName = "windborn colossus armor", clientId = 8055, sell = 50000 },
	{ itemName = "impaler", clientId = 7435, sell = 80000 },
	{ itemName = "frozen plate", clientId = 8059, sell = 60000 },
	{ itemName = "demonbone", clientId = 7431, sell = 80000 },
	{ itemName = "witchhunter's coat", clientId = 7993, sell = 30000 },
	{ itemName = "crystalline sword", clientId = 16160, sell = 70000 },
	{ itemName = "robe of the ice queen", clientId = 8038, sell = 50000 },
	{ itemName = "ravenwing", clientId = 7433, sell = 40000 },
	{ itemName = "oceanborn leviathan armor", clientId = 8056, sell = 45000 },
	{ itemName = "havoc blade", clientId = 7405, sell = 55000 },
	{ itemName = "twin axe", clientId = 3335, sell = 35000 },
	{ itemName = "the devileye", clientId = 8024, sell = 70000 },
	{ itemName = "dark lord's cape", clientId = 8037, sell = 60000 },
	{ itemName = "earthborn titan armor", clientId = 8054, sell = 60000 },
	{ itemName = "velvet mantle", clientId = 8040, sell = 60000 },
	{ itemName = "snake god's wristguard", clientId = 11691, sell = 50000 },
	{ itemName = "greenwood coat", clientId = 8041, sell = 50000 },
	{ itemName = "mucus plug", clientId = 16102, sell = 500 },
	{ itemName = "trophy of jaul", clientId = 14224, sell = 4000 },
	{ itemName = "trophy of tanjis", clientId = 14223, sell = 2000 },
	{ itemName = "trophy of obujos", clientId = 14222, sell = 3000 },
	{ itemName = "stuffed dragon", clientId = 5791, sell = 6000 },
	{ itemName = "frozen starlight", clientId = 3249, sell = 20000 },
	{ itemName = "ceremonial ankh", clientId = 6561, sell = 20000 },
	{ itemName = "arcane staff", clientId = 3341, sell = 42000 },
	{ itemName = "the avenger", clientId = 6527, sell = 42000 },
	{ itemName = "arbalest", clientId = 5803, sell = 42000 },
	{ itemName = "golden sickle", clientId = 3306, sell = 1000 },
	{ itemName = "golden amulet", clientId = 3013, sell = 2000 },
	{ itemName = "star amulet", clientId = 3014, sell = 500 },
	{ itemName = "modified crossbow", clientId = 8021, sell = 10000 },
	{ itemName = "dwarven axe", clientId = 3323, sell = 1500 },
	{ itemName = "sea serpent trophy", clientId = 9613, sell = 10000 },
	{ itemName = "souleater trophy", clientId = 11679, sell = 7500 },
	{ itemName = "marlin trophy", clientId = 902, sell = 5000 },
	{ itemName = "red tome", clientId = 2852, sell = 2000 },
	{ itemName = "purple tome", clientId = 2848, sell = 2000 },
	{ itemName = "runed sword", clientId = 7417, sell = 45000 },
	{ itemName = "unholy book", clientId = 6103, sell = 30000 },
	{ itemName = "crystal wand", clientId = 3068, sell = 10000 },
	{ itemName = "panda teddy", clientId = 5080, sell = 30000 },
	{ itemName = "baby seal doll", clientId = 7183, sell = 20000 },
	{ itemName = "bejeweled ship's telescope", clientId = 9616, sell = 20000 },
	{ itemName = "the ironworker", clientId = 8025, sell = 50000 },
	{ itemName = "executioner", clientId = 7453, sell = 55000 },
	{ itemName = "egg of the many", clientId = 9606, sell = 15000 },
	{ itemName = "claw of 'the noxious spawn'", clientId = 9392, sell = 15000 },
	{ itemName = "blade of corruption", clientId = 11693, sell = 60000 },
	{ itemName = "bloody edge", clientId = 7416, sell = 30000 },
	{ itemName = "demon helmet", clientId = 3387, sell = 40000 },
	{ itemName = "dwarven legs", clientId = 3398, sell = 40000 },
	{ itemName = "silkweaver bow", clientId = 8029, sell = 12000 },
	{ itemName = "ornamented shield", clientId = 3424, sell = 1500 },
	{ itemName = "blue legs", clientId = 645, sell = 15000 },
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
