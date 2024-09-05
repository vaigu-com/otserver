local internalNpcName = "Lecter"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 367,
	lookHead = 78,
	lookBody = 132,
	lookLegs = 117,
	lookFeet = 117,
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
	-- ============= MILCZENIE OWIEC QUEST =================
	if table.contains({ "skory", "skin", "skins" }, message) and player:getStorageValue(Storage.MilczenieOwiec.ModneUbrania) == 1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebuje 20 skor z zielonego i czerwonego smoka, jaszczura, minotaura, orka i krokodyla." or "I need 20 of each green dragon leathers, red dragon leathers, lizard leathers, minotaur leathers, orc leather and crocodile leathers.", npc, creature)
	end
	if table.contains({ "mieso", "mission", "misja" }, message) then
		if player:getStorageValue(Storage.MilczenieOwiec.ProbaSily) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Uwielbiam ludzkie miesko. Moze mi sprzedasz swoja rodzinke na zupe?" or "I love human meat. Why don't you sell me your family for some soup?", npc, creature)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Albo chcesz zostac moim asystentem?" or "Or maybe would you like to be my assistant?", npc, creature)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Niewazne, pierw musisz udowodnic, ze jestes godzien. Wtedy dam ci moje stare narzedzie, ktore uzywalem zanim zasmakowalo mi ludzkie miesko." or "Nevermind, firstly you need to prove you are worthy. Then I will give you my old tool which I used to use before I have enjoyed human meat.", npc, creature)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Przynies mi prosze 5 wampirzych zebow, bardzo dobre z nich igly sie robi." or "Bring me 5 vampire teeth please, they are very good for making needles.", npc, creature)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Lec juz, bo zaraz sie na ciebie rzuce!" or "Go now, otherwise I will get you.", npc, creature)
			player:setStorageValue(Storage.MilczenieOwiec.ProbaSily, 1) -- zaczynamy klesta i misje 1
			npcHandler:setTopic(playerId, 1)
		end
		if player:getStorageValue(Storage.MilczenieOwiec.ProbaSily) == 2 and player:getStorageValue(Storage.MilczenieOwiec.ModneUbrania) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "A wiec znow chcesz mi pomoc? Sluchaj, ostatnio oddalem sie szyciu, jednak sama ludzka skora nie wystarcza." or "So you want to help me again ? Listen, recently I've been sewing little bit, but human skin itself its not enough.", npc, creature)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebuje zatem jakis innych kolorow i materialow. Przynies mi prosze po 20 z kazdego rodzaju {skory} jaka znajdziesz." or "I will need some different colours and materials. Bring me 20 pieces of {skin} of each type.", npc, creature)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Jak to zrobisz, naucze cie wszystkiego o skorowaniu." or "If you do that I will teach you everything about skinning.", npc, creature)
			player:setStorageValue(Storage.MilczenieOwiec.ModneUbrania, 1) -- zaczynamy misje 2
			npcHandler:setTopic(playerId, 1)
		end
		if player:getStorageValue(Storage.MilczenieOwiec.ProbaSily) == 1 and npcHandler:getTopic(playerId) < 1 then
			if player:getItemCount(9685) > 4 then
				if player:getLevel() >= 15 then
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Super sie spisales, na pewno dobrze wykorzystasz to narzedzie!" or "You dide very well, you will use these tools properly for sure.", npc, creature)
					player:removeItem(9685, 5) -- zabieramy 5 zebow wampirow
					player:addItem(5942, 1) -- dostaje wooden stejka
					-- Q5.1
					player:addExperience(30000, true) -- 30k expa
					player:getPosition():sendMagicEffect(CONST_ME_STUN)
					-- Q5.1
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc do mnie jak bedziesz chcial poznac prawdziwy smak!" or "Come back to me when you will want to know the real taste.", npc, creature)
					player:setStorageValue(Storage.MilczenieOwiec.ProbaSily, 2) -- konczymy ta czesc questa
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 15 poziomu!" or "Come back when you reach 15 level!", npc, creature)
				end
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "No i po co mi przychodzisz bez zebow wampirow? Mam ci twoje zabrac?" or "Why are you coming back without vampire teeth? Should I take yours instead?", npc, creature)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc jak tylko wykazesz, ze jestes godny uzywania tego narzedzia." or "Come back when you will prove that you are worthy of using this tool.", npc, creature)
			end
		end
		if player:getStorageValue(Storage.MilczenieOwiec.ModneUbrania) == 1 and npcHandler:getTopic(playerId) < 1 then
			if
				player:getItemCount(5876) > 19 -- lizard
				and player:getItemCount(5877) > 19 -- green dragon
				and player:getItemCount(5878) > 19 -- minotaur
				and player:getItemCount(5948) > 19 -- red dragon
				and player:getItemCount(10279) > 19 -- crocodile leather
				and player:getItemCount(11479) > 19 -- orc leather
			then
				player:removeItem(5876, 20)
				player:removeItem(5877, 20)
				player:removeItem(5878, 20)
				player:removeItem(5948, 20)
				player:removeItem(10279, 20)
				player:removeItem(11479, 20)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Ooooo, ale bede miec teraz asortyment, moze uszyje cos wzamian dla ciebie." or "Ohh, now I have proper assortment, maybe I will sew something for you.", npc, creature)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Apropo skorowania, to poradziles sobie miernie.. Pewnie tez nigdy wczesniej nie skorowales ludzi." or "About skinning, it didn't go very well. Probably you wasn't skinning humans before.", npc, creature)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Pamietaj, zeby zaczynac nacinanie pod pacha i ciagnac w dol." or "Remember, you must start cutting from armpit and cut it down.", npc, creature)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Skoro juz wiesz jak skorowac ludzi, to idz pocwiczyc. Jak chcesz jeszcze cos, to zglos sie do mnie po inne zadanie." or "So if you know now how to skinning people, go and train a little bit. If you want anything else just come back to me for different task.", npc, creature)
				player:setStorageValue(Storage.MilczenieOwiec.ModneUbrania, 2) -- koniec klesta -- to daje przepustke do skorowania ludzi
				-- Q5.1
				player:addExperience(150000, true) -- 150k expa
				player:getPosition():sendMagicEffect(CONST_ME_STUN)
				npcHandler:setTopic(playerId, 1)
				-- Q5.1
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz wszystkich skor. Potrzebuje 20 skor z zielonego i czerwonego smoka, jaszczura, minotaura, orka i krokodyla." or "You don't have all of the skins. I need 20 skins from green and red dragon, lizard, minotaur, orc and crocodile.", npc, creature)
			end
		end
		if player:getStorageValue(Storage.MilczenieOwiec.ModneUbrania) == 2 and player:getStorageValue(Storage.MilczenieOwiec.GotujZLecterem) < 1 and npcHandler:getTopic(playerId) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Aaa tak, cos do roboty? Wybieram sie na coroczne zebranie Kanibali i musze przygotowac jakies jedzonka, zeby nie pokazywac sie z pustymi rekami." or "Ahh yes, something to do? I'm going for annual meeting for cannibals and I need to prepare some meals, so I won't be empty handed.", npc, creature)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Skoro znasz juz tajna sztuke skorowania ludzi, to pomozesz mi zebrac skladniki. Zbierz dla mnie 15 serc i 20 watrob ludzkich." or "So If you know secret skinning techniques already you can help me to gather ingredients, Bring me 15 human hearts and 20 human livers.", npc, creature)
			player:setStorageValue(Storage.MilczenieOwiec.GotujZLecterem, 1) -- zaczynamy questa
			player:setStorageValue(Storage.MilczenieOwiec.LudzkieSerca, 0) -- 0 serc
			player:setStorageValue(Storage.MilczenieOwiec.LudzkieWatroby, 0) -- 0 watrob
		end
		if player:getStorageValue(Storage.MilczenieOwiec.GotujZLecterem) == 1 then
			if player:getStorageValue(Storage.MilczenieOwiec.LudzkieSerca) > 14 and player:getStorageValue(Storage.MilczenieOwiec.LudzkieWatroby) > 19 then
				if player:getLevel() >= 50 then
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Musisz bardziej uwazac wyciagajac je, bo niektore niezle pogniecione." or "You need to be more careful, some of them are really creased..", npc, creature)
					npcHandler:say(
						getPlayerLanguage(player) == "PL" and "Uuu, ta jedna watraba to niezle zapita. Dobra, mimo wszystko zapraszam cie do klubu kanibali. Trzymaj swoje wdzianko! Wez jeszcze moja kamizelke w podzice, bo mi sie juz nie przydaje."
							or "Uuu, that one liver probably belongs to an alcoholic. Despite that I'm inviting you to cannibals club. Take this uniform! Take also my vest in gratitude, I'm not using it anymore.",
						npc,
						creature
					)
					npcHandler:say(getPlayerLanguage(player) == "PL" and "I pamietaj, tylko ja jestem taki towarzyski dla obcych.. Inni kanibale nie beda z toba rozmawiac, jesli nie zauwaza, ze jestes jednym z nas." or "And remember, only I am that friend for strangers.. Other cannibals won't be talking with you if they will notice that you are not one of us.", npc, creature)
					player:addOutfitAddon(366, 0) -- wayfarer outfit
					player:addOutfitAddon(367, 0) -- wayfarer outfit
					player:setStorageValue(Storage.MilczenieOwiec.GotujZLecterem, 2) -- koniec questa
					player:setStorageValue(Storage.Finished.MilczenieOwiec, 1) -- quest done (website)
					player:addItem(17829, 1) -- daje buckle
					player:addExperience(500000, true) -- 500k expa
					player:getPosition():sendMagicEffect(CONST_ME_STUN)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 50 poziomu!" or "Come back when you reach 50 level!", npc, creature)
				end
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc jak zdobedziesz dla mnie serca i watroby." or "Come back when you get hearts and livers for me.", npc, creature)
			end
		end
	end
	-- ============= MILCZENIE OWIEC QUEST =================
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "tsssss!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "tsssss!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'tsssss!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'tsssss!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
