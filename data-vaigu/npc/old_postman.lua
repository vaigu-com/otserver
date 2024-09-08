local internalNpcName = "Old Postman"
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
	lookHead = 20,
	lookBody = 39,
	lookLegs = 45,
	lookFeet = 7,
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Przesylki kurierskie z Aliexpress tanio !" },
	{ text = "Przez te internety ludzie wysylaja coraz mniej listow..." },
	{
		text = "U mnie zaplacisz rowniez rachunki, jak i zakupisz paczke oraz list",
	},
	{
		text = "Trzeba przemyslec czy nie lepiej udac sie na emigracje... Interes slabiej sie kreci coraz mniejsze obroty",
	},
	{
		text = "Mam juz dosc wciskania ludziom tych zniczy na Wszystkich Swietych, kochany kierownik...",
	},
}

local config = nil
local lang_to_config = {
	["PL"] = {
		[1] = {
			"A wiec Madame Malkin dalej nie chce sie zgodzic na spotkanie z Arielem.. mam pewien pomysl. Nie spodoba sie on Arielowi, ale nie musi sie o tym dowiedziec. ...",
			"Na polnoc od miasta znajduje sie wioska alchemikow. Podobno maja tam laboratorium, w ktorym ostatnio wywarzyli eliksir milosci. Sprobuj wykrasc eliksir, a powiem ci co dalej.",
		},
		[2] = {
			"Skoro przyniosles eliksir, to teraz musimy zdobyc wlos ariela, aby go w nim rozpuscic. Najwazniejsze, zeby Ariel nie dowiedzial sie co planujemy. ...",
			"Idz do niego i poszukaj wlosow w jego lozku, na pewno cos tam znajdziesz. Nastepnie przekaz Madame mikstrure, jako wino ode mnie.",
		},
		[3] = "Jest cos, z czym potrzebuje pomocy. Jedna z ostatnich paczek od mnichow gdzies zaginela. Prawdopodobnie utknela, plynac {szlakiem} wodnym.",
		[4] = "Czego ty ode mnie chcesz? Lepiej zamelduj sie u Komisarza Ryby..",
		[5] = "Szlak wodny zaczyna sie od ich skalki na zachodzie. Potem plynie pod mostem, przechodzi obok foretecy orkow, i wpada do wiekszego jeziora. Z tego jeziora plynie do Syna Wedkarza. Gdzies na tej drodze wodnej utknela moja przesylka.",
		[6] = "Czy udalo ci sie znalezc moja {przesylke}?",
		[7] = "Ten parcel spoznial sie juz kilka tygodni i juz sie obawialem, ze alibaba probowal mnie wydymac. Oto twoja nagroda za pomoc. W srodku znalazlem cos, co zamawial Stary Anona, to chyba {zaneta} dla ryb. Jezeli masz po drodze, to mu ja zanies. Na pewno sie odwdzieczy.",
		[8] = "Wroc, gdy znajdziesz moja przesylke.",
		[9] = "Prosze, oto ta puszka. Stary anona kreci sie przy oczku wodnym obok {koszarow}.",
		[10] = "Czy moglbys zaniesc ten pakunek do Starego Anona? Na pewno sie niecierpliwi, wiec nagrodzi cie za twoja pomoc.",
		[11] = "Koszary Komisarza Ryby znajduja sie w poludniowo-zachodniej czesci miasta. Sam Cie tu przyslal, pijany jestes?",
	},
	["EN"] = {
		[1] = {
			"So Madame Malkin still doesn't want to accept a meeting with Ariel... I have an idea. Ariel won't like it but he doesn't have to know anything. ...",
			"In the north of the city, there is a village of alchemists. Apparently, they have a laboratory there in which they created love elixirs. Try to steal it, and I will tell you what's next.",
		},
		[2] = {
			"If we have an elixir, we don't need to get Ariel's hair to dissolve it in it...",
			"Go to him and look for his hair in his bed, there must be something. Next, give Madame the love elixir as wine from me.",
		},
		[3] = "There's something I need help with. One of the recent packages from the monks has gone missing. It probably got stuck while flowing along the {route} waterway.",
		[4] = "What do you want from me? Better visit Commissioner Fisher first.",
		[5] = "The waterway begins at their rock to the west. Then it flows under the bridge, passes by the orc fortress, and enters a larger lake. From that lake, it flows to the Syn Anona. Somewhere along this waterway, my shipment got stuck.",
		[6] = "Were you able to find my {shipment}?",
		[7] = "This parcel was delayed for a few weeks, and I was beginning to worry that alibaba was trying to trick me. Here's your reward for your help. I found something inside that Stary Anona ordered, probably a {bait} for fish. If you're passing by, deliver it to him. He will surely reward you.",
		[8] = "Come back when you find my shipment.",
		[9] = "Here, please, this box. Old Anona hangs around the pond near the {barracks}.",
		[10] = "Could you take this package to Old Anona? He's surely getting impatient, so he'll reward you for your help.",
		[11] = "Commissioner Fisher's barracks are in the southwest part of the city. He sent you here himself, are you drunk?",
	},
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	config = GetConfigByPlayer(creature, lang_to_config)

	if table.contains({
		"zaproszenie",
		"madame",
		"mission",
		"ariel",
		"invitation",
	}, message) and player:getStorageValue(Storage.Yalahar.MiloscAriela) == 3 then
		player:setStorageValue(Storage.Yalahar.MiloscAriela, 4)
		local item = player:addItem(2874, 1)
		if item then
			item:transform(2874, 0)
		end
		npcHandler:say(config[1], npc, creature)
	elseif table.contains({ "eliksir", "madame", "mission", "mikstura", "elixir" }, message) and player:getStorageValue(Storage.Yalahar.MiloscAriela) == 5 then
		player:setStorageValue(Storage.Yalahar.MiloscAriela, 6)
		npcHandler:say(config[2], npc, creature)
	elseif table.contains({ "pomoc", "help" }, message) and player:getStorageValue(Storage.TrudnePoczatki.PostmanAsked) < 1 then
		if player:getStorageValue(Storage.TrudnePoczatki.Rozeznanie) >= 2 then
			player:setStorageValue(Storage.TrudnePoczatki.PostmanAsked, 1) -- lockujemy postmana jako wykonanego
			player:setStorageValue(Storage.TrudnePoczatki.Rozeznanie, player:getStorageValue(Storage.TrudnePoczatki.Rozeznanie) + 1) -- +1 zeby kolejnosc nie miala znaczenia
			player:setStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain, 1) -- rozpoczecie biodegradowalny
			npcHandler:say(config[3], npc, creature)
		else
			npcHandler:say(config[4], npc, creature)
		end
	elseif table.contains({ "szlakiem", "pass", "route" }, message) and player:getStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain) == 1 then
		npcHandler:say(config[5], npc, creature)
	elseif table.contains({ "misja", "mission", "przesylka", "parcel" }, message) and player:getStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain) == 1 then
		npcHandler:say(config[8], npc, creature)
	elseif table.contains({ "misja", "mission" }, message) and player:getStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain) == 2 then
		npcHandler:say(config[6], npc, creature)
	elseif table.contains({
		"przesylke",
		"parcel",
		"shipment",
		"paczka",
		"yes",
		"tak",
	}, message) and player:getStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain) == 2 then
		local item = player:getItemById(3504, 1)
		if item and item.actionid == 11085 then
			item:remove()
			npcHandler:say(config[7], npc, creature)
			player:setStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain, 3)
			player:addExperience(15000, true) -- 15k expa
			player:addItem(7290, 1) -- shard
		else
			npcHandler:say(config[8], npc, creature)
		end
	elseif table.contains({ "misja", "mission" }, message) and player:getStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain) == 3 then
		npcHandler:say(config[10], npc, creature)
	elseif table.contains({ "zaneta", "bait", "yes", "tak" }, message) and player:getStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain) == 3 then
		npcHandler:say(config[9], npc, creature)
		player:setStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain, 4)
		player:setStorageValue(Storage.UstatkowanyFanatyk.Zastoj, 1)
		player:AddCustomItem({ id = 15817, aid = 11086, addToStore = true }) 
	elseif table.contains({ "koszary", "koszarow", "barracks" }, message) and player:getStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain) == 4 then
		npcHandler:say(config[11], npc, creature)
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Uszanowanie, |PLAYERNAME|. Roznosze listy i paczki, a w wolnym czasie opisuje historie z pracy. Jesli chcesz cos kupic, napisz {trade}.")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello, |PLAYERNAME|. I am local postman, ask about {trade} if you want to buy some parcel or letter.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "parcel", clientId = 3503, buy = 15 },
	{ itemName = "letter", clientId = 3505, buy = 10 },
	{ itemName = "label", clientId = 3507, buy = 1 },
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
