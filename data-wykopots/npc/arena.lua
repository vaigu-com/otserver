local internalNpcName = "Arena"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2500
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 154,
	lookHead = 120,
	lookBody = 5,
	lookLegs = 5,
	lookFeet = 114,
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
	{ text = "Wejdz na arene i walcz ! Wroc z tarcza lub na tarczy !" },
	{ text = "Jesli nie brak Ci odwagi, sprawdz sie w obliczu ciezkiej walki!" },
	{ text = "My smiertelnicy jestesmy jedynie cieniami i pylem." },
	{ text = "To, co czynimy za zycia, odbija sie echem w wiecznosci." },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({
		"arena",
		"zadanie",
		"fight",
		"walka",
		"arene",
		"wyzwanie",
		"wazwania",
	}, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Mam do zaoferowania 3 poziomy trudnosci areny, {latwa}, {srednia} oraz {trudna}. Ktorej chcesz sie podjac?" or "There are three difficulties: {greenhorn}, {scrapper} and {warlord}. Which one are you interested in?", npc, creature)
		if player:getStorageValue(26100) > 0 and player:getStorageValue(26101) > 0 and player:getStorageValue(26102) > 0 and not player:hasOutfit(884) then
			player:addOutfitAddon(885, 3)
			player:addOutfitAddon(884, 3)
			if getPlayerLanguage(player) == "PL" then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Otrzymujesz Arena Champion Outfit plus dodatki za wykonanie trzech aren!")
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received Arena Champion Outfit!")
			end
		end
	elseif table.contains({ "latwa", "latwy", "greenhorn" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Czy jestes {pewny}, ze poradzisz sobie na tej arenie?" or "Are you {sure}?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "srednia", "sredni", "scrapper" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Czy jestes {pewny}, ze poradzisz sobie na tej arenie?" or "Are you {sure}?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({ "trudna", "trudny", "warlord" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Czy jestes {pewny}, ze poradzisz sobie na tej arenie?" or "Are you {sure}?", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif table.contains({ "yes", "tak", "pewny", "pewna", "sure" }, message) and (npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 or npcHandler:getTopic(playerId) == 3) then
		if player:getStorageValue(26099 + npcHandler:getTopic(playerId)) > 0 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Ta arena zostala zakonczona, ale mozesz wejsc do sali po nagrode." or "You already finished that difficulty, but you can go get your reward.", npc, creature)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
			player:teleportTo(Position(6918, 630, 7))
		else
			if roomsIsOccupied() then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wszystkie areny sa zajete! Wroc do mnie za kilku minut. Elo." or "Each room if occupied now. Come back in some time.", npc, creature)
				npcHandler:removeInteraction(npc, creature)
				npcHandler:resetNpc(creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Powodzenia!" or "Good luck!", npc, creature)
				local level = npcHandler:getTopic(playerId)
				player:setStorageValue(300 + level, 1)
				local room = player:getStorageValue(300 + level)
				local boss = arena_bosses[level == 1 and room or level == 2 and 10 + room or 20 + room]
				local arenaroom = 0
				for i = 1, 10 do
					local spectators = Game.getSpectators(rooms[i].centerPosition, false, false, 7, 7, 7, 7)
					if #spectators == 0 then
						arenaroom = i
					end
				end
				player:setStorageValue(300, arenaroom)
				local monster = Game.createMonster(boss, rooms[arenaroom].centerPosition, true, true)
				player:teleportTo(rooms[arenaroom].teleportPosition)
				local event_id = addEvent(clearArena, 10 * 60 * 1000, player.uid, monster.uid, arenaroom)
				player:setStorageValue(299, event_id)
				if getPlayerLanguage(player) == "PL" then
					player:say("Masz 7 minut na pokonanie kazdego przeciwnika.", TALKTYPE_MONSTER_SAY)
				else
					player:say("You have 7 minutes to defeat this creature.", TALKTYPE_MONSTER_SAY)
				end
				if not monster then
					return true
				end
				npcHandler:removeInteraction(npc, creature)
				npcHandler:resetNpc(creature)
			end
		end
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj dzielny wojowniku. Chcesz wejsc na {arene}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Uwazaj na siebie!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Powodzenia!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello competitor! Do you want to fight in the {arena}?')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Take care of yourself!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'Good luck!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
