local internalNpcName = "Oldrak"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 150
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 57,
	lookHead = 115,
	lookBody = 113,
	lookLegs = 31,
	lookFeet = 38,
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

keywordHandler:addKeyword({ "name" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "My name is Oldrak.",
})
keywordHandler:addKeyword({ "tibia" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "That's where we are. The world of Tibia.",
})
keywordHandler:addKeyword({ "offer" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "I can offer you the holy tible for a small fee.",
})
-- keywordHandler:addKeyword({'trade'}, StdModule.say, {npcHandler = npcHandler, text = "I can offer you the holy tible for a small fee."})
keywordHandler:addKeyword({ "sell" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "I can offer you the holy tible for a small fee.",
})
keywordHandler:addKeyword({ "buy" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "I can offer you the holy tible for a small fee.",
})
keywordHandler:addKeyword({ "time" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Now, it is |TIME|.",
})

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "mission", "demon oak", "misja", "demoniczny dab" }, message) then
		if player:getStorageValue(Storage.DemonOak.Done) < 1 and player:getStorageValue(Storage.DemonOak.Progress) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Skad o tym wiesz? Wszedles do zarazonej strefy?" or "How do you know? Did you go into the infested area?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.DemonOak.Progress) == 2 and player:getStorageValue(Storage.DemonOak.Done) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Lepiej tu nie wracaj, nim nie pokonasz Demonicznego Debu. Chyba, ze zapomniales kupic {topor}?" or "You better don't return here until you've defeated the Demon Oak.", npc, creature)
		elseif player:getStorageValue(Storage.DemonOak.Done) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Znieszczyles demoniczny dab?!? Niesamowite!! Miejmy nadzieje, ze nie powroci. Do poki ziemia przesiaknieta bedzie zlem, nie mozemy byc pewni wygranej. Mimo wszystko demony poniosly strate, to pewne. ...",
				"Dzieki twojemu poczynaniu, wyjawie ci sekret, ktory byl ukrywany przez dziesiatki lat. Musisz udac sie na elficki cmentarz, kilka minut drogi na poludnie od Mirko Town. Na jednym z grobow napisane jest 'Grdhor Faelyn' czy cos takiego. ...",
				"Nalezy on do jednego z zasluzonych elfow, ktory polegl na wojnie z orkami. Grob prowadzi do skarbca, gdzie znajduje sie dobytek kilku pokolen jego rodu. Zasluzyles aby przygarnac jeden z przedmiotow, ktore sie tam znajduja. Powodzenia w poszukiwaniu!",
			} or {
				"You chopped down the demon oak?!? Unbelievable!! Let's hope it doesn't come back. As long as evil is still existent in the soil of the plains, it won't be over. Still, the demons suffered a setback, that's for sure. ...",
				"For your brave action, I tell you a secret which has been kept for many many years. There is an old cemetery in the south east from elvish court, far south from Mirko Town. There should be a grave with the name 'Grdhor Faelyn' somewhere. ...",
				"Someone can gain the treasure hidden in there. I'm sure this 'someone' is you. Good luck in finding it!",
			}, npc, creature)
			player:setStorageValue(Storage.DemonOak.Progress, 4)
			player:setStorageValue(Storage.DemonOak.Done, 2)
			player:addOutfitAddon(542, 2)
			player:addOutfitAddon(541, 2)
		elseif player:getStorageValue(Storage.AssassinsCreedSquurvaali.Mission01) == 2 then
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "Rozumiem. Musisz udac sie na karaiby, a stamtad, z najwyzszej gory, {poleciec} prosto na zachod. Jezeli nie zwatpisz, to dolecisz do Skurva'ali. Tam powiniennes spotkac Aunora, on na pewno ci pomoze."
					or "I understand. You need to go to the Caribbean Island, and from there, from the highest mountain, {fly} straight west. If you don't lose your way, you'll reach Squurva'ali. There you should meet Aunor, he will definitely help you.",
				npc,
				creature
			)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Aktualnie nie mam zadnej misji dla ciebie." or "Currently I dont have any mission for you.", npc, creature)
		end
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 1 then
		if player:getStorageValue(Storage.DemonOak.Progress) == 1 then
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "Demoniczny Dab?!? Niech bogowie maja nas w opiece. Potrzebowal bedziesz {hallowed axe} aby pokonac to drzewo. Przynies mi zwykle {axe} a przygotuje je specjalnie dla ciebie." or "A demon oak?!? <mumbles some blessings> May the gods be on our side. You'll need a {hallowed axe} to harm that tree. Bring me a simple {axe} and I'll prepare it for you.",
				npc,
				creature
			)
			player:setStorageValue(Storage.DemonOak.Progress, 2)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie wierze w to! Jak smiesz oszukiwac mnicha!" or "I don't believe a word of it! How rude to lie to a monk!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif table.contains({ "axe", "topor" }, message) then
		if player:getStorageValue(Storage.DemonOak.Progress) == 2 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Masz przy sobie topor?. Moge zrobic z niego hallowed axe. Zaplacisz mi za to... hmm... 1,000 zlota. W porzadku?" or "Ahh, you've got an axe. Very good. I can make a hallowed axe out of it. It will cost you... er... a donation of 1,000 gold. Alright?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Musimy porozmawiac o {demon oak} lub {mission} nim kontynuujemy." or "You have to first talk about {demon oak} or the {mission} before we continue.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 2 then
		if player:getStorageValue(Storage.DemonOak.Progress) == 2 then
			if player:getMoney() >= 1000 then
				if player:removeItem(3274, 1) and player:removeMoney(1000) then
					npcHandler:say(
						getPlayerLanguage(player) == "PL" and "Zobaczmy... o prosze. Blogoslawienstwa tego topora powinny pochlaniac zla energie. Nie wiem jak dlugo wytrzymaja, wiec lepiej sie pospiesz. Moge zaczarowac go ponownie kiedy tylko zechcesz."
							or "Let's see....<mumbles a prayer>....here we go. The blessing on this axe will be absorbed by all the demonic energy around here. I presume it will not last very long, so better hurry. Actually, I can refresh the blessing as often as you like.",
						npc,
						creature
					)
					player:addItem(919, 1)
					Npc():getPosition():sendMagicEffect(CONST_ME_YELLOWENERGY)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz zadnego topora." or "There is no axe with you.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie posiadasz wystrarzcajaco pieniedzy." or "There is not enough of money with you.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif table.contains({ "no", "nie" }, message) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Daj znac jesli sie tam dostaniesz. Moze pomoge ci jesli dowiem sie z czym mamy do czynienia." or "What a pity! Let me know when you managed to get in there. Maybe I can help you when we know what we are dealing with.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "no", "nie" }, message) and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie to nie." or "No, then.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "poleciec", "fly" }, message) then
		if player:getStorageValue(Storage.AssassinsCreedSquurvaali.Mission01) == 2 then
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "Jako zwykly smiertelnik, bedziesz potrzebowal do tego magicznego dywanu. Musi to byc koniecznie dywan, ktory potrafi unosic sie bardzo wysoko nad ziemia. Ludzie potrafia produkowac tylko jeden dywan {zdolny} do takich lotow: Zielony Zaczarowany Kobiezec."
					or "As a mere mortal, you will need a magical carpet for this. It must be a carpet that can float very high above the ground. Humans can produce only one carpet {capable} of such flights: the enchanted carpet of the green one.",
				npc,
				creature
			)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Co ty bredzisz." or "What? Go away.", npc, creature)
		end
	elseif table.contains({ "zdolny", "capable" }, message) then
		if player:getStorageValue(Storage.AssassinsCreedSquurvaali.Mission01) == 2 then
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "Zwykle dywany za 900 rubli potrafia unosic sie tylko pare metrow nad ziemia. Zielony dywan potrafi uniesc sie znacznie wyzej, gdy jest na specjalnej sciezce. Ja nie potrafie wytworzyc takiego dywanu, i niestety nie wiem czy na tym swiecie zyje ktos kto moze ci pomoc."
					or "Ordinary carpets for 900 rubles can only lift a few meters above the ground. The green carpet, however, can lift itself much higher when it's on a special path. I am unable to create such a carpet, and unfortunately, I don't know if there's anyone in this world who can help you with that.",
				npc,
				creature
			)
			player:setStorageValue(Storage.AssassinsCreedSquurvaali.Questline, 3)
			player:setStorageValue(Storage.AssassinsCreedSquurvaali.Mission01, 3)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Co ty bredzisz." or "What? Go away.", npc, creature)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj, |PLAYERNAME|! Ostatnio rzadko ktos mnie odwiedza.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Uwazaj na siebie.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Zegnaj, |PLAYERNAME|!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello, |PLAYERNAME|! Recently rarely someone visits me here.')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'Take care of yourself.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye, |PLAYERNAME|!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = { { itemName = "the holy tible", clientId = 2836, buy = 1000 } }
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
