local internalNpcName = "Vanys"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1136,
	lookHead = 15,
	lookBody = 57,
	lookLegs = 15,
	lookFeet = 92,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "talk") or MsgContains(message, "porozmawiac") then
		if player:getLevel() >= 60 then
			if player:getStorageValue(Storage.TheDreamCourts.QuestLine) == 1 then
				npcHandler:say({
					"You have to empower eight ward stones. Once charged with arcane energy, they will strengthen the Nightmare Beast's prison and at the same time weaken this terrible creature. We know about the specific location of sevem of those stones. ...",
					"You can find them in the mountains of Pirate Island, on bonebast coast in desert, in a water elemental cave beneath Kongo, in the depths of Seacrest Serpent lair, on the surface of Sybir and on the Nightmare Island. ...",
					"The location of the last ward stone is a bit more obscure, however. We are not completely sure where it is. You should make inquiries at abandoned depths of Karaiby isle. I heard they are haunted by strange spectres now. ...",
					"Take this talisman to empower the ward stones. It will work with all the stones at known locations. ...",
					"However, the empowering of the last stone could be a bit more complicated. But you have to find out yourself what to do..",
				}, npc, creature)
				player:addItem(30132)
				player:setStorageValue(Storage.TheDreamCourts.QuestLine, 2)
			elseif (player:getStorageValue(Storage.TheDreamCourts.QuestLine) == 2) and (player:getStorageValue(Storage.TheDreamCourts.WardStones.WardStones) < 8) then
				npcHandler:say({
					"Come back when you empower all ward stones, good luck.",
				}, npc, creature)
			elseif (player:getStorageValue(Storage.TheDreamCourts.QuestLine) == 2) and (player:getStorageValue(Storage.TheDreamCourts.WardStones.WardStones) >= 8) then
				npcHandler:say({ "So do you want talk about the {task} at hand?" }, npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif player:getStorageValue(Storage.TheDreamCourts.QuestLine) == 4 then
				npcHandler:say({ "So do you want talk about the {task} at hand?" }, npc, creature)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say({ "I dont think we have anything to talk about." }, npc, creature)
			end
		else
			npcHandler:say({ "Im pretty sure you are not experienced enough." }, npc, creature)
		end
	elseif MsgContains(message, "task") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say({
			"You empowered all eight ward stones. Well done! You may now enter the Dream Labyrinth via the portal here in the Court. Beneath it you will find the Nightmare Beast's lair. But the labyrinth is protected by couple so called Dream Doors. ...",
			"You have to find the way to unlock the Dream Doors down there. Only then you will be able to enter the Nightmare Beast's lair.",
		}, npc, creature)
		player:setStorageValue(Storage.TheDreamCourts.QuestLine, 3)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "task") and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say({
			"The Nightmare Beast is slain. You have done well. The Courts of Summer will be forever grateful. For your efforts I want to reward you with our traditional dream warrior outfit. May it suit you well!",
		}, npc, creature)
		player:addOutfit(1146, 0)
		player:addOutfit(1147, 0)
		player:setStorageValue(Storage.TheDreamCourts.QuestLine, 5)
		player:setStorageValue(Storage.Finished.TheDreamCourts, 1)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "addon") then
		npcHandler:say({
			"I provide two addons. For the first one I need you to bring me five pomegranates. For the second addon you need an ice shield. Do you want one of these addons?",
		}, npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 3 then
		if player:getStorageValue(Storage.TheDreamCourts.QuestLine) >= 5 then
			npcHandler:say({
				"What do you have for me: the {pomegranates} or the {ice shield}?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 4)
		else
			npcHandler:say({ "You dont even have an outfit yet.." }, npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "pomegranates") and npcHandler:getTopic(playerId) == 4 then
		if player:getItemCount(30169) >= 5 then
			player:removeItem(30169, 5)
			player:addOutfitAddon(1146, 1)
			player:addOutfitAddon(1147, 1)
			npcHandler:say({
				"Very good! You gained the first addon to the dream warrior outfit.",
			}, npc, creature)
		else
			npcHandler:say({ "You don't have 5 pomegranates." }, npc, creature)
		end
	elseif MsgContains(message, "ice shield") and npcHandler:getTopic(playerId) == 4 then
		if player:getItemCount(30168) >= 1 then
			player:removeItem(30168, 1)
			player:addOutfitAddon(1146, 2)
			player:addOutfitAddon(1147, 2)
			npcHandler:say({
				"Very good! You gained the second addon to the dream warrior outfit.",
			}, npc, creature)
		else
			npcHandler:say({ "You don't have ice shield." }, npc, creature)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj bohaterze. Zapewne przyszedles {porozmawiac}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Do widzenia!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Zegnaj..")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Greetings hero. I guess you came here for {talk}.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Bye!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'Bye..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
