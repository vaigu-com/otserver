local internalNpcName = "Arni"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 131,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
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
	{ text = "NIE WIEM CO O TYM MYSLEC..." },
	{ text = "Jak chcesz to dam ci pewne informacje.." },
	{ text = "Kaaaasiu mam dla Ciebie kwiaaatyyy" },
	{ text = "Moim idolem jest Arnold Schwarzenegger" },
	{ text = "KTO POMALOWAL RURY?" },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "yes", "tak", "naszyjnik", "necklace" }, message) then
		if player:getStorageValue(Storage.NaPomocBagietom.BycJakSchwarzenegger) < 1 and npcHandler:getTopic(playerId) == 1 and player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna) == 6 then
			if player:getStorageValue(Storage.NaPomocBagietom.Main) < 1 then
				player:setStorageValue(Storage.NaPomocBagietom.Main, 1) -- ustawienie glownego questa
			end
			player:setStorageValue(Storage.NaPomocBagietom.BycJakSchwarzenegger, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Super." or "Great.", npc, creature)
		end
	elseif table.contains({ "mission", "misja", "pomoc", "help" }, message) then
		if player:getStorageValue(Storage.NaPomocBagietom.BycJakSchwarzenegger) == 3 then
			if player:getItemCount(7754) > 0 then
				if player:getLevel() >= 25 then
					player:removeItem(7754, 1) -- zabieramy naszyjnik
					player:setStorageValue(Storage.NaPomocBagietom.BycJakSchwarzenegger, 4) -- konczymy klesta
					player:addItem(3370, 1) -- knight armor
					player:addItem(3382, 1) -- crown legs
					player:addItem(3098, 1) -- ring of healing
					-- Q5.1
					player:addExperience(50000, true) -- 50k expa
					player:getPosition():sendMagicEffect(CONST_ME_STUN)
					-- Q5.1
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Dziekuje ci! Oooo i nawet ladnie pachnie, Madame Malkin wykonala kawal swietnej roboty. Wez to w podziece." or "Thank you! Wooah, and it smells so good, Madame Malkin did a great job. Take this as your reward.", npc, creature)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 25 poziomu!" or "Come back when you reach 25 level!", npc, creature)
				end
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc z gotowym naszyjnikiem." or "Come back with finished necklace.", npc, creature)
			end
		elseif player:getStorageValue(Storage.NaPomocBagietom.BycJakSchwarzenegger) == 1 then
			if player:getItemCount(10196) >= 5 and player:getItemCount(9685) >= 1 and player:getItemCount(10275) >= 5 then
				player:setStorageValue(Storage.NaPomocBagietom.BycJakSchwarzenegger, 2) -- wykonana misja
				-- player:removeItem(10196,10) -- zabieramy zeby -- trzeba isc do madame
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wooow, swietne. Tylko jak ja teraz to zszyje w naszyjnik.. Znajdz prosze osobe, ktora z tych zebow uplecie naszyjnik. Bede bardzo wdzieczny." or "Thats awesome! Only if I knew how to make a necklace of that.. Please, find someone that will be able  to weave one of those teeths. I would be really greateful.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Wroc z tym o co prosilem." or "Come back with what I asked for.", npc, creature)
			end
		elseif player:getStorageValue(Storage.TheaterOfCheapThrills.Questline) == 16 and player:getStorageValue(Storage.NaPomocBagietom.BycJakSchwarzenegger) == 4 then
			player:setStorageValue(Storage.TheaterOfCheapThrills.Questline, 17)
			player:setStorageValue(Storage.TheaterOfCheapThrills.Mission06, 3)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Okej, zaltawione. Przekaz Kitzowi, zeby nie bral ze soba nic poza pizama." or "Okay, done. Tell Kitz not to bring anything but pajamas.", npc, creature)
		elseif player:getStorageValue(Storage.NaPomocBagietom.BycJakSchwarzenegger) < 1 then
			if player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna) == 6 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Misja? Sam bym pojechal na jakas misje, jak Schwarzenegger. On to byl gosc, wygladam tez tak pakersko jak on? ...",
					"Jesli chcesz mi pomoc, to mozesz wyswiadczyc dla mnie przysluge. Nie moge sie stad ruszyc, a brakuje mi paru rzeczy, by byc jeszcze wiekszym kozakiem. ...",
					"Zawsze chcialem przyszpanowac zebowym naszyjnikiem. Potrzebowal bym do niego z 5 zebow orkow, 5 rotwormowych i moze jakies wampirze. Zdobedziesz je dla mnie?",
				} or {
					"Mission? I would love to go on some mission, like Schwarzenegger did. He was the man. Do you think that I look as jacked as he did? ...",
					"If you want to help me, you can do me a favour. Unfortunately, I can't leave this place and I miss a few things to be even a bigger badass. ...",
					"I always wanted to show off with my teeth necklace. I need 5 orc teeth,  5 rotworm teeth and maybe some of the vampire. Would you get them for me?",
				}, npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif player:getStorageValue(Storage.TheaterOfCheapThrills.Questline) == 16 and message ~= "pomoc" and message ~= "help" then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Moge go zapisac na oboz, ale jak to mowie: przysluga za przysluge. Najpierw pomoz mi zdobyc naszyjnik, a ja pomoge ci z wycieczka." or "I can sign him up for camp, but as I say, favor for favor. First, help me get the necklace, and I'll help you with the trip.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Najpierw pomoz Komisarzowi Rybie, na te chwile nie jestem w stanie ci zaufac." or "Help Commissioner Fisher first, I cant trust you now.", npc, creature)
			end
		end
		-- ============= MISJA TRUDNE POCZATKI =================
	elseif table.contains({ "informacje", "informacja", "informations" }, message) then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Opuszczajac podmiejska wioske Mirkowo musisz uwazac na gory osiedlone przez cyklopy na zachodzie. Daleko na poludniu znajduja sie fortece orkow oraz elfow ktore nieustannie wojuja. Trzymajac sie drogowskazow dojdziesz do obozu mysliwych."
				or "Leaving suburban village Mirkowo you need to be aware of mountains inhabited by cyclops to the east. Far to the south, behind swamp there is orc and elven fortress. Following sings to the east you'll find village of hunters.",
			npc,
			creature
		)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hej |PLAYERNAME|. Jak nie wiesz co jest za brama, to moge ci sprzedac te {informacje}. Mozesz mi takze w czyms {pomoc}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Do widzenia!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Odmeldowuje sie...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. I can tell you {informations} about whats behind the gates. You can also {help} me with something..')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
