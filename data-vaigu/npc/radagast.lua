local internalNpcName = "Radaghast the brown"
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
	lookHead = 57,
	lookBody = 95,
	lookLegs = 114,
	lookFeet = 119,
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
	if table.contains({ "lodka", "lodz", "boat" }, message) then
		if player:getStorageValue(Storage.SciezkaDruida.SezonNaJelenie) == 3 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Sam plywam nia tylko na ryby, jednak mozliwe jest przeplyniecie na wyspe koszmarow." or "I use this boat for fishing only, however it is possible to sail to the Nightmare Island", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie pozwole ci przeplynac na wyspe koszmarow, poki nie zdobedziesz mojego zaufania." or "I won't let you use my boat yet.", npc, creature)
		end
	end
	if table.contains({ "yes", "tak" }, message) then
		if player:getStorageValue(Storage.SciezkaDruida.SezonNaJelenie) < 1 and npcHandler:getTopic(playerId) == 1 then
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) <= 0 then
				player:setStorageValue(Storage.SciezkaDruida.KragDruidow, 1)
			end
			player:setStorageValue(Storage.SciezkaDruida.SezonNaJelenie, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Najlepiej jak zakradniesz sie do ich obozu i podpalisz ich zbior drewna. To powinno zajac im sporo czasu i ocalic duza czesc zwierzat." or "The best way would be to sneak up into their camp and set fire on wood storage. It should take them a bunch of time to extinguish it and could possibly save some animals.", npc, creature)
		end
	end
	if table.contains({ "mission", "misja", "pomoc", "help" }, message) then
		if player:getStorageValue(Storage.SciezkaDruida.SezonNaJelenie) == 2 then
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) == 4 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Najpierw udaj sie do naszego swietego drzewa i pobierz buklak wody ze zrodla. ...",
					"Swiete drzewo znajduje sie w samym sercu dzungli.",
				} or {
					"Before that, you should go to our sacred sacred tree and take a sample of magic water from the spring. ...",
					"Our sacred tree is located in the heart of the jungle.",
				}, npc, creature)
			else
				if player:getLevel() >= 18 then
					player:setStorageValue(Storage.SciezkaDruida.SezonNaJelenie, 3) -- skonczona misja
					player:setStorageValue(Storage.SciezkaDruida.KragDruidow, player:getStorageValue(Storage.SciezkaDruida.KragDruidow) + 1) -- zwiekszamy licznik misji
					player:addItem(5907, 1) -- dostaje slingshota
					player:addItem(830, 1) -- dostaje terra hood
					--  Q5.1
					player:addExperience(30000, true) -- 30k expa
					player:getPosition():sendMagicEffect(CONST_ME_STUN)
					--  Q5.1
					npcHandler:say(getPlayerLanguage(player) == "PL" and {
						"Idealnie, teraz beda musieli na nowa zbierac drewno. Dziekuje ci w imieniu {druidow}, jesli zechcesz, to opowiem ci nieco o naszym cechu. ...",
						"Mozesz tez poplywac moja {lodka}, tylko uwazaj bo w poblizu znajduje sie wyspa z ktorej zaden rozbitek nie uszedl z zyciem.",
					} or {
						"Great, now they need to gather all the wood again. I thank you in the names of {druids}, if u will, now I can tell you about our way. ...",
						"You can also use my {boat}, but be careful, there's a island nearby estuary from which none of the survivors came back wtih life.",
					}, npc, creature)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 18 poziomu!" or "Come back when you reach 18 level!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			end
		elseif player:getStorageValue(Storage.SciezkaDruida.SezonNaJelenie) < 1 then
			npcHandler:setTopic(playerId, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Chcesz mi pomoc? Niedlugo zaczyna sie sezon polowania na jelenie. Te biedne stworzenia sa w niebezpieczenstwie, a mysliwi nie oszczedza zadnego. ...",
				"Wiem jednak, jak mozemy im choc odrobine pomoc. Moge na ciebie liczyc?",
			} or {
				"You want to help me? Soon the deer hunting season will start. Those poor animals are in danger! The poachers won't spare anyone. ...",
				"I know how we could help them a bit. So can I count on you?",
			}, npc, creature)
		end
	end
	if table.contains({ "druid", "druidzi", "druidow", "druids" }, message) and player:getStorageValue(Storage.SciezkaDruida.SezonNaJelenie) == 3 then
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

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|. Widac, ze dobra z ciebie dusza, zechcial bys mi {pomoc}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Niech natura bedzie z toba!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ruszaj z wiatrem...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. I can tell thay youre a good man. Would you like to {help} me?')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Let nature stay with you!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
