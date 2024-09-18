local internalNpcName = "Grave Digger"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 306,
	lookHead = 57,
	lookBody = 59,
	lookLegs = 40,
	lookFeet = 76,
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
	{ text = "Mam szpadle, liny, maczety, kosy i inne przydatne gadzety..." },
	{ text = "Wedki plecaki, robaki w korzystnej cenie ! " },
	{
		text = "Jesli potrzebujesz sprzet niezbedny do eksplorowania terenu to dobrze trafiles.",
	},
	{ text = "Bez sprzetu na wyprawe? " },
	{
		text = "Ludzie to nie maja wyobrazni mam nadzieje ze w koncu wejdzie ta ustawa i na zwiedzanie bedzie mozna chodzic tylko z licencja...",
	},
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	-- ============ DO MISJI TRUDNE POCZATKI =============
	if table.contains({ "pomoc", "help" }, message) and player:getStorageValue(Storage.TrudnePoczatki.DiggerAsked) < 1 then
		if player:getStorageValue(Storage.TrudnePoczatki.Rozeznanie) >= 2 then
			player:setStorageValue(Storage.TrudnePoczatki.DiggerAsked, 1) -- lockujemy grave diggera jako wykonanego
			player:setStorageValue(Storage.TrudnePoczatki.Rozeznanie, player:getStorageValue(Storage.TrudnePoczatki.Rozeznanie) + 1) -- +1 zeby kolejnosc nie miala znaczenia
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebuje pomocy, ale pewnie nie taka o jaka chodzi Rybie, natomiast jakbys chcial sie przydac to sie zglos do mnie." or "I need help, but probably not close to what Ryba want, but if you want to be useful, please contact me.", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Czego ty ode mnie chcesz? Lepiej zamelduj sie u Komisarza Ryby.." or "What do you want? Better visit Commissioner Fisher first.", npc, creature)
		end
		-- ============ DO MISJI TRUDNE POCZATKI =============
	elseif table.contains({
		"groby",
		"grob",
		"grobow",
		"cmentarz",
		"cmentarze",
		"grave",
		"graves",
	}, message) and player:getStorageValue(Storage.Yalahar.WstepDoCzarnejMagii) == 2 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Groby to szukaj na pewno na cmentarzu naszym, oraz Knurowskim. I podobno gdzies na polnoc stad jakis jest." or "Graves it is for sure on our cemetery, and Knurowski. Apparently there is one somewhere to the north of here.", npc, creature)
	elseif table.contains({
		"dusze",
		"dusza",
		"dusza dziewicy",
		"soul",
		"souls",
		"virgin's soul",
	}, message) and player:getStorageValue(Storage.Yalahar.WstepDoCzarnejMagii) == 1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Oo tak, pamietam jak za mlodu polowalismy na dziewice. Teraz te glupie dziewczyny puszczaja sie na lewo i prawo. Trudno o dziewice teraz. ...",
			"Ale bardzo mozliwe, ze uda cie wycisnac cos z martwych juz dziewic. Takze jedyne rozwiazanie jakie widze, to lopata w dlon i kopanie {grobow}, czyli to co lubie najbardziej! ...",
			"Jakbys nie mial czym kopac, to trzymaj moja stara saperke.",
		} or {
			"Oh yes, I remember when we were young we used to hunt for virgins. Now these foolish girls are banging left and right. It's hard to find any left. ...",
			"But it is very possible that you can squeeze something out of dead virgins. So the only solution I see is a shovel in my hand and digging {graves}, which is what I like best! ...",
			"If you don't have anything to dig with, keep my old shovel.",
		}, npc, creature)
		player:addItem(5710, 1) -- dostaje light shovela
		player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 2) -- idziemy dalej z questem
		player:setStorageValue(Storage.Yalahar.Groby, 8) -- do szansy na powodzenie ( kazdy grob daje 10% wiecej szansy
	elseif table.contains({ "mission", "misja" }, message) and player:getStorageValue(Storage.CrowbarBought) <= 0 then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Ostatnio znany biznesmen Bildo Debicki zostal pochowany na poludniowym cmentarzu. Aby uhonorowac jego smierc postanowilem, ze zrobie cos dobrego dla mieszkancow tego miasta, i wprowadze promocje na {lomy}. Ta konwersacja nie stanowi podzegania do przestepstwa w rozumieniu kodeksu karnego. Cena jednego takiego przedmiotu to 10 gp."
				or "Lately, the well-known businessman Bildo Debicki was buried in the southern cemetery. To honor his passing, I've decided to do something good for the residents of this city and introduce a promotion on {crowbars}. This conversation does not constitute incitement to a crime under the criminal code. The price of one such item is 10 gold pieces.",
			npc,
			creature
		)
	elseif table.contains({ "lom", "lomy", "crowbar", "crowbars" }, message) then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Chcesz zakupic specjalny lom? Bedzie cie to kosztowac 10gp. Jezeli chcialbys podwazyc jakies wieko (np od dzemu) to wystarczy ze klikniesz na nie. Nie musisz uzywac lomu - stad nazywam go specjalnym."
				or "You want to buy special crowbar? It will cost you 10gp. If you were to pry open a lid (like the lid of a can), just click on it. No need to use crowbar - hence its called special.",
			npc,
			creature
		)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 1 then
		if player:getStorageValue(Storage.CrowbarBought) <= 0 then
			if player:removeMoney(10) then
				player:AddItems({ SPOCZYWAJACY_TUTAJ_KEY_ITEMS.crowbar })
				player:setStorageValue(Storage.CrowbarBought, 1)
				player:setStorageValue(Storage.ImRestingHere.Questline, 1)
				player:setStorageValue(Storage.ImRestingHere.Mission01, 1)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo, oto twoj lom." or "Here you are.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "No co ty, 10gp nie masz?!" or "What?! Its only 10gps.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Wiecej ci nie sprzedam, musi cos starczyc dla innych!" or "I won't sell you more than one of these.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "mission", "misja", "klatwa", "curse" }, message) and player:getStorageValue(Storage.TheaterOfCheapThrills.Mission04) == 2 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Tak, troche sie znam na zdejmowaniu klatw, ale o jaka dokladnie chodzi?" or "Yes, I'm somewhat knowledgeable about lifting curses, but which curse are you specifically referring to?", npc, creature)
	elseif table.contains({ "ytong" }, message) and player:getStorageValue(Storage.TheaterOfCheapThrills.Mission04) == 2 then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Wyjatkowo paskudna. Bede musial cie prosic o udanie sie w pewne miejsce. Aby zdjac klatwe, bedziesz musial podac tajne haslo przekletemu. Niestety, ja tego hasla nie znam, ale pomoc ci moze specjalna {ksiega} zaklec."
				or "Particularly nasty, indeed. I'll have to ask you to go to a certain place. To lift the curse, you'll need to provide the cursed one with a secret passphrase. Unfortunately, I don't know that passphrase, but a special spell {book} might assist you.",
			npc,
			creature
		)
	elseif table.contains({ "ksiega", "book" }, message) and player:getStorageValue(Storage.TheaterOfCheapThrills.Mission04) == 2 then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "Ksiega jest schowana za magicznymi mechanizmami, gleboko w jaskiniach Stone Golemow na Hurghadzie. Mechanizm wymyslil ktos o nazwisku konczacym sie na -stein, wiec wez ze soba duzo gold coinow."
				or "The book is hidden behind magical mechanisms, deep within the caverns of the Stone Golems on Hurghad Island. The machines inside were created by someone named -stein, so take lot of gold coins with you.",
			npc,
			creature
		)
	elseif table.contains({ "sygnet", "signet", "piescien", "seal" }, message) and player:getStorageValue(Storage.PathOfTheUndead.Mission03) == 1 then
		npcHandler:say(
			getPlayerLanguage(player) == "PL"
					and "Nie wiem, skad wiesz o istnieniu tego sygnetu, ale jezeli chcesz go odnalezc, to sluchaj. Bylo to w jaskiniach Diremawow pod bagnem kultystow. Gdy zblizalem sie do jaskini Ognistego Skurwiwija, ten ryknal tak, ze obsralem sie i zaczalem jak najszybciej stamtad uciekac. Z tego pospiechu wypadla mi z plecaka jedna z atrap atefaktow, ktorych uzywalem do.. a z reszta, niewazne. W srodku tej atrapy, ktora mi wypadla, ukryty byl pierscien. Jezeli dobrze pamietam, to atrapa ta miala imitowac drogocenna miniaturke statku. Wracajac do tego jak ucieklem, pamietam tylko jak obudzilem sie w temple. Jesli chcesz, to mozesz poszukac tego pierscienia, mi on juz sie nie przyda."
				or "I don't know how you know about this ring, but if you want to find it, listen. It was in the Diremaw caves under the cultist swamp. As I approached the Fire Fucker's cave, he roared so hard that I shit myself and started running away as fast as I could. In this haste, one of the dummy atifacts I used for... never mind, fell out of my backpack. Inside the dummy I had dropped there was a ring. If I remember correctly, this dummy was supposed to imitate a precious miniature of the ship. Coming back to how I escaped, all I remember is waking up in the temple. If you want, you can look for that ring, I don't need it anymore.",
			npc,
			creature
		)
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Czesc, ja jestem GraveDigger. Sprzedaje akcesoria pomagajace w kopaniu grobow i zwiedzaniu krypt. Napisz {trade}, zeby sie ze mna powymieniac.")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello there, I am GraveDigger. In my offer you can find equipment that may help in grave digging and crypt exploring. Say {trade} if youre interested.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "light shovel", clientId = 5710, sell = 300 },
	{ itemName = "crowbar", clientId = 3304, sell = 190 },
	{ itemName = "fishing rod", clientId = 3483, sell = 65 },
	{ itemName = "worm", clientId = 3492, sell = 1 },
	{ itemName = "backpack", clientId = 2854, sell = 5 },
	{ itemName = "rope", clientId = 3003, sell = 20 },
	{ itemName = "scythe", clientId = 3453, sell = 20 },
	{ itemName = "pick", clientId = 3456, sell = 20 },
	{ itemName = "shovel", clientId = 3457, sell = 20 },
	{ itemName = "rust remover", clientId = 9016, sell = 45 },
	{ itemName = "machete", clientId = 3308, buy = 40 },
	{ itemName = "sickle", clientId = 3293, buy = 8 },
	{ itemName = "crowbar", clientId = 3304, buy = 260 },
	{ itemName = "fishing rod", clientId = 3483, buy = 150 },
	{ itemName = "worm", clientId = 3492, buy = 1 },
	{ itemName = "backpack", clientId = 2854, buy = 20 },
	{ itemName = "bag", clientId = 2853, buy = 5 },
	{ itemName = "rope", clientId = 3003, buy = 50 },
	{ itemName = "scythe", clientId = 3453, buy = 50 },
	{ itemName = "pick", clientId = 3456, buy = 50 },
	{ itemName = "shovel", clientId = 3457, buy = 50 },
	{ itemName = "rust remover", clientId = 9016, buy = 100 },
	{ itemName = "blue backpack", clientId = 2869, buy = 20 },
	{ itemName = "golden backpack", clientId = 2871, buy = 20 },
	{ itemName = "green backpack", clientId = 2865, buy = 20 },
	{ itemName = "grey backpack", clientId = 2870, buy = 20 },
	{ itemName = "orange backpack", clientId = 9602, buy = 20 },
	{ itemName = "purple backpack", clientId = 2868, buy = 20 },
	{ itemName = "red backpack", clientId = 2867, buy = 20 },
	{ itemName = "yellow backpack", clientId = 2866, buy = 20 },
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
