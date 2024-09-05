local internalNpcName = "Malfurion"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 432,
	lookHead = 0,
	lookBody = 120,
	lookLegs = 114,
	lookFeet = 79,
	lookAddons = 3,
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

function checkDruidsStatus(creature)
	local player = Player(creature)
	if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) == 4 then
		player:addExperience(300000, true) -- 300k expa
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Za swoje zaslugi wsrod druidow mozesz isc do naszego swietego drzewa i pobrac buklak wody ze zrodla. ...",
			"Nasze swiete drzewo znajduje sie w samym sercu dzungli.",
		} or {
			"For your service among the druids, you may go to our holy tree and fetch a gob of water from the spring. ...",
			"Our sacred tree is located in the heart of the jungle.",
		}, npc, creature)
	end
	if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) == 7 then
		player:addExperience(500000, true) -- 500k expa
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Za twoje zaslugi wsrod druidow mozesz isc do naszego swietego drzewa i zerwac probke kwiatu Griffinclaw. ...",
			"Nasze swiete drzewo znajduje sie w samym sercu dzungli.",
		} or {
			"For your service among the druids, you may go to our sacred tree and pick a sample of the Griffinclaw flower. ...",
			"Our sacred tree is located in the heart of the jungle.",
		}, npc, creature)
		player:addItem(5940, 1) 
		player:setStorageValue(Storage.Finished.SciezkaDruida, 1)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Dodatkowo trzymaj ten oto naszyjnik i witaj w naszej spolecznosci." or "As a bonus, take this necklace. We welcome you in our community.", npc, creature)
	end
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	-- ============= MISJA 1 DRUID ADDON QUEST =================
	if table.contains({ "yes", "tak" }, message) then
		if player:getStorageValue(Storage.SciezkaDruida.BlyszczacyKrysztal) < 1 and npcHandler:getTopic(playerId) == 1 then
			player:setStorageValue(Storage.SciezkaDruida.BlyszczacyKrysztal, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "No to super, jak znajdziesz to wroc do mnie." or "Great! Come back if you find one.", npc, creature)
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) <= 0 then
				player:setStorageValue(Storage.SciezkaDruida.KragDruidow, 1)
			end
		end
	elseif table.contains({ "mission", "misja", "pomoc", "help" }, message) then
		if player:getStorageValue(Storage.SciezkaDruida.BlyszczacyKrysztal) == 1 then
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) == 4 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Najpierw udaj sie do naszego swietego drzewa i pobierz buklak wody ze zrodla. ...",
					"Swiete drzewo znajduje sie w samym sercu dzungli.",
				} or {
					"Before that, you should go to our sacred sacred tree and take a sample of magic water from the spring. ...",
					"Our sacred tree is located in the heart of the jungle.",
				}, npc, creature)
			else
				if player:getItemCount(7290) > 0 then
					player:removeItem(7290, 1)
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Ale blyszczacy, tak sadzilem ze dasz rade. Dziekuje ci w imieniu {druidow}. Trzymaj w zamian taki drobiazg." or "So shiny, I thought you could do it. Thank you on behalf of {druids}. And keep this in return.", npc, creature)
					player:addItem(16100, 1) -- dostaje plecak
					player:addItem(7250, 1) -- hydra tongue
					player:setStorageValue(Storage.SciezkaDruida.BlyszczacyKrysztal, 3) -- skonczona misja
					player:setStorageValue(Storage.SciezkaDruida.KragDruidow, player:getStorageValue(Storage.SciezkaDruida.KragDruidow) + 1) -- zwiekszamy licznik misji
					--  Q5.1
					player:addExperience(45000, true) -- 45k expa
					player:getPosition():sendMagicEffect(CONST_ME_STUN)
					--  Q5.1
					checkDruidsStatus(player)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc jak zdobedziesz lodowy krysztal." or "Come back when you find a shard.", npc, creature)
				end
			end
		elseif player:getStorageValue(Storage.SciezkaDruida.BlyszczacyKrysztal) < 1 then
			npcHandler:setTopic(playerId, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Chcesz zebym ci zlecil zadanie? Ostatnio mam wiele na glowie, a potrzebuje kawalki lodowego krysztalu do eksperymentu. ...",
				"Zdobedziesz jakis dla mnie? Na pewno sie odwdziecze!",
			} or {
				"I need a shard for my experiment, but I can't find the time to get one lately. I would be really grateful if you could bring me one. ...",
				"Will you find one for me? I will definitely pay back.",
			}, npc, creature)
		end
	end
	if table.contains({ "druidow", "druid", "druids" }, message) and player:getStorageValue(Storage.SciezkaDruida.BlyszczacyKrysztal) >= 3 then
		if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) == 2 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"No tak, powinienem Ci wytlumaczyc. Otoz na swiecie dawniej byl pokoj i my druidzi zylismy w dzungli, niestety nastaly zle czasy i musilismy uciec z naszej wioski, kazdy poszedl w inna strone. ...",
				"Zostalo nas pieciu, raz do roku spotykamy sie w wielkim drzewie. Jesli wykazesz sie wystarczajaca pomoca wobec nas, to rozwazymy twoje dolaczenie do naszej spolecznosci. ...",
				"Nie wiem, gdzie aktualnie przebywaja pozostali druidzi. Postaraj sie ich odnalezc, i okazac im nalezyta pomoc.",
			} or {
				"Right, I should explain the context first. The thing is, the world was at peace in the past so we lived together in the jungle as a druid would do, but the times changed for the worse and we were forced to leave our village, everyone went their own way. ...",
				"Only five of us remain, we meet once a year in a big tree in the jungle. If you prove yourself to be trustworthy, we might let you join us. ...",
				"I don't know where the others are now, do your best to find and help them if needed.",
			}, npc, creature)
		elseif player:getStorageValue(Storage.SciezkaDruida.KragDruidow) >= 3 and player:getStorageValue(Storage.SciezkaDruida.KragDruidow) < 7 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Mam nadzieje, ze zdolasz odnalezc pozostalych druidow, oraz okazac im nalezyta pomoc." or "I trust that you can find the remaining druids and help them.", npc, creature)
		elseif player:getStorageValue(Storage.SciezkaDruida.KragDruidow) == 7 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Dziekuje za pomoc mi oraz pozostalym druidom. Od teraz jestes jednym z nas." or "Thank you for helping me and the rest of the druids. Now you became one of us.", npc, creature)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Pozdrawiam Cie |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Niech natura bedzie z toba!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Czas na nikogo nie czeka!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Let nature stay with you!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
