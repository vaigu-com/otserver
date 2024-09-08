local internalNpcName = "Cordell Walker"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 289,
	lookHead = 96,
	lookBody = 78,
	lookLegs = 114,
	lookFeet = 97,
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
	{ text = "Mam pewne ciekawe informacje o tutejszym terenie..." },
	{ text = "Moim glownym towarem eksportowym jest bol." },
	{ text = "Gdybym jadl wegiel, sralbym diamentami." },
	{ text = "Ochronie ta czesc mirko przed bandytami kopem z polobrotu." },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "mission", "misja", "misje" }, message) then
		if player:getStorageValue(Storage.NaPomocBagietom.KopniakZPolobrotu) == 3 then
			if player:getItemCount(22160) > 0 then
				if player:getLevel() >= 40 then
					player:removeItem(22160, 1) -- zabieramy Liste
					player:setStorageValue(Storage.NaPomocBagietom.KopniakZPolobrotu, 4) -- konczymy klesta
					player:addItem(9103, 1) -- Batwing Hat
					player:addItem(6299, 1) -- Death ring
					-- Q5.1
					player:addExperience(100000, true) -- 100k expa
					player:getPosition():sendMagicEffect(CONST_ME_STUN)
					-- Q5.1
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Trzymaj w nagrode ten kapelusz, szepne o tobie slowko komisarzowi." or "Keep this hat as your reward. I'll whisper a word about you to our Commissar.", npc, creature)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 40 poziomu!" or "Come back when you reach 40 level!", npc, creature)
				end
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Chyba zapomniales listu." or "I think you may forgot about waybill.", npc, creature)
			end
		elseif player:getStorageValue(Storage.NaPomocBagietom.KopniakZPolobrotu) == 1 then
			if player:getItemCount(22160) > 0 then
				if player:getStorageValue(Storage.NaPomocBagietom.ListaWzieta) == 1 then
					player:setStorageValue(Storage.NaPomocBagietom.KopniakZPolobrotu, 2)
					npcHandler:say(getPlayerLanguage(player) == "PL" and {
						"Udalo ci sie wtargnac tam, niezle. Ale co to za jezyk? Wydaje mi sie znajomy i wiem kto bedzie umial go przetlumaczyc. ...",
						"Podpytaj mojego znajomego, ktory pracuje w Prince Kebab w Hurghadzie.",
					} or {
						"You managed to get in there, great. Hmm, but what's this language? I think that I know someone that will be able to translate it. ...",
						"You should ask my close friend Shivganesh, who works in Prince Kebab in Hurghada.",
					}, npc, creature)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "No co ty, to jakas podroba." or "You need to find original one.", npc, creature)
				end
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Przynies do mnie list przewozowy." or "I think you may forgot about waybill.", npc, creature)
			end
		elseif player:getStorageValue(Storage.NaPomocBagietom.KopniakZPolobrotu) < 1 then
			if player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna) == 6 then
				if player:getStorageValue(Storage.NaPomocBagietom.Main) < 1 then
					player:setStorageValue(Storage.NaPomocBagietom.Main, 1) -- ustawienie glownego questa
				end
				player:setStorageValue(Storage.NaPomocBagietom.KopniakZPolobrotu, 1)
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"Oczywiscie, ze mam dla ciebie misje. Zostaniesz straznikiem z MirkoTown, tak jak ja. ...",
					"Ostatnio dochodza mnie sluchy o jakichs nielegalnych interesach w wiosce bandytow. Ktos chyba dawno nie dostal z polobrotu. ...",
					"Sprawdz to, wioska znajduje sie na wschodzie. Podobno prowadza przemyt w swoich podziemiach.",
				} or {
					"Of course I have a mission for you. You will become the soldier of MirkoTown, like I am. ...",
					"Recently, I have heard of some illegal business in a bandit village. Someone has not gotten fucked around for a long time. ...",
					"Check it out, the village is to the east. Apparently they are smuggling in their basement.",
				}, npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Najpierw pomoz Komisarzowi Rybie, na te chwile nie jestem w stanie ci zaufac." or "Better visit Commissioner Fisher first. I can't trust you now.", npc, creature)
			end
		end
	elseif table.contains({ "informacja", "informacje" }, message) then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Na polnoc od miasta znajduje sie kopalnia, na zachod od niej znajduje sie forteca orkow, oraz upiorne miasto. Na wschodzie znajduja sie leza smokow oraz oboz minotaurow. Jest tam tez przejscie w dalsza czesc kontynentu."
				or "To the north of the city is a mine, to the west is an orc fortress, and a ghostly city. To the east are the dragon's lair and the minotaur's camp. There is also a passage to the rest of the continent.",
			npc,
			creature
		)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hej |PLAYERNAME|. Jak nie wiesz co za brama to ci moge sprzedac te {Informacje}. Mam takze pewna {misje} dla ciebie.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Do widzenia!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Odmeldowuje sie...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. I can tell you {informations} about whats behind the gates. You can also take some {mission} from me..')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you...')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
