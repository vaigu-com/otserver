local internalNpcName = "Ariel"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 63,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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

local config = nil
local lang_to_config = {
	["PL"] = {
		[1] = {
			"Ah tak, obiecalem ci opowiedziec swoja historie. Otoz pochodze z legendarnego miasta Yalahar, ktore znajdowalo sie na wyspie. Jednak wladcy tego miasta byli zbyt chciwi i w koncu wszystkie nasze dzielnice sie zbuntowaly. Doszlo do wielkiej bitwy, ktora zostala zakonczona wybuchem bomby skonstruowanej przez szalonego alchemika. ...",
			"Ja przezylem, poniewaz wyplynalem stamtad gdy tylko wybuchly zamieszki, niestety cala moja rodzina zginela. Oprocz mnie ucieklo jeszcze kilku mieszkancow. Na poczatku trzymalismy sie razem, lecz ostatecznie sie rozdzielilismy. Ostatni raz widzialem {Gertrude} w dzungli. {Konmuld} natomiast poszedl zla droga, i postanowil oddac sie czarnej magii. Pozostalych ocalalych nie znalem, ale moze Gertruda lub Konmuld beda wiedziec gdzie sa. ...",
			"Nie wiem natomiast, czy beda chcieli z toba rozmawiac, Yalaharianie sa bardzo nieufni do obcych, jednak moge ci wyjawic nasze powitanie, ktorym na pewno zdobedziesz ich zaufanie. Lecz najpierw pomoz mi prosze zdobyc serce mojej ukochanej, zrobisz to dla mnie?",
		},
		[2] = {
			"Zgodzila sie? Jak tego dokonaliscie? Zreszta to juz teraz nie wazne, dziekuje ci z calego serca. Prosze, przyjmij ten skromny podarunek, oraz zgodnie z obietnica podaje ci nasze tajne haslo: Aloha. ...",
			"Wroc jeszcze do mnie kiedys z wizyta.",
		},
	},
	["EN"] = {
		[1] = {
			"Oh, yes. I promised you to tell my story. Well, I come from the legendary town of Yalahar, which was located on an island. However, the rulers of this town were too greedy and eventually all of our districts rebelled. There was a huge battle that was topped off by an enormous explosion of the bomb invented by the crazy alchemist. ...",
			"I survived because I left there as soon as the riots broke out, unfortunately all my family died. Besides me, a few more inhabitants fled. At first we stuck together, but eventually broke up. Last time I saw {Gertruda} in the jungle. {Konmuld} on the other hand, he went the wrong way, and decided to devote himself to black magic. I did not know the other survivors, but maybe Gertrude or Konmuld will know where they are. ...",
			"However, I don't know if they will want to talk to you, Yalaharians are very distrustful of strangers, but I can reveal to you our greeting with which you will surely gain their trust. But first, please help me win my love's heart, will you do it for me?",
		},
		[2] = {
			"She agreed? How did you do that? Well, that doesn't matter now, thank you from the bottom of my heart. Here is small gift for you, and as I promissed, our secrest password: Aloha. ...",
			"I hope that you'll visit me someday.",
		},
	},
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	config = GetConfigByPlayer(creature, lang_to_config)

	if table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 1 and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) == 1 then
		player:setStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela, 2)
		player:setStorageValue(Storage.PrzyjacielAriela.Blossoms, 2)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Bede ci bardzo wdzieczny i opowiem ci pewna {historie} jak mnie poprosisz! Jego grob znajduje sie na pobliskim wzgorzu." or "I would be very grateful and tell you a {story} if you ask. His grave is located on the hill nearby.", npc, creature)
	end

	if table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 1 and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) < 1 then
		player:setStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela, 1)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Ulubionym kwiatem mojego przyjaciela byl {heaven blossom}. Przynies mi prosze jedna sztuke." or "My friend's favorite flower was {heaven blossom}. Please, bring me one.", npc, creature)
		npcHandler:setTopic(playerId, 1)
	end
	if table.contains({ "mission", "misja" }, message) and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) == 3 then
		if player:getLevel() >= 18 then
			player:setStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela, 4)
			player:setStorageValue(Storage.PrzyjacielAriela.Finished, 1) -- quest done (website)
			player:addItem(7438, 1) -- dostaje Elvish Bow
			player:addItem(3061, 1) -- dostaje life crystal
			player:addItem(3048, 20) -- dostaje might ring
			player:addItem(3728, 5) -- dostaje dark mushroom
			player:addExperience(35000, true) -- 35k expa
			player:getPosition():sendMagicEffect(CONST_ME_STUN)
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "Az tutaj poczulem ten przyplyw pozytywnej energii, a kwiaty zaczely spiewac z radosci, dziekuje ci za pomoc, przyjacielu. Oto twoja nagroda. Jesli chcesz, moge ci opowiedziec moja {historie}."
					or "Wow! I can feel the flow of positive energy. Even the flowers started to sing from happiness. Thank you for your help, my friend. Here, keep your reward. I can tell you my {story}, if you want.",
				npc,
				creature
			)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 18 poziomu!" or "Come back when you reach 18 lvl", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end

	if MsgContains(message, "heaven blossom") and player:getStorageValue(Storage.PrzyjacielAriela.Blossoms) == 1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Sa sliczne, jeszcze przed zlozeniem musze je poswiecic. Zrobisz dla mnie jeszcze jedna przysluge, i zaniesiesz je na grob mojego przyjaciela?" or "They are gorgeous. I need to bless them before putting them on a grave. Would you make me one more favour and put them on my friend's grave?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	end
	if table.contains({ "heaven blossom", "misja" }, message) and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) == 1 then
		if player:getStorageValue(Storage.PrzyjacielAriela.Blossoms) <= 0 then
			if player:getItemCount(5921) > 0 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Sa sliczne, jeszcze przed zlozeniem musze je poswiecic. Zrobisz dla mnie jeszcze jedna przysluge, i zaniesiesz je na grob mojego przyjaciela?" or "They are gorgeous. I need to bless them before putting them on a grave. Would you make me one more favour and put them on my friend's grave?", npc, creature)
				player:setStorageValue(Storage.PrzyjacielAriela.Blossoms, 1)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz zadnego przy sobie. Elfy czesto nosza jakies przy sobie. Jak nie beda chcialy oddac po dobroci, no to wiesz.." or "You dont have any. Elves often carry them. Should they not give you that voluntarily, then.. you know what to do..", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	if table.contains({ "missison", "misja", "pomoc", "help" }, message) and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) < 1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Od tygodnia mialem isc zerwac ulubione kwiaty przyjaciela i zlozyc na jego grobie, ale nie moge znalezc czasu. Pomozesz mi?" or "I've wanted to pick my friend's favourite flowers to put them on his grave for a week now, but I am too busy. Would you help me?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	end

	-- =========== KONIEC CZESCI QUESTA "POMOC ARIELA" =============
	-- ========== TU ZACZYNA SIE CZEsC DO 1 MISJI YALAHARI QUESTA ============
	if table.contains({ "historia", "historie", "story" }, message) and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) <= 3 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Najpierw zrob to, o co cie poprosilem." or "Do what I asked for first.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
	if table.contains({ "gertruda", "gertrude" }, message) and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) >= 4 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Zamieszkala w poblizu wioski jaszczurow. Jednak nie wchodza sobie w droge." or "She moved near the lizards' village. They stay out of each other's way though.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
	if (MsgContains(message, "konmuld")) and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) >= 4 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Zaszyl sie w opustoszalej wiosce na stepie. Raczej nikt go tam nie odwiedza.." or "He holed up in an abandoned village on steppes. I don't think anyone visits him there.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
	if table.contains({ "historia", "historie", "story" }, message) and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) == 4 then
		npcHandler:say(config[1], npc, creature)
		npcHandler:setTopic(playerId, 1)
	end
	if table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 1 and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) == 4 then
		if player:getStorageValue(Storage.Yalahar.MiloscAriela) <= 0 then
			player:setStorageValue(Storage.Yalahar.MiloscAriela, 1) -- zaczynamy nowe id do questa
			player:AddCustomItem({ id = 4846, addToStore = true }) 
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "Wiedzialem, ze moge liczyc na twoja pomoc, ma na imie Madame Malkin, zajmuje sie sprzedaza oraz skupem tkanin. Przekaz prosze jej to zaproszenie na impreze i wroc do mnie z odpowiedzia."
					or "I knew, that I can rely on you. Her name is Madame Malkin, she deals with clothes and fabrics. Please, bring her this invitation and visit me back with the answer.",
				npc,
				creature
			)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Mam nadzieje, ze Madame sie zgodzi." or "I hope that Madame will be down for that.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	end
	if table.contains({ "zaproszenie", "madame", "malkin" }, message) and player:getStorageValue(Storage.Yalahar.MiloscAriela) == 2 then
		player:setStorageValue(Storage.Yalahar.MiloscAriela, 3)
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Spodziewalem sie tego, ze nie bedzie chciala isc. Musze ja jakos do tego przekonac, ale brakuje mi pomyslow. Udaj sie prosze do mojego znajomego Old Postmana, on zawsze ma jakies dobre pomysly."
				or "I expected that she wouldn't want to go.. I have to convince her in some other way, but I'm out of ideas. Please, visit my friend Old Postman, he's really wise and always have some good ideas.",
			npc,
			creature
		)
	end
	if table.contains({ "zaproszenie", "madame", "malkin" }, message) and player:getStorageValue(Storage.Yalahar.MiloscAriela) == 8 then
		player:setStorageValue(Storage.Yalahar.MiloscAriela, 9)
		npcHandler:say(config[2], npc, creature)
		player:addItem(5922, 5) -- dostaje Holy Orchid
		player:addItem(3082, 50) -- dostaje elven amulet
		player:addExperience(80000, true) -- 80k expa
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|. Coz za piekny dzien.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Milego dnia ci zycze!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ruszaj z wiatrem...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. What a beautiful day.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Have a nice day!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you...')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
