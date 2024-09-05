local internalNpcName = "Hairycles"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 117,
	lookHead = 10,
	lookBody = 20,
	lookLegs = 30,
	lookFeet = 40,
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

local function greetCallback(npc, creature)
	local playerId = creature:getId()
	if player then
		if player:getStorageValue(Storage.TheApeCity.Started) < 12 then
			if getPlayerLanguage(player) == "PL" then
				npcHandler:setMessage(MESSAGE_GREET, "Oh! Witam, witam! Nie zauwazylem cie! Bardzo {zajety}.")
			else
				npcHandler:setMessage(MESSAGE_GREET, "Oh! Hello! Hello! Did not notice! So {busy}.")
			end
		else
			if getPlayerLanguage(player) == "PL" then
				npcHandler:setMessage(MESSAGE_GREET, "Witaj, malpi przyjacielu. Spytaj mnie o {trade}, jesli chcesz pohandlowac. Jak cos ci dolega, popros o uzdrowienie.")
			else
				npcHandler:setMessage(MESSAGE_GREET, "Be greeted, friend of the ape people. If you want to {trade}, just ask for my offers. If you are injured, ask for healing.")
			end
		end
	end
	return true
end

local function releasePlayer(npc, creature)
	if not Player(creature) then
		return
	end

	npcHandler:removeInteraction(npc, creature)
	npcHandler:resetNpc(creature)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local questProgress = player:getStorageValue(Storage.TheApeCity.QuestProgress)
	if table.contains({ "mission", "misja", "missions" }, message) then
		if questProgress < 1 then
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "Nastaly ciezkie czasy dla naszych pobratyncow odkad ciapatym znudzily sie kozy. Problem to duzy zwazajac na historie. Ale my tak latwo sie nie damy. Czy chcesz udowodnic, ze jestes przyjacielem malp?"
					or "These are dire times for our people. Problems plenty are in this times. But me people not grant trust easy. Are you willing to prove you friend of ape people?",
				npc,
				creature
			)
			npcHandler:setTopic(playerId, 1)
		elseif questProgress == 1 then
			if player:getStorageValue(Storage.TheApeCity.WhisperMoss) == 1 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Oh, przyniosles mi whisper moss? Dobra bezwlosia malpa z ciebie! Dasz mi je?" or "Oh, you brought me whisper moss? Good hairless ape you are! Can me take it?", npc, creature)
				npcHandler:setTopic(playerId, 3)
			else
				npcHandler:say(
					getPlayerLanguage(player) == "PL" and "Szybko prosze. Przynies mi whisper moss z dziurki Dworcow. Jesli mam Ci opowiedziec historie ponownie to cie strzele, ale opowiem. Spytaj Hairyclesa o {historia}."
						or "Please hurry. Bring me whisper moss from dworc lair. Make sure it is from dworc lair! Take it yourself only! If you need to hear background of all again, ask Hairycles for {background}.",
					npc,
					creature
				)
			end
		elseif questProgress == 2 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Whisper moss silny jest, ale potrzebujemy plynu od ludzi, wtedy uda nam sie ...",
				"Nasi grabiezcy raz przyniesli to z najazdow. Nazywaja go syropem. Spytaj o to magow w miescie na koncu dzungli.",
			} or {
				"Whisper moss strong is, but me need liquid that humans have to make it work ...",
				"Our raiders brought it from human settlement, it's called cough syrup. Go ask healer there for it.",
			}, npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 3)
		elseif questProgress == 3 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Przyniosles mi ten syrop na kaszel od ludzi, o ktory cie prosilem?" or "You brought me that cough syrup from human healer me asked for?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif questProgress == 4 then
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "Nasze malenstwo byc zdrowe wkrotce. Jestem taki szczesliwy. Dziekuje ponownie! Ale zle chmury nadciagaja. Czuje to w bananach. Zupelnie inny smak. Pomozesz mi upewnic sie w przeczuciu?" or "Little ape should be healthy soon. Me so happy is. Thank you again! But me suspect we in more trouble than we thought. Will you help us again?",
				npc,
				creature
			)
			npcHandler:setTopic(playerId, 5)
		elseif questProgress == 5 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Masz papier z wioski lizardow?" or "You got scroll from lizard village in south east?", npc, creature)
			npcHandler:setTopic(playerId, 7)
		elseif questProgress == 6 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Ah tak, pergamin. Smutno mi, ale nie moge go przeczytac. Ale swiety banan dal mi znak! W snach Hairycles zobaczyl rozwiazanie. ...",
				"Ja widzialem szpiczasty kamien z jezykiem Lizardow i z jezykiem ludzi, ktory znam. Gdybys odnalazl ten kamien, zapamietal znaki dla Hairyclesa, wtedy bede wiedzial jak go odczytac. ...",
				"Idz na poludnie na wielka pustynie. Na pustyni jest miasto. Na polnocnym zachodzie ukryty grobowiec na oazie jest. Wez lopate ze soba. ...",
				"Wchodz do kazdej komnaty i nie boj pulapek zastawionych tam i zablakanych dusz. Znajdziesz sciane wymalowana miedzy dwoma duzymi czerwonymi skalami. ...",
				"Przeczytaj to i wroc. Jestes gotowy na wyzwanie?",
			} or {
				"Ah yes that scroll. Sadly me not could read it yet. But the holy banana me insight gave! In dreams Hairycles saw where to find solution. ...",
				"Me saw a stone with lizard signs and other signs at once. If you read signs and tell Hairycles, me will know how to read signs. ...",
				"You go to big desert. In desert there city. North west of city under sand hidden tomb is. You will have to dig until you find it, so take shovel. ...",
				"Go down in tomb. There you find a wall with signs. ...",
				"Read it and return to me. Are you up to that challenge?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 8)
		elseif questProgress == 7 then
			if player:getStorageValue(Storage.TheApeCity.TombWall) == 1 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Ah tak, przeczytales znaki w grobowcu? Dobrze! Pozwolisz, ze spojrze w twoj umysl i dowiem sie co przeczytales?" or "Ah yes, you read the signs in tomb? Good! May me look into your mind to see what you saw?", npc, creature)
				npcHandler:setTopic(playerId, 9)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Dalej nie znasz znakow z kamienia w moim snie, idz i poszukaj w grobowcu pod oaza." or "You still don't know signs on stone, go and look for it in tomb east in desert.'", npc, creature)
			end
		elseif questProgress == 8 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Jeszcze duzo pracy przed Hairyclesem do utworzeniu amuletu, ktory ochroni moj lud. ...",
				"Mozesz wspomoc nas. Do stworzenia amuletu zycia mozemy potrzebowac tokenu zycia! Najlepsze bedzie jajko regeneracji potwora zwanego hydra. ...",
				"Przynies mi jajo hydry. Myslisz, ze dasz rade?",
			} or {
				"So much there is to do for Hairycles to prepare charm that will protect all ape people. ...",
				"You can help more. To create charm of life me need mighty token of life! Best is egg of a regenerating beast as a hydra is. ...",
				"Bring me egg of hydra please. You think you can do?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 10)
		elseif questProgress == 9 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Przyniosles mi jajo Hydry?" or "You bring Hairycles egg of hydra?", npc, creature)
			npcHandler:setTopic(playerId, 11)
		elseif questProgress == 10 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Ostatnim skladnikiem jest przyciagacz magii. Jedyna znana mi taka rzecza jest grzyb zwany witches' cap. ...",
				"Jedynie wiem ze grzyby te rosna z odchodow Bone Lordow. Tam gdzie one, tam witches' cap. Odwazny wojowniku, pomozesz mi i mojemu ludowi?",
			} or {
				"Last ingredient for charm of life is thing to lure magic. Only thing me know like that is mushroom called witches' cap. ...",
				"Those mushrooms grow on bone lord excrements. You will find them where bone lords are. Are you willing to go there for good ape people?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 12)
		elseif questProgress == 11 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Przyniosles Hairyclesowi witches' cap?" or "You brought Hairycles witches' cap?", npc, creature)
			npcHandler:setTopic(playerId, 13)
		elseif questProgress == 12 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Potezny amulet zycia nas chorni! Ale moim malpom dalej grozi smierc. Smierc od srodka. ...",
				"Niektore malpy przez udzial klatwy poddaly sie kultowi lizardow. Zostali wykorzystani do tego, aby ich potezni magowie mogli przedrzec sie do wioski i zaczac odprawiac rytualy przyzwania. ...",
				"Pod nasza wioska znajduje sie dawna swiatynia Lizardow. Nie tylko my jestesmy jej mieszkancami, ale rowniez mistyczne stwory. Jeszcze za malo informacji zdobylem, ale moi zwiadowcy zauwazyli dziwne zachowania malp po zachodniej stronie wioski. ...",
				"Jesli znajdziesz ich krag to sprobuj przerwac ta czarna magie. Hairycles mysli, ze Jaszczury otworzyly jakas zla brame i stad te mityczne potwory. Moze to podpucha piekiel? Glupie dinozaury, jesli otworza brame na powierzchni, wszyscy zginiemy! Przeszkodzisz im w imie ludzkosci?",
			} or {
				"Mighty life charm is protecting us now! But my people are still in danger. Danger from within. ...",
				"Some of my people try to mimic lizards to become strong. My apes try some black magic to become lizard. ...",
				"West of this village there some campfire. Try interrupt what those apes do. Are you willing to do that?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 14)
		elseif questProgress == 13 then
			if player:getStorageValue(Storage.TheApeCity.CampfireMission) == 2 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Ratujesz nasza sytuacje, przyjacielu. Mam nadzieje, ze szalenstwo jeszcze nie rozprzestrzeni sie. Pewnie jest gotowy na kolejna misje." or "You do please Hairycles again, friend. Me hope madness will not spread further now. Perhaps you are ready for other mission.", npc, creature)
				player:setStorageValue(Storage.TheApeCity.QuestProgress, 14)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze, przeszkodz im jakos w tych rytualach. Ja tam niczego szczegolnego nie widzialem." or "Please destroy their mystical campfire, so my people will come to senses again.", npc, creature)
			end
		elseif questProgress == 14 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Teraz kiedy kult zostal zatrzymany musimy wzmocnic ducha moich braci. Potrzebujemy symbolu wiary, ktory malpy beda mogly zobaczyc i dotknac. ...",
				"Istnieje pewna grota gigantow na poludniu. Jestesmy dziecmi prastarego giganta wielkiego jak gora. Malo o nich wiemy, ale gdybysmy zdobyli jakas czesc wlosia. ...",
				"Moze stawilbys czola lekom i sprobowal znalezc cos w ich legowiskach. Jesli maja taka sama bitna nature jak nasza, to powinienes znalezc cos w krzakach tam rosnacych. ...",
				"Przynies mi wlosie wielkiej swietej malpy. Zrobisz to dla Hairyclesa?",
			} or {
				"Now that the false cult was stopped, we need to strengthen the spirit of my people. We need a symbol of our faith that ape people can see and touch. ...",
				"In west jungle there some behemoth cave. They in fact primeval apes are. Try enter and look for a hair of giant ape. ...",
				"You might find at places they sleep, also they like rub on ferns. ...",
				"Return a hair of the giant ape to me. Will you do this for Hairycles?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 15)
		elseif questProgress == 15 then
			if player:getStorageValue(Storage.TheApeCity.HolyApeHair) == 1 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Przyniosles wlos swietej malpy?" or "You brought hair of holy ape?", npc, creature)
				npcHandler:setTopic(playerId, 16)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Zdobadz wlos swietej malpy giganta z groty na poludniu." or "Find a hair of holy ape in behemoth lair..", npc, creature)
			end
		elseif questProgress == 16 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Udowodniles, ze jestes przyjacielem. Dostajesz ode mnie zezwolenie na wejscie do glebszych poziomow katakumb swiatyni lizardow. ...",
				"Dalej moge wyczuc zlo, ktore tam sie czai. My nie odwazylismy sie tam wejsc i walczyc z demonami. ...",
				"Moze poszedlbys tam, przedarl sie przez zle istoty, odnalazl posag boga jaszczurow i zniszczyl mlotkiem, ktory ci dam. ...",
				"Tylko w ten sposob zapewnie moich ludziom pokoj i bezpieczenstwo. Prosze, posluchaj Hairyclesa, pojdziesz tam?",
			} or {
				"You have proven yourself a friend, me will grant you permission to enter the deepest catacombs under Banuta which we have sealed in the past. ...",
				"Me still can sense the evil presence there. We did not dare to go deeper and fight creatures of evil there. ...",
				"You may go there, fight the evil and find the monument of the serpent god and destroy it with hammer me give to you. ...",
				"Only then my people will be safe. Please tell Hairycles, will you go there?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 17)
		elseif questProgress == 17 then
			if player:getStorageValue(Storage.TheApeCity.SnakeDestroyer) == 1 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"W koncu moj lud jest bezpieczny! Uczyniliscie niewiarygodne dobro dla nas i pewnego dnia nawet moi bracia dostrzega to. ...",
					"Chcialbym mowic za wszystkich, kiedy nazywam cie swoich przyjacielem, ale moi ludzie potrzebuja czasu na przyzwyczajenie sie do zmian. ...",
					"Miejmy nadzieje, ze pewnego dnia cala wioska powita Cie jako przyjaciela. Moze chcesz sprawdzic oferty dla specjalnych przyjaciol, albo pouczyc sie szamanskich mocy?",
				} or {
					"Finally my people are safe! You have done incredible good for ape people and one day even me brethren will recognise that. ...",
					"I wish I could speak for all when me call you true friend but my people need time to get accustomed to change. ...",
					"Let us hope one day whole Banuta will greet you as a friend. Perhaps you want to check me offers for special friends... or shamanic powers.",
				}, npc, creature)
				player:setStorageValue(Storage.TheApeCity.QuestProgress, 18)
				player:setStorageValue(Storage.Finished.MiastoMalp, 1) -- quest done (website)
				player:addItem(3002, 1)
				player:addAchievement("Friend of the Apes")
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Ja wiem, ze o wiele prosze, ale wejdz tam w podziemia i zniszcz pomnik boga wezy." or "Me know its much me asked for but go into the deepest catacombs under Banuta and destroy the monument of the serpent god.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie mam wiecej misji dla ciebie. Moze chcesz sprawdzic oferty dla specjalnych przyjaciol, albo pouczyc sie szamanskich mocy?" or "No more missions await you right now, friend. Perhaps you want to check me offers for special friends... or shamanic powers.", npc, creature)
		end
	elseif MsgContains(message, "historia") or MsgContains(message, "background") then
		if questProgress == 1 and player:getStorageValue(Storage.TheApeCity.QuestProgress) ~= 2 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Posluchaj, ostatnio nasza mala malpke dotknal turek pustynny. Hairycles nie wie jaka chorobe mogl roznosic. Jest dziwna. Hairycles powinien wiedziec. Ale Hairycles uczyl sie i uczyl sie koranu ...",
				"Moglbym chyba zrobic lekarstwo tak mocne, by zrobic Europe znowu biala. Ale do zrobienia lekarstwa wielkiego, potrzebuje poteznych rownie skladnikow ...",
				"Potrzebujemy whisper moss (Szept mchu). Whisper moss w gorach hydr pelnych rosnie. W tym problem, ze diabelskie Dworki caly juz pozabieraly do siebie ...",
				"Wiemy, ze ukrywaja sie na wschodzie gdzies w podziemiach. My atakowalismy ich, ale znalezc nie moglismy dziurek ich. Szukalismy w lesie wielkich drzew na wschodzie, ale szybko nam sie chowaly pod ziemie ...",
				"Idz tam i wykradnij whisper moss dla nas. Napisz do mnie pozniej jak poszlo ci z misja.",
			} or {
				"So listen, little ape was struck by plague. Hairycles not does know what plague it is. That is strange. Hairycles should know. But Hairycles learnt lots and lots ...",
				"Me sure to make cure so strong to drive away all plague. But to create great cure me need powerful components ...",
				"Me need whisper moss. Whisper moss growing south of human settlement is. Problem is, evil little dworcs harvest all whisper moss immediately ...",
				"Me know they hoard some in their underground lair. My people raided dworcs often before humans came. So we know the moss is hidden in dworc lair ...",
				"You go there and take good moss from evil dworcs. Talk with me about mission when having moss.",
			}, npc, creature)
		end
	elseif MsgContains(message, "outfit") or MsgContains(message, "shamanic") then
		if questProgress == 18 then
			if player:getStorageValue(Storage.TheApeCity.ShamanOutfit) ~= 1 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Ja dumny z ciebie, przyjacielu. Wiesz wiele o nas. Przekaze ci szamanskie moce. Jestes gotow?" or "Me truly proud of you, friend. You learn many about plants, charms and ape people. Me want grant you shamanic power now. You ready?", npc, creature)
				npcHandler:setTopic(playerId, 18)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Jestes juz szamanem." or "You already are shaman and doctor. Me proud of you.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz jeszcze wymaganej wiedzy." or "You not have finished journey for wisdom yet, young human.", npc, creature)
		end
	elseif MsgContains(message, "heal") then
		if questProgress > 11 then
			if player:getHealth() < 50 then
				player:addHealth(50 - player:getHealth())
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			elseif player:getCondition(CONDITION_FIRE) then
				player:removeCondition(CONDITION_FIRE)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			elseif player:getCondition(CONDITION_POISON) then
				player:removeCondition(CONDITION_POISON)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz odpoczynku." or "You look for food and rest.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz odpoczynku." or "You look for food and rest.", npc, creature)
		end
	elseif npcHandler:getTopic(playerId) == 1 then
		if table.contains({ "tak", "yes" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "By stac sie przyjacielem naszym dluga droga to jest. Nie ufamy tak latwo, ale pomoc potrzebna byc. Wysluchasz opowiesci Hairyclesa?" or "To become friend of ape people a long and difficult way is. We do not trust easy but help is needed. Will you listen to story of Hairycles?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chwala Wielkiej Jungli!" or "Hairycles sad is now. But perhaps you will change mind one day.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif npcHandler:getTopic(playerId) == 2 then
		if table.contains({ "tak", "yes" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Posluchaj, ostatnio nasza mala malpke dotknal turek pustynny. Hairycles nie wie jaka chorobe mogl roznosic. Jest dziwna. Hairycles powinien wiedziec. Ale Hairycles uczyl sie i uczyl sie koranu ...",
				"Moglbym chyba zrobic lekarstwo tak mocne, by zrobic Europe znowu biala. Ale do zrobienia lekarstwa wielkiego, potrzebuje poteznych rownie skladnikow ...",
				"Potrzebujemy whisper moss (Szept mchu). Whisper moss w gorach hydr pelnych rosnie. W tym problem, ze diabelskie Dworki caly juz pozabieraly do siebie ...",
				"Wiemy, ze ukrywaja sie na wschodzie gdzies w podziemiach. My atakowalismy ich, ale znalezc nie moglismy dziurek ich. Szukalismy w lesie wielkich drzew na wschodzie, ale szybko nam sie chowaly pod ziemie ...",
				"Idz tam i wykradnij whisper moss dla nas. Napisz do mnie pozniej jak poszlo ci z misja.",
			} or {
				"So listen, little ape was struck by plague. Hairycles not does know what plague it is. That is strange. Hairycles should know. But Hairycles learnt lots and lots ...",
				"Me sure to make cure so strong to drive away all plague. But to create great cure me need powerful components ...",
				"Me need whisper moss. Whisper moss growing south of human settlement is. Problem is, evil little dworcs harvest all whisper moss immediately ...",
				"Me know they hoard some in their underground lair. My people raided dworcs often before humans came. So we know the moss is hidden in east of upper level of dworc lair ...",
				"You go there and take good moss from evil dworcs. Talk with me about mission when having moss.",
			}, npc, creature)
			player:setStorageValue(Storage.TheApeCity.Started, 1)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 1)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Hairycles mial lepsze zdanie o tobie leszczu." or "Hairycles thought better of you.", npc, creature)
			addEvent(function()
				releasePlayer(npc, creature)
			end, 1000)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 3 then
		if table.contains({ "yes", "tak" }, message) then
			if not player:removeItem(4827, 1) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Glupi, nie masz mchu mojego. Idz go odzyskac." or "Stupid, you no have the moss me need. Go get it. It's somewhere in dworc lair. If you lost it, they might restocked it meanwhile. If you need to hear background of all again, ask Hairycles for {background}.", npc, creature)
				player:setStorageValue(Storage.TheApeCity.WhisperMoss, 0)
				return true
			end
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "Ah tak! To jest to. Dziekuje za przyniesienie poteznego whisper moss do Hairyclesa. To pomoge, ale jest duzo jeszcze do zrobienia. Spytaj mnie o misji przybyszu, gdy sie wysprzatasz i umyjesz, ughh."
					or "Ah yes! That's it. Thank you for bringing mighty whisper moss to Hairycles. It will help but still much is to be done. Just ask for other mission if you ready.",
				npc,
				creature
			)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 2)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Dziwaku! Nasz lud cie potrzebuje" or "Strange being you are! Our people need help!", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 4 then
		if table.contains({ "yes", "tak" }, message) then
			if not player:removeItem(4828, 1) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie nie, zly syrop wziales. Idz zdobyc inny, zdobadz syrop leczniczy." or "No no, not right syrup you have. Go get other, get right health syrup.", npc, creature)
				return true
			end
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Jestes wielki! Przyniosles mi syrop! Dziekuje, juz sie biore za robienie lekarstwa. Spytaj mnie o {mission}, jesli znowu zechcesz mi pomoc." or "You so good! Brought syrup to me! Thank you, will prepare cure now. Just ask for {mission} if you want help again.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 4)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Szybko, pilne to jest!" or "Please hurry, urgent it is!", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 5 then
		if table.contains({ "yes", "tak" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Sluchaj prosze. Plaga to nie byla tylko choroba prosta. Dlatego Hairycles nie mogl uleczyc zwykla magia. To jest nowa klatwa diabelskich lizardow...",
				"Hairycles mysli, ze klatwa na malym byla proba tylko. Musimy byc gotowi nim znowu uderza, ale mocniej...",
				"Ja potrzebuje papier od magicznych Lizardow! Na pewno znajdziesz go w ich bibliotece. Ukryta pewnie na wiezy w wiosce na poludniowy wschod stad. Poszukaj tam prosze! Jestes gotowy do wyprawy?",
			} or {
				"So listen, please. Plague was not ordinary plague. That's why Hairycles could not heal at first. It is new curse of evil lizard people ...",
				"I think curse on little one was only a try. We have to be prepared for big strike ...",
				"Me need papers of lizard magician! For sure you find it in his hut in their dwelling. It's south east of jungle. Go look there please! Are you willing to go?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 6)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Smutno. Oczekiwalem wiecej po tobie!" or "Me sad. Me expected better from you!", npc, creature)
			addEvent(function()
				releasePlayer(npc, creature)
			end, 1000)
			npcHandler:setTopic(playerId, 0)
		end
	elseif npcHandler:getTopic(playerId) == 6 then
		if table.contains({ "yes", "tak" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Dobrze slyszec! Czekam na report twoj o zdobyciu papieru z misji." or "Good thing that is! Report about your mission when have scroll.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 5)
			player:setStorageValue(Storage.TheApeCity.ParchmentDecyphering, 0)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Smutno mi. Oczekiwalem wiecej po tobie!" or "Me sad. Me expected better from you!", npc, creature)
			addEvent(function()
				releasePlayer(npc, creature)
			end, 1000)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 7 then
		if table.contains({ "yes", "tak" }, message) then
			if not player:removeItem(4831, 1) then
				if player:getStorageValue(Storage.QuestChests.OldParchment) == 1 then
					npcHandler:say(getPlayerLanguage(player) == "PL" and "To zla wiadomosc. Jesli straciles papier, jedynie mozesz go odzyskac polujac na swiete serpenty." or "That's bad news. If you lost it, only way to get other is to kill holy serpents. But you can't go there so you must ask adventurers who can.", npc, creature)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie! To nie tego potrzebuje. Glupia bezwlosia malpa. Idz do wioski lizardow i zdobadz ten magiczny papier!" or "No! That not scroll me looking for. Silly hairless ape you are. Go to village of lizards and get it there on your own!", npc, creature)
				end
				return true
			end

			npcHandler:say(getPlayerLanguage(player) == "PL" and "Przyniosles zapiski z jezykiem lizardow? Dobrze! Zobacze co ten tekst w sobie kryje! Wroc gdy bedziesz gotowy na kolejna misje." or "You brought scroll with lizard text? Good! I will see what text tells me! Come back when ready for other mission.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 6)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "To zla wiadomosc. Jesli straciles papier, jedynie mozesz go odzyskac polujac na swiete serpenty." or "That's bad news. If you lost it, only way to get other is to kill holy serpents. But you can't go there so you must ask adventurers who can.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 8 then
		if table.contains({ "yes", "tak" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Dobrze slyszec! Powiedz jak uda ci sie przeczytac te znaki." or "Good thing that is! Report about mission when you have read those signs.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 7)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Smutno mi. Oczekiwalem wiecej po tobie!" or "Me sad. Me expected better from you!", npc, creature)
			addEvent(function()
				releasePlayer(npc, creature)
			end, 1000)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 9 then
		if table.contains({ "yes", "tak" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Oh, teraz wszystko jasne! Latwiejsze niz sie wydaje! Wkrotce dowiemy sie co robic! Dziekuje ci! Mam jeszcze misje dla ciebie, badz gotow." or "Oh, so clear is all now! Easy it will be to read the signs now! Soon we will know what to do! Thank you again! Ask for mission if you feel ready.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 8)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Musze spojrzec w twoj umysl, nie ma innego wyjscia." or "Me need to see it in your mind, other there is no way to proceed.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 10 then
		if table.contains({ "yes", "tak" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Odwazna z ciebie bezwlosa malpa! Przynies jadro Hydry. Bedziesz musial wiele, wiele, tych trojglowych bestii zabic, by zdobyc jedno jajo!" or "You brave hairless ape! Get me hydra egg. If you lose egg, you probably have to fight many, many hydras to get another.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 9)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Smutno. Po takiej pomocy myslalem, ze tibijczyk z ciebie!" or "Me sad. Me expected better from you!", npc, creature)
			addEvent(function()
				releasePlayer(npc, creature)
			end, 1000)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 11 then
		if table.contains({ "yes", "tak" }, message) then
			if not player:removeItem(4839, 1) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz jaja Hydry. Prosze, zdobadz jedno!" or "You not have egg of hydra. Please get one!", npc, creature)
				return true
			end

			npcHandler:say(getPlayerLanguage(player) == "PL" and "Ah, jajo! Potezny wojownik z ciebie! Dziekuje. Hairycles zaraz odstawi je w bezpieczne miejsce." or "Ah, the egg! Mighty warrior you be! Thank you. Hairycles will put it at safe place immediately.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 10)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Pospiesz sie. Hairycles nie wie kiedy Lizardy uderza ponownie." or "Please hurry. Hairycles not knows when evil lizards strike again.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 12 then
		if table.contains({ "yes", "tak" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Poszukaj zatem jakiegos duzego skupiska Bone Lordow i znajdz te grzyby." or "Long journey it will take, good luck to you.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 11)
			player:setStorageValue(Storage.TheApeCity.WitchesCapStart, 1)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Smutno. Po takiej pomocy myslalem, ze tibijczyk z ciebie!" or "Me sad. Me expected better from you!", npc, creature)
			addEvent(function()
				releasePlayer(npc, creature)
			end, 1000)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 13 then
		if table.contains({ "yes", "tak" }, message) then
			if not player:removeItem(4829, 1) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie tego grzyba masz. Znajdz dla mnie witches' cap!" or "Not right mushroom you have. Find me a witches' cap!", npc, creature)
				return true
			end
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Niemozliwe,  przyniosles mi witches' cap! Teraz mam juz wszystko do poteznego amuletu zycia. Ale jeszcze {misja} jest dla ciebie, przyjacielu." or "Incredible, you brought a witches' cap! Now me can prepare mighty charm of life. Yet still other {missions} will await you, friend.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 12)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze, sprobuj poszukac witches' cap." or "Please try to find me a witches' cap.", npc, creature)
			addEvent(function()
				releasePlayer(npc, creature)
			end, 1000)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 14 then
		if table.contains({ "yes", "tak" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Dobrze. Ja nie wiem jak walczyc z ta magia. Idz do siebie. Pytaj magow, czarnoksieznikow, GMow, ksiezy, inkwizycje, ja nie wiedziec kogo. Ratuj nas i ludzi przed zaglada." or "Hairycles sure you will make it. Good luck, friend.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 13)
			player:setStorageValue(Storage.TheApeCity.CampfireMission, 1)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Tak myslalem. To za duzo dla Ciebie." or "Me sad. Please reconsider.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 15 then
		if table.contains({ "yes", "tak" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Hairycles jest dumny z ciebie. Idz i znajdz swiete wlosie. Powodzenia, przyajcielu." or "Hairycles proud of you. Go and find holy hair. Good luck, friend.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 15)
			player:setStorageValue(Storage.TheApeCity.HolyApeHair, 0)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Hmmm. Rozwaz to jeszcze raz." or "Me sad. Please reconsider.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 16 then
		if table.contains({ "yes", "tak" }, message) then
			if not player:removeItem(4832, 1) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz futra. Straciles je? Idz i sprawdz ponownie" or "You no have hair. You lost it? Go and look again.", npc, creature)
				player:setStorageValue(Storage.TheApeCity.HolyApeHair, 0)
				return true
			end
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Niemozliwe! Masz futro swietego Bonga! To podniesie morale mojej wioski. Jestes prawdziwym przyjacielem. Ale jeszcze jedna, ostatnia misja Cie czeka." or "Incredible! You got a hair of holy Bong! This will raise the spirit of my people. You are truly a friend. But one last mission awaits you.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 16)
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz futra. Straciles je? Idz i sprawdz ponownie." or "You no have hair. You lost it? Go and look again.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.HolyApeHair, 0)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 17 then
		if table.contains({ "yes", "tak" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Hairycles jest pewien, ze ci sie uda. Po prostu rozwal ta glowe tego jaszczuroludzia. Powiedz Hairyclesowi jesli uda ci sie ukonczyc misje." or "Hairycles sure you will make it. Just use hammer on all that looks like snake or lizard. Tell Hairycles if you succeed with mission.", npc, creature)
			player:setStorageValue(Storage.TheApeCity.QuestProgress, 17)
			player:AddCustomItem({ id = 4835, addToStore = true }) 
		elseif table.contains({ "nie", "no" }, message) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Hmmm. Rozwaz to jeszcze raz." or "Me sad. Please reconsider.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 18 then
		if MsgContains(message, "yes") or MsgContains(message, "tak") then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Przyjaciel malpiego rodu! Bierz ta nagroda i upodabniaj sie do nas! Oto szamanski stroj dla ciebie!" or "Friend of the ape people! Take my gift and become me apprentice! Here is shaman clothing for you!", npc, creature)
			player:addOutfit(154)
			player:addOutfit(158)
			player:setStorageValue(Storage.TheApeCity.ShamanOutfit, 1)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		elseif MsgContains(message, "no") then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Wracaj jak zmienisz zdanie." or "Come back if change mind.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif npcHandler:getTopic(playerId) == 19 then
		if MsgContains(message, "yes") or MsgContains(message, "tak") then
			if not player:removeItem(130, 1) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz tego co chcialem." or "You have what I'd like.", npc, creature)
				return true
			end

			player:setStorageValue(Storage.WhatAFoolishQuest.CookieDelivery.Hairycles, 1)
			if player:getCookiesDelivered() == 10 then
				player:addAchievement("Allow Cookies?")
			end

			Npc():getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			npcHandler:say("Thank you, you are ... YOU SON OF LIZARD!", npc, creature)
			addEvent(function()
				releasePlayer(npc, creature)
			end, 1000)
		elseif MsgContains(message, "no") then
			npcHandler:say("I see.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

keywordHandler:addKeyword({ "zajety" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Ja wielki {czarnoksieznik}. Wielki doktor mojego malpiego {ludu}. My znac wiele roslin. My starzy i znamy wiele przykrych rzeczy o bogach GMach.",
})
keywordHandler:addKeyword({ "czarnoksieznik" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Widzimi duzo rzeczy i szybko sie uczymy. Merlkin magii ucza sie szybko, szybko. Po prosto patrzymy i robimy. To nasz sekret na Kendricka, lepszy mozg.",
})
keywordHandler:addKeyword({ "things" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Nie jest dobrze teraz. Potrzebowac pomocy do wykonania {misji} dla mojej wioski.",
})
keywordHandler:addKeyword({ "ludu" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "My byc {kongra}, {sibang} lub {merlkin}. A dziwne malpy bez wlosia, co spia w rozwalonych drzewach mieszkaja w miescie Jungla.",
})
keywordHandler:addKeyword({ "kongra" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Kongra bardzo silne. Kongra bardzo wkurzone i szybkie. Uwazaj gdy kongre zobaczysz. Lepiej wejdz na najwyzszy budynek.",
})
keywordHandler:addKeyword({ "sibang" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Sibang bardzo szybkie i smieszne. Sibang dobre w zbieraniu jagod. Sibang znaja {puszcze}.",
})
keywordHandler:addKeyword({ "merlkin" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Merlkin to ja. Merlkin bardzo madre, merlkin ucza sie wielu rzeczy szybko. Uczymy inne malpy. Zdolne sa potem sie {leczyc} i byc zdolne robic {magia}.",
})
keywordHandler:addKeyword({ "magia" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Widzimi duzo rzeczy i szybko sie uczymy. Merlkin magii ucza sie szybko, szybko. Po prosto patrzymy i robimy. To nasz sekret na Kendricka, lepszy mozg.",
})
keywordHandler:addKeyword({ "puszcze" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Jungla jest niebezpieczna. Jungla rowniez obdarowuje nas jedzeniem. Hihi, nie raz upolowalismy Kendricka. Dostal kamieniem i spal. Jest bardzo dobry, bardzo smaczny.",
})

keywordHandler:addKeyword({ "busy" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Me great {wizard}. Me great doctor of {ape people}. Me know many plants. Me old and me have seen many things.",
})
keywordHandler:addKeyword({ "wizard" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "We see many things and learning quick. Merlkin magic learn quick, quick. We just watch and learn. Sometimes we try and learn.",
})
keywordHandler:addKeyword({ "things" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Things not good now. Need helper to do {mission} for me people.",
})
keywordHandler:addKeyword({ "ape people" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "We be {kongra}, {sibang} and {merlkin}. Strange hairless ape people live in city called Port Hope.",
})
keywordHandler:addKeyword({ "magic" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "We see many things and learning quick. Merlkin magic learn quick, quick. We just watch and learn. Sometimes we try and learn.",
})
keywordHandler:addKeyword({ "jungle" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Jungle is dangerous. Jungle also provides us food. Take care when in jungle and safe you be.",
})

local function onTradeRequest(npc, creature)
	if Player(creature):getStorageValue(Storage.TheApeCity.Questline) < 18 then
		return false
	end

	return true
end

npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_WALKAWAY, "Zegnam!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "banana", clientId = 3587, buy = 2 },
	{ itemName = "monkey statue 'hear' kit", clientId = 5087, buy = 65 },
	{ itemName = "monkey statue 'see' kit", clientId = 5086, buy = 65 },
	{ itemName = "monkey statue 'speak' kit", clientId = 5088, buy = 65 },
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

npcType:register(npcConfig)
