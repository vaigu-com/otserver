local internalNpcName = "Sand Nigger"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 146,
	lookHead = 78,
	lookBody = 132,
	lookLegs = 117,
	lookFeet = 117,
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

	-- ============= MISJA DRUID ADDON QUEST =================
	if table.contains({ "mission", "misja", "bug", "pomoc", "help" }, message) then
		if player:getStorageValue(Storage.SciezkaDruida.NaglaEksmisja) == 2 then
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) == 4 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Najpierw udaj sie do naszego swietego drzewa i pobierz buklak wody ze zrodla. ...",
					"Swiete drzewo znajduje sie w samym sercu dzungli.",
				} or {
					"Before that, you should go to our sacred sacred tree and take a sample of magic water from the spring. ...",
					"Our sacred tree is located in the heart of the jungle.",
				}, npc, creature)
			else
				player:setStorageValue(Storage.SciezkaDruida.NaglaEksmisja, 3) -- skonczona misja
				player:setStorageValue(Storage.SciezkaDruida.KragDruidow, player:getStorageValue(Storage.SciezkaDruida.KragDruidow) + 1) -- zwiekszamy licznik misji
				Game.createMonster("Undead Cavebear", player:getPosition()) -- spawnuje czasem undead Cavebear
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Czar dziala! Dzieki ci w imieniu {druidow}. Trzymaj w zamian ten oto amulet." or "The spell is working! In the name of {Druid} let me thank you and bestow this amulet on you.", npc, creature)
				-- Q5.1
				player:addExperience(50000, true) -- 50k expa
				-- Q5.1
				checkDruidsStatus(player) -- sprawdzenie ktory etap
				player:addItem(21439, 1) -- dostaje lion's heart amulet ( do mounta )
			end
		end
		if player:getStorageValue(Storage.SciezkaDruida.NaglaEksmisja) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Chcesz sie przysluzyc kregowi druidow? Jestem jednym z nich. Lecz wole pustynie od zielonych terenow. ...",
				"Jesli chcesz sie przysluzyc, to zakradnij sie do obozu na polnocy, niedaleko wyspy piratow. Mieszkalem tam kiedys, jednak najechali nas nomadzi i musialem osiedlic sie tutaj. ...",
				"Gdzies blisko brzegu zakopalem tam kartke z zakleciem przywolujacym Nieumarlego niedzwiedzia. ...",
				"Zapamietaj czar, i spal kartke jak najszybciej, na wszelki wypadek, gdyby mial cie ktos zlapac. ...",
				"Gdybys mial problem, to moze przydac ci sie {mapa}, przekaze ci ja jesli chcesz.",
			} or {
				"Do you want to serve the druids circle? I'm one of them but I prefer desert instead of green lands. ...",
				"If you want to serve us, sneak into the camp in the north, not far from pirates island. I was living there but nomads attacked us and I had to move here. ...",
				"Somewhere close to the shore I buried a note with spell for summoning undead bear. ...",
				"Remember the spell and burn down the note just in case someone catches you. ...",
				"If you will struggle you will probably need a {map}, I can give you one if you want.",
			}, npc, creature)
			player:setStorageValue(Storage.SciezkaDruida.NaglaEksmisja, 1) -- ustawienie questa
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) <= 0 then
				player:setStorageValue(Storage.SciezkaDruida.KragDruidow, 1)
			end
		end
	elseif table.contains({ "druid", "druidzi", "druidow", "druids" }, message) and player:getStorageValue(Storage.SciezkaDruida.NaglaEksmisja) == 3 then
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
	elseif table.contains({ "mapa", "map" }, message) then
		if player:getStorageValue(Storage.SciezkaDruida.NaglaEksmisja) >= 1 then
			if player:getItemCount(22107) < 1 then
				local item = player:addItem(22107, 1) -- dostaje mape
				if item then
					item:setActionId(11082)
				end
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Trzymaj mape, powinna ci pomoc." or "Get this map, it should help you.", cid)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Masz juz jedna mape!" or "You got one already!", cid)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie wiem o jaka mape ci chodzi." or "I dont know what are you talking about.", cid)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Salum |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Niech pustynia bedzie z toba!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Salam |PLAYERNAME|.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Let desert be with you!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, '...')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
