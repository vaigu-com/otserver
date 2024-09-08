local internalNpcName = "Mundral"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 144,
	lookHead = 120,
	lookBody = 77,
	lookLegs = 114,
	lookFeet = 121,
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
	-- ============= DRUID ADDON QUEST =================
	if table.contains({ "mission", "misja", "pomoc", "lekarstwo" }, message) then
		if player:getStorageValue(Storage.SciezkaDruida.TajnySkladnik) == 1 then
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) == 4 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Najpierw udaj sie do naszego swietego drzewa i pobierz buklak wody ze zrodla. ...",
					"Swiete drzewo znajduje sie w samym sercu dzungli.",
				} or {
					"Before that, you should go to our sacred sacred tree and take a sample of magic water from the spring. ...",
					"Our sacred tree is located in the heart of the jungle.",
				}, npc, creature)
			else
				if player:getItemCount(8819) > 0 then
					if player:getStorageValue(Storage.SciezkaDruida.LekarstwoOdOrnulda) == 3 then
						player:setStorageValue(Storage.SciezkaDruida.TajnySkladnik, 2) -- koniec questa
						player:removeItem(8819, 1) -- zabiera itemek
						player:addItem(12549, 1) -- bamboo leaves
						player:setStorageValue(Storage.SciezkaDruida.KragDruidow, player:getStorageValue(Storage.SciezkaDruida.KragDruidow) + 1) -- zwiekszamy licznik misji
						player:addExperience(50000, true) -- 50k expa
						player:getPosition():sendMagicEffect(CONST_ME_STUN)
						npcHandler:say(getPlayerLanguage(player) == "PL" and "Dziekuje ci z calego serca, w koncu moj Leon wyzdrowieje. Jako jeden z {druidow} dziekuje ci takze w imieniu Lasu." or "Thank you from the bottom of my heart. My Leon finally will cure up. As one of the {druids} I thank you also of behalf of the forest.", npc, creature)
						checkDruidsStatus(player)
					else
						npcHandler:say(getPlayerLanguage(player) == "PL" and "Zdobadz prawdziwe lekarstwo, a nie jakas podrobe." or "Thats some fake one.", npc, creature)
					end
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Jeszcze nie zdobyles lekarstwa? Poczekam wiec.." or "You still didnt get this cure? Well I'll wait then..", npc, creature)
				end
			end
		elseif player:getStorageValue(Storage.SciezkaDruida.TajnySkladnik) < 1 then
			npcHandler:setTopic(playerId, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Przychodzisz, zeby mi pomoc, naprawde? ...",
				"W takim razie jest jedna rzecz, ktora mozesz dla mnie zrobic. Ostatnio jedno z moich zwierzat zachorowalo. ...",
				"A jedyne lekarstwo jakie mu pomoze posiada Ornuld, ale nie za bardzo mnie lubi, woli patrzec jak niewinne zwierze umiera.. ...",
				"Moze tobie sie uda od niego zdobyc ten tajny srodek, tylko nie mow, ze ja cie przyslalem. Znajdziesz go w zachodniej czesci dzungli, ma tam swoj maly oboz.",
			} or {
				"Are you coming over to help me? ...",
				"Then there is one thing you can do for me. Recently one of my animals got really sick. ...",
				"And the only medicine I know that could help him, is what Ornuld developed. But he doesn't want to help me, seems like he wamt to see this innocent animal die. ...",
				"Maybe you can get this from him, just don't say that I sent you. You can find him in the western part of the jungle, he has his little camp there.",
			}, npc, creature)
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) <= 0 then
				player:setStorageValue(Storage.SciezkaDruida.KragDruidow, 1)
			end
			player:setStorageValue(Storage.SciezkaDruida.TajnySkladnik, 1) -- zaczynamy questa
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

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Niech natura bedzie z toba!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ruszaj z wiatrem...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Let nature stay with you!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
