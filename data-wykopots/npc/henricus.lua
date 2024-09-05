local internalNpcName = "Henricus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 79,
	lookBody = 0,
	lookLegs = 96,
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

local flaskCost = 1000

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local totalBlessPrice = getBlessingsCost(player:getLevel()) * 5 * 0.85

	if MsgContains(message, "inquisitor") or MsgContains(message, "inkwizytor") then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Bogowie powierzyli mi ogromne i odpowiedzialne zadanie, ktorym jest przewodzenie inkwizycji. Prace badawcze przeznaczone sa dla inkwizytorow, ktorych rekrutuję z napotkanych mi osob."
				or "The churches of the gods entrusted me with the enormous and responsible task to lead the inquisition. I leave the field work to inquisitors who I recruit from fitting people that cross my way.",
			npc,
			creature
		)
	elseif MsgContains(message, "join") or MsgContains(message, "dolacz") then
		if player:getStorageValue(Storage.TheInquisition.Questline) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz dolaczyc do inkwizycji?" or "Do you want to join the inquisition?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "blessing") or MsgContains(message, "bless") or MsgContains(message, "blogoslawienstwo") then
		if player:getStorageValue(Storage.TheInquisition.Questline) == 25 then -- if quest is done
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz otrzymac blogoslawienstwa za " .. totalBlessPrice .. " zlota?" or "Do you want to receive the blessing of the inquisition for " .. totalBlessPrice .. " gold?", npc, creature)
			npcHandler:setTopic(playerId, 7)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie mozesz zdobyc blogoslawienstw, jesli nie ukonczysz misji." or "You cannot get this blessing unless you have completed The Inquisition Quest.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "flask") or MsgContains(message, "special flask") or MsgContains(message, "flaszka") then
		if player:getStorageValue(Storage.TheInquisition.Questline) >= 12 then -- give player the ability to purchase the flask.
			npcHandler:say("Do you want to buy the special flask of holy water for " .. flaskCost .. " gold?", npc, creature)
			npcHandler:setTopic(playerId, 8)
		else
			npcHandler:say("You do not need this flask right now.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "mission") or MsgContains(message, "misje") or MsgContains(message, "misja") then
		if player:getStorageValue(Storage.TheInquisition.Questline) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz dolaczyc do inkwizycji?" or "Do you want to join the inquisition?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Zobaczmy wiec, czy jestes tego wart. ...",
				"Przepytaj straznikow poszczegolnych miast, aby zbadac ich wiernosc i oddanie. Pozniej zdaj mi raport.",
			} or {
				"Let's see if you are worthy. Take an inquisitor's field guide from the box in the back room. ...",
				"Follow the instructions in the guide to talk to the Thaian guards that protect the walls and gates of the city and test their loyalty. Then report to me about your {mission}.",
			}, npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 2)
			player:setStorageValue(Storage.TheInquisition.Mission01, 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 2 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Przepytaj straznikow poszczegolnych miast, aby zdobyc zaufanie. Ukonczyles te misje?" or "Your current mission is to investigate the reliability of certain guards. Are you done with that mission?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 3 then -- jak ukonczona 2 misja
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Mam informacje o dziwnych obrzedach czarownic, ktore przesiaduja gdzies na bagnie, na poludnie od Mirko Town. Przelaza tam podziemnym przejsciem, i mysla ze sa bezpieczne.. ...",
				"Uzyj fiolki swietej wody, aby zniszczyc ich kociol. Ukradnij tez ich magiczna ksiege i mi przynies.",
			} or {
				"Listen, we have information about a heretic coven that hides in a bog south of Mirko Town. The witches reach this cursed place on flying brooms and think they are safe there. ...",
				"Maybe theres another way to enter their hideout. At their meeting place, you'll find a cauldron in which they cook some forbidden brew ...",
				"Use this vial of holy water to destroy the brew. Also steal their grimoire and bring it to me.",
			}, npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 4) -- to zaczyna trzecia
			player:setStorageValue(Storage.TheInquisition.Mission02, 1) -- The Inquisition Questlog- "Mission 2: Eclipse"
			player:addItem(133, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 5 then
			if player:removeItem(7874, 1) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Pora sprawdzic twoje mozliwosci. Jeden z naszych sojusznikow potrzebuje wsparcia. Mysle, ze jestes odpowiednia osoba aby mu pomoc ...",
					"Storkus jest starym krasnoludem, ktory trudni sie zwalczaniem wampirow. Jest w tym swietny, jednak kazdy ma swoje granice. ...",
					"Szkoli on naszych rekrutow, ktorzy pomagajac mu zapewniaja korzysci dla obu stron.  ...",
					"Znajdziesz go gleboko w krasnoludzkich kopalniach. On powierzy ci kolejne zadanie.",
				} or {
					"I think it's time to truly test your abilities. One of our allies has requested assistance. I think you are just the right person to help him ...",
					"Storkus is an old and grumpy dwarf who works as a vampire hunter since many, many decades. He's quite successful but even hehas his limits. ...",
					"So occasionally, we send him help. In return he trains and tests our recruits. It's an advantageous agreement for both sides ...",
					"You'll find him in dwarven mines north of Mirko Town. He'll tell you about your next mission.",
				}, npc, creature)
				player:setStorageValue(Storage.TheInquisition.Questline, 6)
				player:setStorageValue(Storage.TheInquisition.Mission02, 3) -- The Inquisition Questlog- "Mission 2: Eclipse"
				player:setStorageValue(Storage.TheInquisition.Mission03, 1) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Musisz mi przyniesc 'the witches' grimoire'." or "You need bring me the witches' grimoire.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) > 5 and player:getStorageValue(Storage.TheInquisition.Questline) < 11 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Twoim zadaniem jest pomoc pogromcy wampirow, Storkusowi. Ukonczyles te misje?" or "Your current mission is to help the vampire hunter Storkus. Are you done with that mission?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 11 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Mam informacje o opuszczonej koloni pirackiej w dzunglii. Znajduja sie tam ruiny, i chcialbym, abys je przebadal. ...",
				"Przebywaja tam jakies zle moce.. Mysle, ze lepiej wybrac sie tam w nocy, to pomoze je zlokalizowac. Jesli juz je znajdziesz, to uzyj tam fiolki wody swieconej, na pewno je wypedzi.",
			} or {
				"We've got a report about an abandoned and haunted ruin in north west of jungle. I want you to examine this house. There are some earth elementals around, Im sure youll find it. ...",
				"There's an evil being somewhere. Use this vial of holy water on that spot to drive out the evil being.",
			}, npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 12)
			player:setStorageValue(Storage.TheInquisition.Mission04, 1) -- The Inquisition Questlog- "Mission 4: The Haunted Ruin"
			player:addItem(133, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 12 or player:getStorageValue(Storage.TheInquisition.Questline) == 13 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Musisz wypedzic zle moce z pirackich ruin. Ukonczyles to zadanie?" or "Your current mission is to exorcise an evil being from a ruin in jungle. Are you done with that mission?", npc, creature)
			npcHandler:setTopic(playerId, 5)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 14 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Poradziles sobie z roznymi stworami krazacymi po naszym swiecie. Teraz musisz przygotowac sie do walki z istota zagrazajaca wszelkiemu istnieniu.. Twoje kolejne zadanie nie bedzie proste. ...",
				"Postaraj sie pokonac troche demonicznych istot, gdziekolwiek je znajdziesz. Przynies mi 20 esencji ich dusz, jako dowod swojego poswiecenia.",
			} or {
				"You've handled heretics, witches, vampires and ghosts. Now be prepared to face the most evil creatures we are fighting - demons. Your new task is extremely simple, though far from easy. ...",
				"Go and slay demonic creatures wherever you find them. Bring me 20 of their essences as a proof of your accomplishments.",
			}, npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 15)
			player:setStorageValue(Storage.TheInquisition.Mission05, 1) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 15 then
			if player:removeItem(6499, 20) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Jestes prawdziwym zbawieniem dla wiernych.. Musisz kontynuowac swoja misje. ...",
					"Mam nagrode za twoje poswiecenie. Zapytaj mnie o {demon hunter outfit} aby go otrzymac. Jak bedziesz mial czas to pogadamy o kolejnej misji.",
				} or {
					"You're indeed a dedicated protector of the true believers. Don't stop now. Kill as many of these creatures as you can. ...",
					"I also have a reward for your great efforts. Talk to me about your {demon hunter outfit} anytime from now on. Afterwards, let's talk about the next mission that's awaiting you.",
				}, npc, creature)
				player:setStorageValue(Storage.TheInquisition.Questline, 16)
				player:setStorageValue(Storage.TheInquisition.Mission05, 2) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz ich 20." or "You need 20 of them.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 17 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Mam informacje o czyms bardzo niebezpiecznym, co ma wydarzyc sie na pustyni. Demony cos tam przygotowuja ...",
				"Cos, co jest zagrozeniem dla nas wszystkich. Naszym sledczym udalo sie ustalic troche informacji, jednak kilku z nich pojmal demon zwany Ungreez. ...",
				"Twoim zadaniem bedzie sie zemscic, i go pokonac. Potrzebujesz przy sobie demonicznej esencji, aby przedostac sie do jego leza. Znajdziesz go w podziemiach wulkanu zasiedlonego przez demony na pustyni. Powodzenia.",
			} or {
				"We've got information about something very dangerous going on on the desert. The demons are preparing something there ...",
				"Something that is a threat to all of us. Our investigators were able to acquire vital information before some of them were slain by a demon named Ungreez. ...",
				"It'll be your task to take revenge and to kill that demon. You'll find him in the depths of volcano in desert. Good luck.",
			}, npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 18)
			player:setStorageValue(Storage.TheInquisition.Mission06, 1) -- The Inquisition Questlog- "Mission 6: The Demon Ungreez"
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 19 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Wiec bestia jest w koncu martwa! Dzieki Bogu. Przynajmniej cos poszlo po naszej mysli ...",
				"Poprzednikom sie tak nie poszczescilo. Ale zobaczymy jak pojdzie tobie w kolejnej misji.",
			} or {
				"So the beast is finally dead! Thank the gods. At least some things work out in our favour ...",
				"Our other operatives were not that lucky, though. But you will learn more about that in your next {mission}.",
			}, npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 20)
			player:setStorageValue(Storage.TheInquisition.Mission06, 3) -- The Inquisition Questlog- "Mission 6: The Demon Ungreez"
			player:addOutfitAddon(288, 1)
			player:addOutfitAddon(289, 1)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 20 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Zniszcz shadow nexus uzywajac na nim wody swieconej, oraz pokonaj wszystkich demonicznych wladcow." or "Destroy the shadow nexus using this vial of holy water and kill all demon lords.", npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 21)
			player:setStorageValue(Storage.TheInquisition.Mission07, 1) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
			player:addItem(133, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 21 or player:getStorageValue(Storage.TheInquisition.Questline) == 22 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Zniszcz shadow nexus zlokalizowany w Demon Forge. Ukonczyles te misje?" or "Your current mission is to destroy the shadow nexus in the Demon Forge. Are you done with that mission?", npc, creature)
			npcHandler:setTopic(playerId, 6)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "tak") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Wiec stalo sie. Zostales czlonkiem inkwizycji. Mozesz mnie spytac o {misje} aby wzbudzic moj szacunek." or "So be it. Now you are a member of the inquisition. You might ask me for a {mission} to raise in my esteem.", npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getStorageValue(Storage.TheInquisition.WalterGuard) == 1 and player:getStorageValue(Storage.TheInquisition.KulagGuard) == 1 and player:getStorageValue(Storage.TheInquisition.GrofGuard) == 1 and player:getStorageValue(Storage.TheInquisition.MilesGuard) == 1 and player:getStorageValue(Storage.TheInquisition.TimGuard) == 1 then
				npcHandler:say({
					"Wiedzialem jakich odpowiedzi mozna sie spodziewac, wiec na pewno nie zmyslasz. Jednak to byl tylko test odpowiedzialnosci. ...",
					"Zobaczmy, czy podolasz kolejnemu zadaniu.",
				} or {
					"Indeed, this is exactly what my other sources told me. Of course I knew the outcome of this investigation in advance. This was just a test. ...",
					"Well, now that you've proven yourself as useful, you can ask me for another mission. Let's see if you can handle some field duty, too.",
				}, npc, creature)
				player:setStorageValue(Storage.TheInquisition.Questline, 3)
				player:setStorageValue(Storage.TheInquisition.Mission01, 7) -- The Inquisition Questlog- "Mission 1: Interrogation"
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie ukonczyles swojego zadania." or "You haven't done your mission yet.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getStorageValue(Storage.TheInquisition.Questline) == 10 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Dobrze, ze wrociles. Twoje umiejetnosci wydaja sie byc przydatne. Jesli jestes gotow, aby wykonac kolejne zadanie, to spytaj o nie." or "Good, you've returned. Your skill in practical matters seems to be useful. If you're ready for a further mission, just ask.", npc, creature)
				player:setStorageValue(Storage.TheInquisition.Questline, 11)
				player:setStorageValue(Storage.TheInquisition.Mission03, 6) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie ukonczyles swojego zadania u Storkusa." or "You haven't done your mission with Storkus yet.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:getStorageValue(Storage.TheInquisition.Questline) == 13 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "To bylo bardzo proste zadanie, kolejne bedzie duzo bardziej wymagajace." or "Well, this was an easy task, but your next mission will be much more challenging.", npc, creature)
				player:setStorageValue(Storage.TheInquisition.Questline, 14)
				player:setStorageValue(Storage.TheInquisition.Mission04, 3) -- The Inquisition Questlog- "Mission 4: The Haunted Ruin"
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie ukonczyles swojego zadania u Storkusa." or "You haven't done your mission with Storkus yet.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 6 then
			if player:getStorageValue(Storage.TheInquisition.Questline) == 22 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Niesamowite! Prawdziwy wybawca wiernych! Mianuje cie zasluzonym inkwizytorem. Jesli zechcesz, to moge udzielic ci blogoslawienstw ...",
					"Nie zapomnij tez zapytac mnie o {outfit}, aby otrzymac nowe dodatki.",
				} or {
					"Incredible! You're a true defender of faith! I grant you the title of a High Inquisitor for your noble deeds. From now on you can obtain the blessing of the inquisition which makes the pilgrimage of ashes obsolete ...",
					"Also, don't forget to ask me about your {outfit} to receive the final addon as demon hunter.",
				}, npc, creature)
				player:setStorageValue(Storage.TheInquisition.Questline, 23)
				player:setStorageValue(Storage.TheInquisition.Mission07, 3) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
				player:setStorageValue(Storage.Finished.TheInquisition, 1)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc jesli zniszczysz shadow nexus." or "Come back when you have destroyed the shadow nexus.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 8 then
			if player:removeMoney(flaskCost) then
				npcHandler:say("Here is your new flask!, |PLAYERNAME|.", npc, creature)
				player:addItem(133, 1)
			else
				npcHandler:say("Come back when you have enough money.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 7 then
			if player:getBlessings() == 5 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Jestes juz poblogoslawiony!" or "You already have been blessed!", npc, creature)
			elseif player:removeMoney(totalBlessPrice) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Zostales poblogoslawiony!, |PLAYERNAME|." or "You have been blessed by all of five gods!, |PLAYERNAME|.", npc, creature)
				for i = 2, 6 do
					player:addBlessing(i, 1)
				end
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc jesli zdobedziesz pieniadze." or "Come back when you have enough money.", npc, creature)
			end
		end
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "no") or MsgContains(message, "nie") then
		if npcHandler:getTopic(playerId) > 0 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie to nie." or "Then no.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "outfit") then
		if player:getStorageValue(Storage.TheInquisition.Questline) == 16 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Oto twoj demon hunter outfit. Zasluzyles na niego." or "Here is your demon hunter outfit. You deserve it. Unlock more addons by completing more missions.", npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 17)
			player:setStorageValue(Storage.TheInquisition.Mission05, 3) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			player:addOutfit(288, 0)
			player:addOutfit(289, 0)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 23 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Oto twoj ostatni dodatek, gratulacje!" or "Here is the final addon for your demon hunter outfit. Congratulations!", npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 24)
			player:setStorageValue(Storage.TheInquisition.Mission07, 4) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
			player:addOutfitAddon(288, 2)
			player:addOutfitAddon(289, 2)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Jestem Henryk, Mistrz Inkwizycji.",
})

npcHandler:setMessage(MESSAGE_GREET, "Witam cie, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Uwazaj na siebie, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Do zobaczenia..")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
