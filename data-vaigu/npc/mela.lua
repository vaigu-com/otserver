local internalNpcName = "Janek Mela"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 323,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{
		text = "Posiadam wiele przedmiotow, ale czy mam wszystkie? Nogi sobie nie dam za to uciac...",
	},
	{ text = "Od reki wymienisz u mnie wiele rzeczy, zapraszam serdecznie..." },
	{
		text = "Oby tylko nie przyszla burza wraz z deszczem bo juz nie mam gdzie sie schowac..",
	},
	{ text = "Polecam zapoznac sie z moja oferta !" },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "help", "przedmioty", "przedmiot", "items" }, message) then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Moge sie z Toba zamienic. W moim asortymencie jest {enchanted chicken wing}, {spirit container}, {flask of warrior's sweat}, {spool of yarn}, {huge chunk of crude iron}, {piece of royal steel}, {piece of hell steel}, {piece of draconian steel} oraz {magic sulphur}. Powiedz, ktory przedmiot Cie interesuje."
				or "I can exchange some items with you. For example: {enchanted chicken wing}, {spirit container}, {flask of warrior's sweat}, {spool of yarn}, {huge chunk of crude iron}, {piece of royal steel}, {piece of hell steel}, {piece of draconian steel} and {magic sulphur}. Tell me what item are you interested in.",
			npc,
			creature
		)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({
		"enchanted chicken wing",
		"chicken wing",
		"wing",
		"boots of haste",
		"boh",
	}, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Czy masz ze soba buty predkosci? Za nic innego nie oddam tego zaczarowanego piora." or "Do you have boots of haste with you?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "spirit container", "spirit", "container" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Masz ze soba dwa helmy z krolewskiej armii - {royal helmet}?" or "Do you have royal helmet with you?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({
		"flask of warrior's sweat",
		"flask of warriors sweat",
		"warriors sweat",
	}, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Lubie zbierac helmy i rozne zbroje... Chcialbym dodac do swojej kolekcji cztery helmy, czesto uzywane przez wojownikow - {warrior helmet}. Jestes w ich posiadaniu?" or "Do you have warrior helmet with you?", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif table.contains({ "spool of yarn", "spool", "yarn" }, message) then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Zawsze bylem wielkim fanem czlowieka-pajaka. Obejrzalem wszystkie komiksy. Pamietam taka jedna burze, siedzialem wtedy przy transformatorze, a w rece mialem komiks Spidermana... No ale nieistotne - chcialbym garsc tworzywa, ktore wydzielaja pajaki. Masz moze? Przynajmniej pietnascie centymetrow." or "Do you have spider silk with you?",
			npc,
			creature
		)
		npcHandler:setTopic(playerId, 4)
	elseif table.contains({
		"huge chunk of crude iron",
		"crude iron",
		"chunk of crude iron",
		"chunk",
	}, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Widzisz, niektorzy nie sa tak hojnie obdarzeni, i musza sobie rekompensowac czym innym... no, tak czy siak. Masz moze ze soba {giant sword}?" or "Do you have giant sword with you?", npc, creature)
		npcHandler:setTopic(playerId, 5)
	elseif table.contains({ "piece of royal steel", "royal steel" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Moj znajomy, Michal Pirog, bardzo ladnie sie ubiera. Ja tez chce, ale bardziej w wojowniczym stylu. Chce od Ciebie kupic {Crown Armor}, zamiast tego - dam Ci {Piece of Royal Steel}. Chetny?" or "Do you have crown armor with you?", npc, creature)
		npcHandler:setTopic(playerId, 6)
	elseif table.contains({ "piece of hell steel", "hell steel" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "He, he. Kiedys wujek jak wchodzil mi do wanny, zeby sprawdzic czy woda jest ciepla, pokazal mi ciekawa rzecz. Ta rzecz kojarzy mi sie z devil helmet. Jesli chcesz, to sie wymienimy - ja Ci dam {hell steel}. To co?" or "Do you have devil helmet with you?", npc, creature)
		npcHandler:setTopic(playerId, 7)
	elseif table.contains({ "piece of draconian steel", "draconian steel" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Lubie smoki. Jesli dasz mi {dragon shield}, to wzamian dostaniesz {Piece of Draconian Steel}. To jak?" or "Do you have dragon shield with you?", npc, creature)
		npcHandler:setTopic(playerId, 8)
	elseif table.contains({ "magic sulphur", "sulphur" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Tak jak kazdy, mam trzy relatywnie duze otwory w ciele. No i lubie polykac. Dlatego... postanowilem pobawic sie w bycie polykaczem ogni. Masz moze trzy fire sword? Dam Ci za nie {magic sulphur} - dobrze kopie." or "Do you have three fire swords with you?", npc, creature)
		npcHandler:setTopic(playerId, 9)
		--[[elseif table.contains({"damaged steel helmet", "steel helmet"}, message) then
		npcHandler:say(getPlayerLanguage(player) == 'PL' and
			"Masz ze soba 100 000 zlota? Taniej go nie opyle, to unikat, z pierwszej wojny o Mirko Town, pomiedzy Rogalami a Rebornami." or
			"Do you have 100k of gold with you?", npc, creature)
		npcHandler:setTopic(playerId, 1)0]]
	elseif table.contains({ "yes", "tak", "okej", "dobra" }, message) and npcHandler:getTopic(playerId) == 1 then
		if player:removeItem(3079, 1) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Oby Ci sie przydalo... bo zwrotow nie ma!" or "Here you are.", npc, creature)
			player:addItem(5891, 1)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Najpierw musisz zalatwic sobie buty szybkosci. Wtedy mozemy porozmawiac." or "You didnt bring this item.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak", "okej", "dobra" }, message) and npcHandler:getTopic(playerId) == 2 then
		if player:removeItem(3392, 2) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze, oto Twoj {spirit container}." or "Here you are.", npc, creature)
			player:addItem(5884, 1)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Hej, nie klam, nie masz wymaganych przedmiotow." or "You didnt bring this item.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak", "okej", "dobra" }, message) and npcHandler:getTopic(playerId) == 3 then
		if player:removeItem(3369, 4) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Blech... masz to ohydztwo, {flask of warrior's sweat}." or "Here you are.", npc, creature)
			player:addItem(5885, 1)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "E-e, to nie sa przedmioty ktore chce. Przyjdz z czterema {warrior helmet}." or "You didnt bring this item.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak", "okej", "dobra" }, message) and npcHandler:getTopic(playerId) == 4 then
		if player:removeItem(5879, 10) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Spoko, oto Twoj {spool of yarn}. A teraz spadaj, chce sie pobawic w spidermana." or "Here you are.", npc, creature)
			player:addItem(5886, 1)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Ej, chce 10 centymetrow {spider silk}, nie mniej, nie wiecej!" or "You didnt bring this item.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak", "okej", "dobra" }, message) and npcHandler:getTopic(playerId) == 5 then
		if player:removeItem(3281, 1) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Jeeej! Mam wielki miecz! Szkoda tylko, ze miecz... No coz, ale prosze, masz {Huge Chunk of Crude Iron}." or "Here you are.", npc, creature)
			player:addItem(5892, 1)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "*Mela chowa sie w transformatorze* nic o mnie nie wiesz! Nie pokazuj mi sie na oczy bez {Giant Sword}!" or "You didnt bring this item.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak", "okej", "dobra" }, message) and npcHandler:getTopic(playerId) == 6 then
		if player:removeItem(3381, 1) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Dzieki, to kawalek tej zbroi, nie bede go potrzebowal - {Piece of Royal Steel}." or "Here you are.", npc, creature)
			player:addItem(5887, 1)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz tej fajnej zbroi przy sobie. Przynies, to wtedy pogadamy." or "You didnt bring this item.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak", "okej", "dobra" }, message) and npcHandler:getTopic(playerId) == 7 then
		if player:removeItem(3356, 1) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Oto Twoj {Piece of Hell Steel}." or "Here you are.", npc, creature)
			player:addItem(5888, 1)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz przy sobie {Devil Helmet}, sorry, nie moge Ci dac {Piece of Hell Steel} od tak." or "You didnt bring this item.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak", "okej", "dobra" }, message) and npcHandler:getTopic(playerId) == 8 then
		if player:removeItem(3416, 1) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Oto Twoj {Piece of Draconian Steel}. Tylko uwazaj, wystaje z niego jeszcze zab smoka." or "Here you are.", npc, creature)
			player:addItem(5889, 1)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz ze soba {Dragon Shield}... Przyznaj sie po prostu, ze boisz sie tych jaszczurek." or "You didnt bring this item.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak", "okej", "dobra" }, message) and npcHandler:getTopic(playerId) == 9 then
		if player:removeItem(3280, 3) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "He, he, wiec tez wciagasz? No spoko, oto Twoja dzialka {Magic Sulphur}. Tylko uwazaj, bo kopie." or "Here you are.", npc, creature)
			player:addItem(5904, 1)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Co Ty, z bagiet jestes, czy jak? Nie masz trzech {Fire Sword}, spadaj, bo zaraz zawolam ziomeczka..." or "You didnt bring this item.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak", "okej", "dobra" }, message) and npcHandler:getTopic(playerId) == 10 then
		if player:removeMoney(100000) then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Spoko. Masz. Tylko nie mow od kogo wziales." or "Here you are.", npc, creature)
			player:addItem(5924, 1)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz tyle kasy, ziomeczku." or "You dont have enough money.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "no", "nie", "nope" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie, to nie. Spadaj." or "Then no.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|. Interesuja cie {przedmioty} do addonu? Mozesz rowniez zapoznac sie z ELEKTRYZUJACA oferta wpisujac {trade}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "No to elo, uwazaj na deszcz i stacje transformatorowe.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "A zeby Cie cos kopnelo...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. Are you interested in addon {items}? You can also check my offer, say {trade}.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye.')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = { { itemName = "coral comb", clientId = 5945, buy = 10000 } }

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
