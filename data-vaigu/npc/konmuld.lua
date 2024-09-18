local internalNpcName = "Konmuld"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 430,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
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

local config = nil
local lang_to_config = {
	["PL"] = {
		[1] = {
			"WSPANIALA! Stworze sobie z tej duszy swoja wlasna dziewice! ...",
			"Tak jak obiecalem, masz do wyboru w podziece: {maska}, {spodnie}, {armor}. Ktore wybierasz?",
		},
		[2] = {
			"Powiem ci jak zrobimy. Od paru lat zaglebiam sie w tajemna sztuke czarnej magii. Ciagle brakuje mi duszy dziewicy. ...",
			"Nie wiem, jak ja zdobyc, ale {ktos} na pewno bedzie wiedzial. Sproboj sie dowiedziec, i przywlec mi przynajmniej jedna dusze.. Podaruje ci za to jedna z czesci mojego dawnego stroju.",
		},
	},
	["EN"] = {
		[1] = {
			"GREAT! I will create a virgin from that soul just for myself! ...",
			"As promissed. You can choose one of yalahari pieces: {mask}, {legs} or {armor}. What is your choice?",
		},
		[2] = {
			"I'll tell you what we will do. For a few years I have been studying the art of secret black magic. Still the soul of the virgin is missing. ...",
			"I don't know how to get it, but {someone} will know for sure. Try to find out and bring me at least one soul. I'll give you one piece of my old set.",
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
	-- ============= YALAHARI MISSION 2 =================

	if MsgContains(message, "aloha") then
		-- czy ma skonczoną pierwsza misje
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie mam humoru na rozmowe z toba." or "Im not in the mood to talk with you.", npc, creature)
	elseif table.contains({ "maska", "armor", "spodnie", "mask", "armor", "legs" }, message) and npcHandler:getTopic(playerId) == 2 then
		if player:getStorageValue(Storage.Yalahar.WstepDoCzarnejMagii) == 4 then
			if MsgContains(message, "maska") or MsgContains(message, "mask") then
				player:addItem(8864, 1) -- yalahari mask
				player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 5)
				player:setStorageValue(Storage.Finished.YalahariQuest, 1) -- quest done (website)
				player:addOutfit(324, 0)
				player:addOutfit(325, 0)
				player:addOutfitAddon(324, 3)
				player:addOutfitAddon(325, 3)
			elseif MsgContains(message, "armor") then
				player:addItem(8862, 1) -- yalahari armor
				player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 5)
				player:setStorageValue(Storage.Finished.YalahariQuest, 1) -- quest done (website)
				player:addOutfit(324, 0)
				player:addOutfit(325, 0)
				player:addOutfitAddon(324, 3)
				player:addOutfitAddon(325, 3)
			elseif MsgContains(message, "spodnie") or MsgContains(message, "legs") then
				player:addItem(8863, 1) -- yalahari legs
				player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 5)
				player:setStorageValue(Storage.Finished.YalahariQuest, 1) -- quest done (website)
				player:addOutfit(324, 0)
				player:addOutfit(325, 0)
				player:addOutfitAddon(324, 3)
				player:addOutfitAddon(325, 3)
			end
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Oto twoja nagroda!" or "Heres your reward!", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Juz odebrales nagrode!" or "You get your reward already.", npc, creature)
		end
	elseif table.contains({ "mission", "misja", "dusza", "gertruda", "yalahari" }, message) and player:getStorageValue(Storage.PathOfTheUndead.Mission03) ~= 1 then
		if player:getStorageValue(Storage.Yalahar.WstepDoCzarnejMagii) == 3 then
			if player:getLevel() >= 60 then
				npcHandler:say(config[1], npc, creature)
				player:addExperience(350000, true) -- 350k expa
				player:getPosition():sendMagicEffect(CONST_ME_STUN)
				player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 4)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 60 poziomu!" or "Come back when you reach 60 level!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(Storage.Yalahar.WstepDoCzarnejMagii) == 4 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Tak jak obiecalem, masz do wyboru w podziece: {maska}, {spodnie}, {armor}. Ktore wybierasz?" or "As promissed. You can choose one of yalahari pieces: {mask}, {legs} or {armor}. What is your choice?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.Yalahar.WstepDoCzarnejMagii) < 1 and player:getStorageValue(Storage.Yalahar.ZabojczyTrunek) == 3 then
			player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 1) -- zaczynamy questa
			npcHandler:say(config[2], npc, creature)
		end
	elseif table.contains({
		"mission",
		"misja",
		"krol krypty",
		"crypt king",
		"the king of the crypt",
		"king",
		"krol",
	}, message) and player:getStorageValue(Storage.PathOfTheUndead.Mission03) == 1 then
		npcHandler:say(
			getPlayerLanguage(player) == "PL"
					and "Przyslal cie Gandalf, tak? Jesli chcesz udac sie do piramidy downa, to musisz wiedziec, ze na jej koncu czeka Nieumarly Krol krypty, oraz, ze {walka} z nim nie bedzie w zadnym wypadku latwa. Aby go przywolac, bedziesz potrzebowac kilku skladnikow. Zabierz ze soba najpotrzebniejsze rzeczy: drewno, kociol, fiolke oraz zapalniczke. Do rytualu bedziesz potrzebowac {kosci} tak plugawych, ze obnizaja dlugosc fal swiatla wokol. Do tego {sygnet} nieumarlego lorda, i {plaszcz} ze skory nieochrzczonych dzieci. Jesli zamierzasz zebrac te przedmioty, to spytaj mnie o {rytual}."
				or "Gandalf sent you hete, right? If you want to go to the down pyramid, you need to know that there is an Undead Crypt King waiting, and that {encounter} him will not be easy by any means. To summon him, you will need a few ingredients. Take the most necessary things: wood, cauldron, vial and lighter. For the ritual you will need {bones} so foul that they lower the wavelength of the light around. Plus the {signet ring} of an undead lord, and a {cloak} made of the skin of unbaptized children. If you're going to collect these items, ask me about the {ritual}.",
			npc,
			creature
		)
		npcHandler:setTopic(playerId, 3)
	elseif table.contains({ "walka", "encounter", "fight" }, message) and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say(
			getPlayerLanguage(player) == "PL"
					and 'Krol Krypty posiadl umiejetnosci z wielu dziedzin, nie tylko magii. Oprocz standardowego zestawu czarow generycznego zlodupca, takich jak przywolywanie nieumarlych i strzelanie z laserkow, potrafi on uzywac czarow z innych uniwersum. Widocznie matka nie zabraniala mu grac w WoWa jak byl maly, i teraz opanowal niektore z dostepych tam umiejetnosci. Studiowal on "nauki" goblinow, wiec potrafi napredce konstruowac bomby. Jesli dobrze kojarze, to pewnie bedziecie musieli zaslaniac te bomby swoim cialem, zeby nie wysadzily calej platformy. Ostatnia rzecz, o ktorej musisz wiedziec, to fakt, ze Krol Krypty nieustannie zwieksza zadawane przez siebie obrazenia, w zwiazku z tym niechetnie zmienia swoj aktualny cel.'
				or "The Crypt King is skilled in many areas, not just magic. In addition to the standard set of spells of a generic villain, such as summoning the undead and shooting lasers, he can use spells from other universes. Apparently his mother had allowed him to play WoW when he was little, and now he has mastered some of the skills available there. He studied the 'sciences' of goblins, so he can quickly construct bombs. If I remember correctly, you'll probably have to cover the bombs with your body so they don't blow up the entire platform. The last thing you need to know is that the Vault King is constantly increasing his damage, so he is unwilling to change his current target.",
			npc,
			creature
		)
	elseif table.contains({ "kosci", "bone", "bones" }, message) and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Na zachodzie mowia na nie Unholy Bone." or "It's called exactly as Unholy Bone.", npc, creature)
	elseif table.contains({ "sygnet", "signet", "pierscien", "seal" }, message) and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Pierscien ten przepadl gdzies, nie wiadomo gdzie. Mozliwe, ze {Grave Digger} powie ci cos wiecej o sygnecie." or "This ring has vanished somewhere, maybe {Grave Digger} will tell you more about it.", npc, creature)
	elseif table.contains({ "grave digger" }, message) and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Sprzedaje lopaty w Mirko, pewnie go kojarzysz." or "He sells equipment in Mirko, I think you know him.", npc, creature)
	elseif table.contains({ "plaszcz", "cape" }, message) and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Tylko jedna grupa zawodowa mogla sie dopuscic stworzenia czegos takiego - kultysci PiS z Sybiru." or "Only the one group could create such a thing - PiS cultists from Sybir.", npc, creature)
	elseif table.contains({ "rytual", "ritual" }, message) and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say(
			getPlayerLanguage(player) == "PL"
					and "Przed rozpoczeciem musisz wywolac trzech straznikow, ktorych szkielety blokuja dostep do miejsca rytualu. Prawdopodobnie bedziesz zmuszony ich pokonac, zeby dostac sie dalej. Aby przywolac kazdego z nich, wykazesz sie wytrwaloscia nieznanom ludziom tego swiata. Bedzie to od ciebie wymagalo posiadania czternastu roznych {efektow}. Gdzies w glebi lochow znajdziesz krag ulozony z kamieni. To wlasnie na nim odbedzie sie rytual przywolania Krola Krypty."
				or "Before you start, you must summon three guards whose skeletons are blocking access to the ritual site. You'll probably have to defeat them to get further. To summon each of them, you will show perseverance to people unknown to this world. This will require you to have fourteen different {effects}. Somewhere in the depths of the dungeons you will find a circle made of stones. It is where the ritual of summoning the Crypt King will take place.",
			npc,
			creature
		)
	elseif table.contains({ "effects", "efektow", "efekty" }, message) and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Te wiedze zdolalem wydobyc z pradawnych zbiorow w bibliotece Lubuskiej Uczelni Arcymagow. Jezeli uwazasz, ze zdolasz odczytac te zapiski - zwoj schowalem pod krzakiem obok. Aha, nie wszystkie z wymienionych tam efektow sa prawdziwe - widocznie dokument ten spisywano na kolanie."
				or "I managed to extract this knowledge from the ancient collections in the library of the Lubuska Academy of Archmages. If you think you can read these notes - I hid the scroll under the bush to the right. And remember, not all of the effects listed there are real - apparently this document was written on the knee.",
			npc,
			creature
		)
		npcHandler:setTopic(playerId, 0)
	elseif (table.contains({ "wodka", "trunek", "vodka" }, message) and player:getStorageValue(Storage.Yalahar.MiloscAriela) == 9 and player:getItemCount(6106) > 0) and player:getStorageValue(Storage.Yalahar.ZabojczyTrunek) == 2 then
		player:removeItem(6106, 1) -- zabieramy 1 wodke leszke
		player:setStorageValue(Storage.Yalahar.ZabojczyTrunek, 3)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Teraz to mozemy porozmawiac. Co cie tu sprowadza?" or "Now we can talk! Who bring you there?", npc, creature)
	elseif table.contains({ "ktos", "someone" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "W Mirko Town mieszka pewien specjalista od kopania grobow. Moze sprobuj sie od niego dowiedziec." or "In Mirkotown lives one specialist in grave digging. Try to get some information from him.", npc, creature)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ave |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ave Satan!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Ave |PLAYERNAME|.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Ave Satan!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, '...')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
