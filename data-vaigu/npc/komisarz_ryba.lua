local internalNpcName = "commissioner Fisher"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 268,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 3,
}

npcConfig.flags = { floorchange = false }

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
	{ text = "Dzieki mnie przestepcy ogladaja swiat w kratke!" },
	{
		text = "Poki tutaj jestem w Mirkotown bedzie porzadek a liczba killerow w wiezieniu bedzie sie zgadzac!",
	},
	{ text = "A paragrafy mam juz dawno w dupie!" },
	{
		text = "Widzialem ooooorla cieeen, ktory wzbil sieee niczym wiatr, nananaaaa nanaaa naaaa",
	},
	{ text = "Coo powiee Ryyyybaaa.... a duzo powie jak zapytasz!" },
	{ text = "Tu Ryba, wzywam Cie, Akwarium." },
	{
		text = "Co ty myslisz, cwaniaczku?! Ze z piatego przykazania mozesz sobie zrobic spolke z ograniczona odpowiedzialnoscia?!",
	},
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	-- ============= MISJA TRUDNE POCZATKI =================
	if table.contains({ "zlodziej", "thief" }, message) and player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) == 7 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Dziekuje, ze sie tym zajales. Znalem Drwala Domino, pamietam ze kiedys pracowal w tartaku. ...",
			"Ktoregos razu zadarl z hunterami, i od tego czasu go nie widziano. Co do orkow, to ostatnio sobie smielej poczynaja, ale ta sytuacja nie powinna {zaognic} ich wojny z elfami.",
		} or {
			"Thanks for taking care of this. I knew lumberjack Domino, I remember that he was working in a sawmill. ...",
			"Once upon a time he messed up with hunters, from that time he wasn't seen. As for the orcs, they've been more aggressive lately, but this situation shouldn't aggravate their war with the elves.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "zlodziej", "thief", "nagroda", "reward", "drwal" }, message) and player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) == 13 then
		if player:getLevel() >= 35 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Dobra robota zolnierzu, oto twoja nagroda. Znalazlem te przedmioty wsrod skradzionych rupieci, ktore znalezlismy w norze zbira." or "Well done soldier, here's your reward. I found these items among stolen goods which we found in a thugs den.", npc, creature)
			player:setStorageValue(Storage.IKEAdlazuchwalych.RemanentMain, 14)
			player:setStorageValue(Storage.Finished.Ikea, 1)
			player:addItem(22195, 1) -- onyx pendant
			player:addExperience(100000, true) -- 100k expa
			player:getPosition():sendMagicEffect(CONST_ME_STUN)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 35 poziomu!" or "Come back when you reach 35 level!", npc, creature)
		end
	elseif table.contains({ "mission", "misja" }, message) and player:getStorageValue(Storage.TrudnePoczatki.PoczatkiReward) == 4 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Na razie nic wiecej nie mam, ale popytaj ludzi w miescie, ktos napewno cos bedzie dla ciebie miec." or "That's it for now, but ask other people in the town. I'm sure some of them will need your help.", npc, creature)
	elseif table.contains({ "mission", "misja" }, message) and player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna) == 5 then
		player:setStorageValue(Storage.TrudnePoczatki.DostawaDrewna, 6)
		player:setStorageValue(Storage.Finished.TrudnePoczatki, 1) -- quest done (website)
		player:addExperience(35000, true) -- 35k expa (20-22lvl)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "No i bardzo dobrze, zglos sie do Trollskyego po nagrode, od teraz jestes certyfikowanym wojownikiem MirkoTown." or "Very good, go speak with Trollsky about your reward, from now on you are certified warrior of MirkoTown.", npc, creature)
	elseif table.contains({ "mission", "misja" }, message) and player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna) == 3 then
		player:setStorageValue(Storage.IKEAdlazuchwalych.RemanentMain, 0)
		player:setStorageValue(Storage.TrudnePoczatki.DostawaDrewna, 4)
		player:addItem(3421, 1) -- dark shield
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Co?! Waski, ten przydupas? Bawi sie w gangsterke? Ja mu pokaze kto jest debesciak. ...",
			"To moze byc dla ciebie trudna misja, ale wierze ze sobie poradzisz. Podaruje ci lepsza tarcze, bo twoja wyglada mizernie. Jak odzyskasz drewno to cie wynagrodze. ...",
			"Poza tym mozesz zglosic sie do Komora, wspominal ze potrzebuje kogos co pomocy.",
		} or {
			"What?! Wąski, that asslicker? He wanna be a gangster? I'll show him who is the real deal here. ...",
			"It might be a difficult mission for you but I believe that you can make it. I'll give you a better shield because yours looks like crap. If you will get the wood back I'll reward you. ...",
			"And also you can visit Komor, hes in some trouble recently.",
		}, npc, creature)
	elseif table.contains({ "mission", "misja" }, message) and player:getStorageValue(Storage.TrudnePoczatki.Rozeznanie) == 12 and player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna) < 1 then
		player:setStorageValue(Storage.TrudnePoczatki.DostawaDrewna, 1) -- nowa misja
		player:addItem(268, 20) -- 20 potow
		player:addExperience(15000, true) -- 15k expa
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Kula cygana? On nigdy nie byl ostrozny. ...",
			"Trzy osoby skarza sie na brak drewna? Trzeba to sprawdzic. Jak najszybciej wyrusz do Knurowa i zapytaj sie w porcie o dostawe. ...",
			"Idz droga na zachod od miasta, a na pewno trafisz. Dostajesz ode mnie maly zapas potionow, moga sie przydac.",
		} or {
			"Gypsy fortune telling ball? He was never careful. ...",
			"Three people are complaining about wood deficiency? It must be checked. As soon as possible go to Knurowo and ask in port about the delivery. ...",
			"Follow the road at the west of the city and you will find it. I'll give you some potions supply, you may need them.",
		}, npc, creature)
	elseif table.contains({ "mission", "misja" }, message) and player:getStorageValue(Storage.TrudnePoczatki.Rozeznanie) < 2 then
		player:setStorageValue(Storage.TrudnePoczatki.Rozeznanie, 2)
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Nowy rekrut? Wspaniale, kolejne mieso armat... Ekhm, znaczy sie material na zolnierza. ...",
			"Jako pierwsza misja, przejdz po glownych handlarzach w Mirkotown i spytaj czy nie potrzebuja pomocy, a potem przyjdz do mnie z raportem. ...",
			"Nie rob nic bez konsultacji ze mna. A teraz ruszaj, nie trac czasu.",
		} or {
			"New recruit? Great! Another cannon fodd.. I mean potential soldier. ...",
			"At your first mission, visit all of the main sellers in MirkoTown and ask them if they need some help, after that come back to me to report. ...",
			"Don't do anything without consulting me. And now go, there's no time to lose.",
		}, npc, creature)
	elseif table.contains({ "escalate", "zaognic" }, message) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Orki sa zbyt glupie, zeby spostrzec tak male zmiany w inwentarzu. Teraz mamy inny problem, mianowicie musimy {zlapac} naszego zlodzieja-uciekiniera." or "Orcs are too dumb to notice some changes in inventory. Now we have different issue, we need to {catch} our thief-fugitive.", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({ "catch", "zlapac" }, message) and npcHandler:getTopic(playerId) == 2 then
		player:setStorageValue(Storage.IKEAdlazuchwalych.RemanentMain, 8)
		player:setStorageValue(Storage.IKEAdlazuchwalych.ZlodziejAsked, 0)
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Tak, musimy jak najszybciej zatrzymac naszego zlodzieja. Juz teraz pewnie planuje jak wrocic do 'biznesu' meblarskiego. Popytaj ludzi wokol, moze ktos widzial, w ktora strone uciekl."
				or "Yes, we must stop our thief as fast as possible. Probably he is planning to come back to the furniture ‘business’. Ask people around, maybe someone seen where he ran.",
			npc,
			creature
		)
		npcHandler:setTopic(playerId, 0)
		-- ============= MISJA TRUDNE POCZATKI =================
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
