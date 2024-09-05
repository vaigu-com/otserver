local internalNpcName = "Estep"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 154,
	lookHead = 78,
	lookBody = 132,
	lookLegs = 117,
	lookFeet = 117,
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
		if player:getStorageValue(Storage.SciezkaDruida.PorwanyBenek) < 1 and npcHandler:getTopic(playerId) == 2 then
			player:setStorageValue(Storage.SciezkaDruida.PorwanyBenek, 1) -- poczatek benka
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) <= 0 then -- poczatek misji druidow
				player:setStorageValue(Storage.SciezkaDruida.KragDruidow, 1)
			end
			player:addItem(5908, 1) -- dostaje obsidian knife
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Trzymaj ten noz, na pewno ci sie przyda. Pewnie zwiazaly benka, a dzieki niemu zdolasz go uwolnic." or "Take this knife, surely you will need it. Benek is most likely strangled, use it to free him.", npc, creature)
		end
	end

	if table.contains({ "mission", "misja", "pomoc", "help" }, message) then
		if player:getStorageValue(Storage.SciezkaDruida.PorwanyBenek) == 2 then
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) == 4 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Najpierw udaj sie do naszego swietego drzewa i pobierz buklak wody ze zrodla. ...",
					"Swiete drzewo znajduje sie w samym sercu dzungli.",
				} or {
					"Before that, you should go to our sacred sacred tree and take a sample of magic water from the spring. ...",
					"Our sacred tree is located in the heart of the jungle.",
				}, npc, creature)
			else
				player:setStorageValue(Storage.SciezkaDruida.PorwanyBenek, 3) -- skonczona misja
				player:setStorageValue(Storage.SciezkaDruida.KragDruidow, player:getStorageValue(Storage.SciezkaDruida.KragDruidow) + 1) -- zwiekszamy licznik misji
				player:addExperience(50000, true) -- 50k expa
				player:addItem(3065, 1) -- daje terra rod
				player:getPosition():sendMagicEffect(CONST_ME_STUN)
				checkDruidsStatus(player)
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Dziekuje ci bardzo, byl taki wykonczony i ranny, gdyby nie ty, pewnie by zmarl. Na szczescie jako jeden z {druidow} mam doswiadczenie w opiecie nad zwierzetami. ...",
					"Zatrzymaj sobie ten noz, wez takze moja rozge w podziece! Matka Natura takze ci to wynagrodzi!",
				} or {
					"Thank you so much! If it weren't for you he would be dead for sure, look at how exhausted and injured he is. Luckily, as one of the druids, I have expertise in animal care. ...",
					"You can have the knife and take my wand as a token of my gratitude. Be blessed by the Mother Earth.",
				}, npc, creature)
			end
		end
		if player:getStorageValue(Storage.SciezkaDruida.PorwanyBenek) < 1 then
			npcHandler:setTopic(playerId, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "To bylo straszne... Te zielone stwory przyszly i pojmaly mojego {benka}." or "It was a nightmare.. Those green beasts came and stole my {benek}", npc, creature)
		end
	end
	if table.contains({ "benka", "benek" }, message) then
		if npcHandler:getTopic(playerId) == 1 and player:getStorageValue(Storage.SciezkaDruida.PorwanyBenek) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "To moj wilk, orki pojmaly go i gdzies ukryly, pomozesz mi go uratowac?" or "Thats my wolf. Orcs stole him and hid somewhere. Would you help me to rescue him?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.SciezkaDruida.PorwanyBenek) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "To moj wilk, orki pojmaly go i gdzies ukryly. Mam nadzieje, ze go uratujesz." or "Thats my wolf. Orcs stole him and hid somewhere. I hope that you will rescue him.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.SciezkaDruida.PorwanyBenek) == 2 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Zdolales mu {pomoc}?" or "Did you manage to {help} Benek?", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.SciezkaDruida.PorwanyBenek) == 3 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Jeszcze raz dzieki za uratowanie go." or "Thank you again for recuing my wolf.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
	if table.contains({ "druidow", "druids" }, message) and player:getStorageValue(Storage.SciezkaDruida.PorwanyBenek) >= 3 then
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

npcHandler:setMessage(MESSAGE_GREET, "Strzez sie |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Niech natura bedzie z toba!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ruszaj z wiatrem...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Let nature stay with you!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
