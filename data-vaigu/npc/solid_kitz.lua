local internalNpcName = "[SOLID] Kitz"
local npcType = Game.createNpcType("Solid Kitz")
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 512,
	lookHead = 114,
	lookBody = 49,
	lookLegs = 125,
	lookFeet = 0,
	lookAddons = 1,
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

	-- ============= Fan Arnolda =================
	if table.contains({ "mission", "misja", "pomoc", "help" }, message) and player:getStorageValue(Storage.NaPomocBagietom.DominandoKitza) == 2 and player:getItemCount(9378) > 0 then
		if player:getLevel() >= 20 then
			player:setStorageValue(Storage.NaPomocBagietom.DominandoKitza, 3) -- wykonana misja
			player:removeItem(9378, 1) -- zabieramy musician's bow
			player:addItem(19362, 1) -- icicle bow
			player:addExperience(50000, true) -- 50k expa
			player:getPosition():sendMagicEffect(CONST_ME_STUN)
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"To jest ten luk? Chyba mnie te elfy w chuja zrobily, zrobie im takie Dominando... ...",
				"Ale dzieki, wypelniles swoja misje, trzymaj w podziece moj poprzedni luk.",
			} or {
				"Is that THIS bow? I guess elfs made a joke off me. I will make them dominando... ...",
				"But thanks, you finished your mission. Here, keep my old bow in return.",
			}, npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 20 poziomu!" or "Come back when you reach 20 level!", npc, creature)
		end
	elseif table.contains({ "mission", "misja", "pomoc", "help" }, message) and player:getStorageValue(Storage.NaPomocBagietom.DominandoKitza) < 1 then
		if player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna) == 6 then
			if player:getStorageValue(Storage.NaPomocBagietom.Main) < 1 then
				player:setStorageValue(Storage.NaPomocBagietom.Main, 1) -- ustawienie glownego questa
			end
			player:setStorageValue(Storage.NaPomocBagietom.DominandoKitza, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Zamowilem u elfow specjalny luk, zebym mogl robic swoje Dominando. ...",
				"Nie moge sie tam jednak wybrac. Postaraj sie prosze samemu go zalatwic, i mi przekazac.",
			} or {
				"I have ordered a special bow from the Elves to make my dominando. ...",
				"However, I could not go there. Could you please get it and bring it to me.",
			}, npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Najpierw pomoz Komisarzowi Rybie, na te chwile nie jestem w stanie ci zaufac." or "Help Commissioner Fisher first, I cant trust you now.", npc, creature)
		end
	elseif table.contains({
		"pyjamas",
		"pajamas",
		"pizama",
		"wycieczka",
		"camp",
		"oboz",
	}, message) and player:getStorageValue(Storage.TheaterOfCheapThrills.Questline) == 17 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Hmm, to na pewno zwykly oboz?" or "Hmm, are you sure it's just a regular camp?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "yes", "tak" }, message) and player:getStorageValue(Storage.TheaterOfCheapThrills.Questline) == 17 and npcHandler:getTopic(playerId) == 1 then
		player:setStorageValue(Storage.TheaterOfCheapThrills.Questline, 18)
		player:setStorageValue(Storage.TheaterOfCheapThrills.Mission06, 4)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Okej, w takim razie przekaz staremu, ze chetnie sie tam udam." or "Okay, then tell Arni I'd love to go there.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "no", "nie" }, message) and player:getStorageValue(Storage.TheaterOfCheapThrills.Questline) == 17 and npcHandler:getTopic(playerId) == 1 then
		player:setStorageValue(Storage.TheaterOfCheapThrills.Questline, 18)
		player:setStorageValue(Storage.TheaterOfCheapThrills.Mission06, 4)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Coo? To oboz koncentracyjny? Co ty odbialczasz? Skoro chcial tak mnie urzadzic, to bede sie trzymac z daleka od starego." or "What? Is it a concentration camp? Are you crazy? If that's what he wanted to do to me, I'll stay away from him.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "informacja", "informacje", "informations" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Na wschod jest cmentarz Mirkotown i za woda wieza tajemniczego maga. Przedzierajac sie przez bagna na poludniu dojdziesz do obozu mysliwych." or "To the east of Mirkotown is a graveyard and past the water a mystery wizard's tower. Going through a swamp on the south you will make it to the hunter's camp.", npc, creature)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hej |PLAYERNAME|. Jak nie wiesz co za brama to ci moge sprzedac te {informacje}. Zechcesz mi moze {pomoc}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Do widzenia!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Odmeldowuje sie...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. I can tell you {informations} about whats behind the gates. You can also {help} me with something..')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
