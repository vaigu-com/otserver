local internalNpcName = "Ocellatus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 136,
	lookHead = 116,
	lookBody = 94,
	lookLegs = 94,
	lookFeet = 0,
	lookAddons = 0,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	-- ============= Bilety na mecz =================
	if table.contains({
		"zupe rotwormowa",
		"pieczone smocze skrzydelka",
		"rotworm stew",
		"roasted dragon wings",
	}, message) and player:getStorageValue(Storage.OskareKXddd.Bilety) == 4 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie wiem, czy nadal je przyrzadzaja. Jak co to podpytaj Piotrka, kiedys robil w maku." or "I don't know if they make those still. You can ask Piotr, he used to work in MC backdays.", npc, creature)
	elseif MsgContains(message, "yes") or MsgContains(message, "tak") then
		if player:getStorageValue(Storage.OskareKXddd.Bilety) < 1 and npcHandler:getTopic(playerId) == 1 then
			player:setStorageValue(Storage.OskareKXddd.Bilety, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Uciekli gdzies na wschod. Mozliwe, ze chowaja sie w jakims obozie. ...",
				"Jesli go zdobedziesz i mi oddasz, na pewno sie jakos odwdziecze.",
			} or {
				"They ran away somewhere to the east. They're probably hiding in some kind of camp. ...",
				"If you get it and give it back to me, I will pay you back somehow.",
			}, npc, creature)
		end
		if player:getStorageValue(Storage.OskareKXddd.Bilety) == 3 and npcHandler:getTopic(playerId) == 2 then
			player:setStorageValue(Storage.OskareKXddd.Bilety, 4)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Uwielbiam {zupe rotwormowa}, oraz {pieczone smocze skrzydelka} z maka. Jak mi ogarniesz, to na pewno sie odwdziecze." or "I love {rotworm stew} and {roasted dragon wings} from MC. If you make this for me, I will certainly pay back.", npc, creature)
		end
	elseif table.contains({ "mission", "misja", "misje" }, message) then
		if player:getStorageValue(Storage.OskareKXddd.Bilety) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Pewnie nie jestes takim fanem jak ja, ale chcialem wybrac sie na {mecz}. Ktos mi jednak pokrzyzowal plany." or "You are probably not a football fan like me, but I wanted to go to the {match}. However, someone thwarted my plans.", npc, creature)
		elseif player:getStorageValue(Storage.OskareKXddd.Bilety) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Mam nadzieje, ze uda ci sie odnalezc ten bilet." or "I hope that you'll find this ticket.", npc, creature)
		elseif player:getStorageValue(Storage.OskareKXddd.Bilety) == 2 then
			if player:getItemCount(28818) > 0 then
				if player:getLevel() >= 20 then
					player:setStorageValue(Storage.OskareKXddd.Bilety, 3)
					player:removeItem(28818, 1) -- zabieramy bilet
					player:addExperience(30000, true) -- 30k expa
					player:getPosition():sendMagicEffect(CONST_ME_STUN)
					npcHandler:say(getPlayerLanguage(player) == "PL" and {
						"Dzieki wielkie, nie moge doczekac sie meczu. Jest jednak cos jeszcze, siedze na tym wypizdowiu, i konczy mi sie zarcie. ...",
						"Ogarnal bys mi jakies zamowienie, o ktore cie poprosze?",
					} or {
						"Thanks a lot! Can't wait to see the match. But there's something more, I'm stuck on this shithole and running low on food. ...",
						"Would you take care of some food order that I would request?",
					}, npc, creature)
					npcHandler:setTopic(playerId, 2)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 20 poziomu!" or "Come back when you reach 20 level!", npc, creature)
				end
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc jak odnajdziesz bilet." or "Come back when you find the ticket.", npc, creature)
			end
		elseif player:getStorageValue(Storage.OskareKXddd.Bilety) == 3 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Siedze ciagle na tym wypizdowiu, i konczy mi sie zarcie. ...",
				"Ogarnal bys mi jakies zamowienie, o ktore cie poprosze?",
			} or {
				"I'm all the time in this shithole, and I'm running out of food. ...",
				"Would you take care of some food order that I would request?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.OskareKXddd.Bilety) == 4 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "I co, ogarnales {zarcie}? {Zupe rotwormowa}, oraz {pieczone smocze skrzydelka} z maka tak jak prosilem." or "And? Did u get any {food}? {rotworm stew}, oraz {roasted dragon wings} from MC like I asked.", npc, creature)
		elseif player:getStorageValue(Storage.OskareKXddd.Bilety) == 5 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "To tyle, dzieki za twoja pomoc." or "That's all, thanks for your help.", npc, creature)
		end
	elseif table.contains({ "mecz", "legia", "match" }, message) then
		if player:getStorageValue(Storage.OskareKXddd.Bilety) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "No tak, mialem isc na mecz legii, ale przyszli onrowcy i podjebali mi bilet. Pomozesz mi go odzyskac?" or "Well, I was supposed to go to the Legia Warszawa match, but the nationalists came and they rip off my ticket. Could you help me get it back?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
		-- ============= MISJA TRUDNE POCZATKI =================
	elseif table.contains({ "zupa", "skrzydelka", "zarcie", "food" }, message) and player:getStorageValue(Storage.OskareKXddd.Bilety) == 4 then
		if player:getItemCount(9081) > 0 and player:getItemCount(9079) > 0 then
			player:setStorageValue(Storage.OskareKXddd.Bilety, 5)
			player:setStorageValue(Storage.Finished.Oskarek, 1) -- quest done (website)
			player:removeItem(9081, 1) -- zabieramy zarcie
			player:removeItem(9079, 1) -- zabieramy zarcie
			player:addOutfitAddon(619, 0) -- jersey outfit
			player:addOutfitAddon(620, 0) -- jersey outfit
			player:addExperience(150000, true) -- 50k expa
			player:getPosition():sendMagicEffect(CONST_ME_STUN)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Zajebiscie, dzieki. Mozesz poplywac sobie moja lodka jesli chcesz, oraz wez to przebranko legii, na mnie i tak za maly rozmiar." or "Fantastic, thanks! You can use my boat whenever you want and take this Legia T-shirt. The size doesn't fit me anyway.", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc jak ogarniesz zarelko." or "Come back with the food.", npc, creature)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Heja, jak sie masz xD Wybierasz sie moze takze na mecz? Moze to smiesznie zabrzmi ale mam pewna {misje}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Nara xD")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello how are you xD Are you also going to a fooball match? It may sound funny, but I have some {mission} for you.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Bye xD')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
