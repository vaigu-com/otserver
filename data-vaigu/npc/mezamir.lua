local internalNpcName = "Mezamir"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 0,
	lookBody = 79,
	lookLegs = 90,
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Nosz kurr.. teleporter chyba znow sie wylaczyl." },
	{ text = "...Nie warto bylo..." },
	{ text = "...oby znalazl sie ktos chcacy odwiedzic sfery..." },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "teleporter" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Poprzednie pokolenie tej wioski prowadzilo w podziemiach dziwne eksperymenty. Nikt nie wie dokladnie co tam sie dzialo. ...",
			"Prowadzili tam prace nad zywiolami, jednak ich badania wymknely sie spod kontroli. ...",
			"Tworzyli tam magiczne {kapliczki}, ktore jak sie okazalo wywoluja zle moce. Od czasu porzucenia badan nikt tam sie nie przedostal.",
		} or {
			"The previous generation of this village carried out strange experiments in the basement.. Nobody knows exactly what happened there. ...",
			"They worked on the four elements there, but their research got out of hand. ...",
			"They created magical {shrines}, which as it turned out, evoked evil powers. Nobody has looked there since many years.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "kapliczki", "shrines" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Poczatkowo mialy one sluzyc za zrodla elementarnej mocy wykorzystywanej do rozwijania zaklec i doskonalenia sztuki okielznywania zywiolow. ...",
			"Jednak jak juz wspominalem staly sie one zrodlem zlych mocy. W odpowiednich {sferach} strzega ich zywiolaki, ktorych odwagi pokonac nie mial nikt od porzucenia badan.",
		} or {
			"The creation of the elemental shrines is a really complex matter. They are actually nodes, locations where the matching elemental sphere is very close. ...",
			"The shrine itself is like a portal between our world and the elemental {sphere} and enables us to use the elemental energy emerging from it.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({
		"piekielna otchlan",
		"piekielne otchlanie",
		"piekielnych otchlani",
		"hellish abyss",
	}, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "O to lepiej spytaj Mazariusa." or "Better ask Mazarius about this. You will find him after teleport in my basement that I let you pass through.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "sferach", "sfery", "sfera", "spheres", "sphere" }, message) then
		if player:getLevel() >= 80 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Znane mi sa sfery czterech zywiolow, lodu, energii, ziemi oraz ognia. Trzeba przepedzic stamtad zle moce aby znow moc pozyskiwac energie zywiolow. Jestem jedyna osoba ktora wie jak sie tam przedostac ...",
				"Jest tam BARDZO niebezpiecznie, jednak wygladasz mi na osobe ktora mogla by temu podolac!!! Popros mnie o {misje} jesli jestes zainteresowany.",
			} or {
				"There are four spheres we know of: ice, fire, earth and energy. ....<mumbles> Hmmm, should I ask or not?....The heck with it! Now that you know about the spheres ...",
				"I found a way to visit them. It's VERY dangerous and there is a decent chance that you won't come back BUT if you succeed you'll write history!!! Ask me about that {mission} if you're interested.",
			}, npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Poprzednie pokolenie tej wioski prowadzilo w podziemiach dziwne eksperymenty. Nikt nie wie dokladnie co tam sie dzialo. ...",
				"Prowadzili tam prace nad zywiolami, jednak ich badania wymknely sie spod kontroli. ...",
				"Tworzyli tam magiczne {kapliczki}, ktore jak sie okazalo wywoluja zle moce. Od czasu porzucenia badan nikt tam sie nie przedostal.",
			} or {
				"It happened while he carried out an experiment concerning the creation of the elemental {shrines}. I still get goose bumps just by thinking of it. ...",
				"You need to know about the process of creating an elemental shrine to understand it completely, but I don't want to go into detail now. ...",
				"Anyway, his spell had a different outcome than he had planned. He accidentally created an Ice Overlord, pure living elemental ice, who froze him in a blink of an eye.",
			}, npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "misja", "quest", "misje", "mission" }, message) then
		local value = player:getStorageValue(Storage.ElementalSphere.QuestLine)
		if value < 1 then -- poczatek questa
			if player:getLevel() >= 80 then
				if player:isSorcerer() then
					npcHandler:say(getPlayerLanguage(player) == "PL" and {
						"No dobra, sluchaj wiec: Po pierwsze potrzebujesz zebrac 20 zaczarowanych rubinow jesli chcesz udac sie do ognistej sfery. Jesli udasz sie kilka pieter w glab mojej piwnicy znajdziesz tam teleporter, ktora przeniesie cie do niej. Aby ja uruchomic musisz wlozyc w nia wszystkie rubiny. ...",
						"Jesli juz tam sie przedostaniesz, zebrac musisz czastki zywiolu ognia. Na pewno zmierzysz sie z zwyiolakami ognia, jednak nie wiem dokladnie jak pozyskac z nich czesci zywiolow. ...",
						"Czastki te sluza do aktywowania kapliczki. Kiedy zostanie aktywowana zloz ktores cialo w jej obrebie, a pojawi sie strzegacy jej zywiolak. Pokonaj go i zbierz z niego skoncentrowany plomien. ...",
						"To tyle, jestes gotow?",
					} or {
						"Okay, listen closely: First of all, you need to gather 20 enchanted rubies in order to go to the fire sphere. In my basement there is a machine. Put the gems in there and activate it. ...",
						"Once you got there, find a way to gather elemental fire in any form. You will face fire elementals, that's for sure, but I don't know how the fire is stored. ...",
						"Anyway, there should be a way to use that elemental fire and strengthen one of the elementals. If my calculations are right, you will create a Fire Overlord who hopefully will consist of some sort of 'concentrated' fire or something similar. ...",
						"THAT'S what we need!! Are you in on it?",
					}, npc, creature)
				elseif player:isDruid() then
					npcHandler:say(getPlayerLanguage(player) == "PL" and {
						"No dobra, sluchaj wiec: Po pierwsze potrzebujesz zebrac 20 zaczarowanych szmaragdow jesli chcesz udac sie do ziemnej sfery. Jesli udasz sie kilka pieter w glab mojej piwnicy znajdziesz tam teleporter, ktora przeniesie cie do niej. Aby ja uruchomic musisz wlozyc w nia wszystkie szmaragdy. ...",
						"Jesli juz tam sie przedostaniesz, zebrac musisz czastki zywiolu ziemi. Na pewno zmierzysz sie z zwyiolakami ziemi, jednak nie wiem dokladnie jak pozyskac z nich czesci zywiolow. ...",
						"Czastki te sluza do aktywowania kapliczki. Kiedy zostanie aktywowana zloz ktores cialo w jej obrebie, a pojawi sie strzegacy jej zywiolak. Pokonaj go i zbierz z niego skoncentrowana ziemie. ...",
						"To tyle, jestes gotow?",
					} or {
						"Okay, listen closely: First of all, you need to gather 20 enchanted emeralds in order to go to the earth sphere. In my basement there is a machine. Put the gems in there and activate it. ...",
						"Once you got there, find a way to gather elemental earth in any form. You will face earth elementals, that's for sure, but I don't know how the earth is stored. ...",
						"Anyway, there should be a way to use that elemental earth and strengthen one of the elementals. If my calculations are right, you will create an Earth Overlord who hopefully will consist of some sort of 'concentrated' earth or something similar. ...",
						"THAT'S what we need!! Are you in on it?",
					}, npc, creature)
				elseif player:isPaladin() then
					npcHandler:say(getPlayerLanguage(player) == "PL" and {
						"No dobra, sluchaj wiec: Po pierwsze potrzebujesz zebrac 20 zaczarowanych szafirow jesli chcesz udac sie do lodowej sfery. Jesli udasz sie kilka pieter w glab mojej piwnicy znajdziesz tam teleporter, ktora przeniesie cie do niej. Aby ja uruchomic musisz wlozyc w nia wszystkie szafiry. ...",
						"Jesli juz tam sie przedostaniesz, zebrac musisz czastki zywiolu lodu. Na pewno zmierzysz sie z zwyiolakami lodu, jednak nie wiem dokladnie jak pozyskac z nich czesci zywiolow. ...",
						"Czastki te sluza do aktywowania kapliczki. Kiedy zostanie aktywowana zloz ktores cialo w jej obrebie, a pojawi sie strzegacy jej zywiolak. Pokonaj go i zbierz z niego skoncentrowany lod. ...",
						"To tyle, jestes gotow?",
					} or {
						"Okay, listen closely: First of all, you need to gather 20 enchanted sapphires in order to go to the ice sphere. In my basement there is a machine. Put the gems in there and activate it. ...",
						"Once you got there, find a way to gather elemental ice in any form. You will face ice elementals, that's for sure, but I don't know how the ice is stored. ...",
						"Anyway, there should be a way to use that elemental ice and strengthen one of the elementals. If my calculations are right, you will create an Ice Overlord who hopefully will consist of some sort of 'concentrated' ice or something similar. ...",
						"THAT'S what we need!! Are you in on it?",
					}, npc, creature)
				elseif player:isKnight() then
					npcHandler:say(getPlayerLanguage(player) == "PL" and {
						"No dobra, sluchaj wiec: Po pierwsze potrzebujesz zebrac 20 zaczarowanych ametystow jesli chcesz udac sie do energetycznej sfery. Jesli udasz sie kilka pieter w glab mojej piwnicy znajdziesz tam teleporter, ktora przeniesie cie do niej. Aby ja uruchomic musisz wlozyc w nia wszystkie ametysty. ...",
						"Jesli juz tam sie przedostaniesz, zebrac musisz czastki zywiolu energii. Na pewno zmierzysz sie z zwyiolakami energii, jednak nie wiem dokladnie jak pozyskac z nich czesci zywiolow. ...",
						"Czastki te sluza do aktywowania kapliczki. Kiedy zostanie aktywowana zloz ktores cialo w jej obrebie, a pojawi sie strzegacy jej zywiolak. Pokonaj go i zbierz z niego skoncentrowana energie. ...",
						"To tyle, jestes gotow?",
					} or {
						"Okay, listen closely: First of all, you need to gather 20 enchanted amethysts in order to go to the energy sphere. In my basement there is a machine. Put the gems in there and activate it. ...",
						"Once you got there, find a way to gather elemental energy in any form. You will face energy elementals, that's for sure, but I don't know how the energy is stored. ...",
						"Anyway, there should be a way to use that energy and strengthen one of the elementals. If my calculations are right, you will create an Energy Overlord who hopefully will consist of some sort of 'concentrated' energy. ...",
						"THAT'S what we need!! Are you in on it?",
					}, npc, creature)
				end
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Zadanie to jest dla ciebie zbyt niebezpiecznie, wroc do mnie jesli nabierzesz doswiadczenia." or "I'm sorry this task is highly dangerous and I need experienced people for it.", npc, creature)
				npcHandler:setTopic(playerId, 0)
				return false
			end
			npcHandler:setTopic(playerId, 1)
		elseif value == 1 then -- jak oddamy item z minibosa
			if player:getItemCount(player:isSorcerer() and 946 or player:isDruid() and 947 or player:isPaladin() and 942 or player:isKnight() and 945) > 0 then
				player:setStorageValue(Storage.ElementalSphere.QuestLine, 2)
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Niesamowite! Niech spojrze.. Ach!, "
						.. (
							player:isSorcerer() and "WIECZNY PLOMIEN! Teraz potrzebujesz znalezc przedstawicieli innych profesji, ktorzy takze ukonczyli to zadanie. ..."
							or player:isDruid() and "MACIERZYSTA GLEBA! Teraz potrzebujesz znalezc przedstawicieli innych profesji, ktorzy takze ukonczyli to zadanie. ..."
							or player:isPaladin() and "NIESKAZITELNY KRYSZTAL LODU! Teraz potrzebujesz znalezc przedstawicieli innych profesji, ktorzy takze ukonczyli to zadanie. ..."
							or player:isKnight() and "CZYSTA ENERGIA! Teraz potrzebujesz znalezc przedstawicieli innych profesji, ktorzy takze ukonczyli to zadanie. ..."
						),
					"Udaj sie znow do piwnicy. Ponizej niej znajduje sie pomieszczenie, w ktorym powinno byc bezpiecznie. Waszym zadaniem jest naladowanie maszyn odpowiednich dla profesji skoncentrowanymi czastkami zywiolow. Wtedy uzyskacie mozliwosc przywolania Pana Zywiolow ...",
					"Na jego ciele uzyj obsydianowy noz, aby pozyskac czastke neutralnej materii. Ona posluzy jako dowod przywrocenia rownowagi i wygnania zlych mocy w sferach!!",
				} or {
					"Impressive!! Let me take a look.......Ahh, "
						.. (
							player:isSorcerer() and "an ETERNAL FLAME! Now you need to find a knight, a druid, and a paladin who also completed this first task. ..."
							or player:isDruid() and "MOTHER SOIL! Now you need to find a knight, a paladin, and a sorcerer who also completed this first task. ..."
							or player:isPaladin() and "a FLAWLESS ICE CRYSTAL! Now you need to find a knight, a druid, and a sorcerer who also completed this first task. ..."
							or player:isKnight() and "PURE ENERGY! Now you need to find a druid, a paladin, and a sorcerer who also completed this first task. ..."
						),
					"Go down in the cellar again. I prepared a room in my basement where it should be safe. Your task is to charge the machines with the elemental substances and summon the LORD OF THE ELEMENTS. ...",
					"When you use an obsidian knife on it's corpse you hopefully get some of the precious neutral matter. It's the only way to restore the balance in spheres!",
				}, npc, creature)
			else
				npcHandler:say(
					getPlayerLanguage(player) == "PL"
							and "Potrzebujesz czastke zywiolu " .. (player:isSorcerer() and "Ognistego" or player:isDruid() and "Ziemnego" or player:isPaladin() and "Lodowego" or player:isKnight() and "Energetycznego") .. " Pana Zywiolow. Wroc do mnie jesli ja zdobedziesz."
						or "You need some kind of pure elemental soil from the " .. (player:isSorcerer() and "Fire" or player:isDruid() and "Earth" or player:isPaladin() and "Ice" or player:isKnight() and "Energy") .. " Overlord. Come back when you've got it.",
					npc,
					creature
				)
			end
			npcHandler:setTopic(playerId, 0)
		elseif value == 2 then
			if player:removeItem(954, 1) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"NIESAMOWITE! Sfery zywiolow sa teraz czyste od zlej energii. Bedzie mozna przywrocic pozyskiwanie energii zywiolow, jednak z wieksza ostroznoscia. Nalezy ci sie za to nagroda...",
					"Ah, i jeszcze jedno, mysle ze moge ci zdradzic sekret po tym wszystkim.. Natknales sie moze w podziemiach na ukryty teleport? Byl zabezpieczony magicznym zakleciem, ale specjalnie dla ciebie moge je sciagnac.",
					"Znajdziesz tam mojego znajomego, ktory od lat pilnuje w ukryciu przejscia do {piekielnych otchlani}. Byc moze pozwoli ci sie tam przedostac i pokonac najpotezniejszego z magow..",
				} or {
					"AMAZING!! I'm going to start immediately with the research. Here, take this as a reward and try to collect more of this substance. I'll make you a good offer, I promise.",
					"One more thing! I can tell you a secret after all of this.. Did you come across a hidden teleport in the underground? It was secured with a magic spell, but I can lat you pass there.",
					"There you will find my friend who has been guarding the passage to the {hellish abyss} for years. Perhaps he will let you get there and defeat the most powerful of the mages..",
				}, npc, creature)
				player:addItem(player:isSorcerer() and 8039 or player:isDruid() and 8041 or player:isPaladin() and 8025 or player:isKnight() and 8055, 1)
				player:setStorageValue(Storage.ElementalSphere.QuestLine, 3)
			end
		end
	elseif npcHandler:getTopic(playerId) == 1 and (MsgContains(message, "yes") or MsgContains(message, "tak")) then
		player:setStorageValue(Storage.ElementalSphere.QuestLine, 1)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Swietnie, nie trac czasu! Wroc do mnie jesli zdobedziesz czastke zywiolu!" or "Good, don't waste time! Come back here when you have the elemental object!", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end

	if (MsgContains(message, "machine") or MsgContains(message, "maszyna")) and player:getStorageValue(Storage.LiquidBlackQuest.Visitor) == 3 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Ah, maszyna, ktora znalazles na tej wyspie. Coz, zbudowalem to urzadzenie, aby zapuscic sie daleko pod sama ziemie, po ktorej chodzimy. Podejrzewalem cos tam. Cos gleboko pod nami. Cos zlego. Nawet bardziej niz przeklete owady, ktore pelzaly po moim gabinecie. ...",
			"Wiercilem otwor za otworem, tylko po to, by ponownie utknac w twardym, nie do przebicia osadzie, raz po raz. Bylem gotow zrezygnowac z tego bezsensownego przedsiewziecia. ...",
			"Jednakze, w ostatnim dniu, ktory spedzilem na tej wyspie, wreszcie wpadlem w ogromna dziure. Moj wiertarka roztrzaskala sie, a maszyna przestala byc mobilna. ...",
			"Doskonale zdaje sobie sprawe, ze moze to teraz brzmiec smiesznie - ale nagle pojawily sie schody. Niewiarygodnie duze schody, prowadzace do podziemi. Swiat gleboko pod morzem - czy mozna w to uwierzyc?",
		} or {
			"Ah, the machine you found at that island. Well, I built this thing to venture far beneath the very soil we walk on. I suspected something there. Something deep down below. Something evil. Even more so than the dreaded bugs which are crawling my study. ...",
			"Drilling hole after hole only to get stuck in another hard, unbreakable sediment again and again, I was about to quit this pointless enterprise. ...",
			"However, the very last day I lingered on that island, I finally fell into a large hollow right under the beach. My drill was shattered and the machine was not mobile anymore. ...",
			"I am well aware that this may sound laughable now - at this part all of my colleagues burst into laughter anyway - but suddenly there were stairs. Incredibly large stairs that led to the underworld. A world deep under the sea - can you believe this?",
		}, npc, creature)
		npcHandler:setTopic(playerId, 21)
	elseif (MsgContains(message, "yes") or MsgContains(message, "tak")) and npcHandler:getTopic(playerId) == 21 and player:getStorageValue(Storage.LiquidBlackQuest.Visitor) == 3 then
		if player:getStorageValue(Storage.LiquidBlackQuest.Visitor) == 3 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Rozumiesz? Coz, koniec tej historii byl taki, ze musialem opuscic to miejsce. ...",
				"Nie moglem zbadac tego, co lezy pod schodami, poniewaz byl tam nieprzewidywalny prad. Zanurzenie sie w tych wodach byloby niekontrolowanym ryzykiem, nawet majac srodki do przezycia bez powietrza. ...",
				"Wiec skorzystalem z przenosnego urzadzenia teleportacyjnego, ktore zainstalowalem w mojej maszynie na wypadek naglej potrzeby, i wrocilem do domu. Moglem zabrac tylko najwazniejsze dokumenty badawcze i musialem zostawic wiekszosc mojego sprzetu w jaskini. ...",
				"Oczywiscie zostawilem tam tez moje ostatnie notatki z koordynatami. I chocbym mial wyzionac ducha, nie moge sobie przypomniec, gdzie wykopalem te glupia dziure. ...",
				"Kiedy dotarlem do domu, od razu zaczalem szukac sposobu na poruszanie sie w tych chaotycznych warunkach, gdyby przypadkiem udalo mi sie odnalezc utracone wejscie. Nigdy go nie zapamietalem, ale wyglada na to, ze je znalazles, skoro rzeczywiscie masz moje pierwotne notatki. ...",
				"Aha, i jesli masz ochote dokonczyc to, co zaczalem - smialo. Masz na to ochote?",
			} or {
				"You do? Well, the end of this story was that I had to leave the place. ...",
				"I couldnt explore what lies below the stairs as there was an unpredictable stream. Diving into these waters would have been an uncontrollable risk, even with the means to survive without any air. ...",
				"So I used the portable teleporting device I installed into my machine in case of an emergency and went home. I could only take the most important research documents with me and had to leave most of my equipment in the cave. ...",
				"Of course I also left my final notes with the coordinates there. And for the life of me I cannot remember where I dug that stupid hole. ...",
				"When I arrived at home I immediately started looking for a way to manoeuvre in these chaotic conditions once I rediscovered the lost entrance. I never remembered it, but it seems you found it as you indeed have my original notes. ...",
				"Oh and just in case you want to complete what I have started - feel free to do so. Up to it?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 22)
		end
	elseif (MsgContains(message, "yes") or MsgContains(message, "tak")) and npcHandler:getTopic(playerId) == 22 and player:getStorageValue(Storage.LiquidBlackQuest.Visitor) == 3 then
		if player:getStorageValue(Storage.LiquidBlackQuest.Visitor) == 3 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Coz, jesli naprawde chcesz zglebic te sprawe - moglbym przyjac troche pomocy. Zatem znalazles moja maszyne na tej wyspie? I znalazles notatki z koordynatami? W takim razie mozesz odnalezc wejscie! ...",
				"Po prostu szukaj wielkiej klatki schodowej z rozleglymi stopniami. Tam jest potezny strumien, ktory uniemozliwi ci dalsze penetrowanie. Ale nie boj sie, faktycznie mozesz tam sie udac - z tymi malymi ulepszeniami, ktore stworzylem. ...",
				"Najpierw wroc na Piracka Wyspe, z ktorej rozpoczalem swoja ekspedycje wiele lat temu. ...",
				"Umieszcze to pod twoim obuwiem. Prosze bardzo. A to w twoim nosie. Tak. I nie bedzie juz dla ciebie tam zadnych dalszych problemow. O, no coz, sam sie przekonasz, prawda?",
			} or {
				"Well, if you really want to delve into this - I could use some help. So you have found my machine on that island? And you found the notes with the coordinates? Then you can find the entrance! ...",
				"Just look for a large staircase with sprawling steps. There is an unpassable stream there that will prevent you from venturing further on. But fear not, you can indeed travel down there - with these small enhancements I created. ...",
				"At first, return to the Pirate Island from where I started my expedition many years ago. ...",
				"I will put this under your footgear. Here you go. And this in your nose. There. And there will be no further problems for you down there. Except- ah, well youll find out yourself soon enough, wont you?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 23)
		end
	elseif (MsgContains(message, "yes") or MsgContains(message, "tak")) and npcHandler:getTopic(playerId) == 23 and player:getStorageValue(Storage.LiquidBlackQuest.Visitor) == 3 then
		if player:getStorageValue(Storage.LiquidBlackQuest.Visitor) == 3 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"No to ruszaj! Przykro mi, ze nie moge zaoferowac ci wiecej pomocy, ale jestem pewien, ze znajdziesz wsparcie w drodze. I - badz ostrozny. Morze bedzie sie czarne jak smola tam na dole.",
			} or {
				"Then off you go! Im sorry that I cannot offer you any further help but Im sure you will find support along your way. And - be careful. The sea can appear pitch black down there.",
			}, npc, creature)
			player:setStorageValue(Storage.LiquidBlackQuest.Visitor, 4)
			npcHandler:setTopic(playerId, 24)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "..co by tu dzis... Oh hej! W jakim celu tu zawitales?")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Zegnaj")
npcHandler:setMessage(MESSAGE_FAREWELL, "Mam nadzieje ze jeszcze kiedys sie spotkamy.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "energy soil", clientId = 945, sell = 2000 },
	{ itemName = "eternal flames", clientId = 946, sell = 5000 },
	{ itemName = "flawless ice crystal", clientId = 942, sell = 5000 },
	{ itemName = "glimmering soil", clientId = 941, sell = 2000 },
	{ itemName = "mother soil", clientId = 947, sell = 5000 },
	{ itemName = "iced soil", clientId = 944, sell = 2000 },
	{ itemName = "natural soil", clientId = 940, sell = 2000 },
	{ itemName = "neutral matter", clientId = 954, sell = 5000 },
	{ itemName = "pure energy", clientId = 948, sell = 5000 },
	{ itemName = "mage hat", clientId = 7992, buy = 200 },
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

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
