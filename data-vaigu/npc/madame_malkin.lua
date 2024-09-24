local internalNpcName = "Madame Malkin"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 185
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 279,
	lookHead = 114,
	lookBody = 132,
	lookLegs = 132,
	lookFeet = 132,
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

local vocations = {
	["sorcerer"] = 1,
	["druid"] = 1,
	["paladin"] = 2,
	["knight"] = { ["club"] = 3, ["axe"] = 4, ["sword"] = 5 },
}
local knightChoice = {}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Naprawie twoje soft bootsy, bez obaw beda jak nowe" },
	{
		text = "Piekna wiosna, wszystko kwitnie, piechurzy wracaja z pierwszych polowan..",
	},
	{
		text = "Slyszalam , ze pierwsze wyprawy po magiczne buty zakonczyly sie pomyslnie",
	},
	{ text = "Tylko czekac az ktos przyniesie buty do regeneracji..." },
}

local config = nil
local lang_to_config = {
	["PL"] = {
		[1] = {
			"Ariel? Ten co mieszka w ten smiesznej chatce na zachodzie? Tym razem wyslal ciebie? ...",
			"Przekaz mu, ze nie ide z nim na zadna impreze. Od tygodnia nic sie nie zmienilo w moich planach.",
		},
		[2] = {
			"Ahh, uwielbiam te egzotyczne paczki od Old Postmana, skosztuje od razu na miejscu. ...",
			"Arrrgh, ohydne, przekaz mu, zeby nie zamawial tego wiecej.",
		},
		[3] = {
			"Nie sprzedaje takiego czegos, to ponizej mojej godnosci. Moge co najwyzej przerobic je na czyste tkaniny. ...",
			"Zrobie to z przyjemnoscia, jednak najpierw chce, abys ty sie dla mnie wykazal. ...",
			"Przynies mi po jednej z kazdego koloru, a na pewno ci sie odwdziecze.",
		},
	},
	["EN"] = {
		[1] = {
			"Ariel? The one who lives in this funny hut in the west? He sent you this time? ...",
			"Tell him that I'm not going to any party with him.",
		},
		[2] = {
			"Ahh, I love these exotic donuts from Old Postman, I'll taste them immediately at the spot. ...",
			"Arrrgh, disgusting. Tell him that he should never order this one again.",
		},
		[3] = {
			"I'm not selling things like that, it's below my dignity. I can remake them for clean fabrics. ...",
			"I will do that with pleasure but first I need you to prove yourself for me. ...",
			"Bring me one of each color and you won't regret it.",
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
	-- wymiana turbanow, red robe i green tunicow == 29/04/17
	if MsgContains(message, "mystic turban") and player:getStorageValue(Storage.PomocMiejscowym.TaniRecykling) == 2 then
		if player:getItemCount(3574) > 0 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz zamienic wszystkie mystic turbany na niebieskie szmatki?" or "Would you like to exchange all of your mystic turbans to blue pieces of cloth?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie posiadasz turbanu." or "You didnt bring any mystic turban with you.", npc, creature)
		end
	elseif MsgContains(message, "red robe") and player:getStorageValue(Storage.PomocMiejscowym.TaniRecykling) == 2 then
		if player:getItemCount(3566) > 0 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz zamienic wszystkie red roby na czerwone szmatki?" or "Would you like to exchange all of your red robes to red pieces of cloth?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie posiadasz red robe." or "You didnt bring any red robe with you.", npc, creature)
		end
	elseif MsgContains(message, "green tunic") and player:getStorageValue(Storage.PomocMiejscowym.TaniRecykling) == 2 then
		if player:getItemCount(3563) >= 10 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Green tunic to slaby material, ale za 10 z nich dam ci 1 zielona szmatke. Pasuje?" or "Green tunics are such weak fabric. I can exchange 10 of them for one green piece of cloth. Are you down for that?", npc, creature)
			npcHandler:setTopic(playerId, 5)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz przynajmniej 10 green tunicow." or "You need to bring at least 10 green tunics.", npc, creature)
		end
		-- wymiana turbanow, red robe i green tunicow == 29/04/17
	elseif table.contains({ "werewolf helmet", "enchant" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Widze, ze przyniosles helm wilkolakow, chcial bys cos w nim zmienic?" or "You brought the wolven helmet, as i see. Do you want to change something?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({ "knight", "sorcerer", "druid", "paladin" }, message:lower()) and npcHandler:getTopic(playerId) == 7 then
		local helmet = message:lower()
		if not vocations[helmet] then
			return false
		end
		if message:lower() == "knight" then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Jaka bron preferujesz? {Club}, {axe} czy {sword}?" or "And what would be your preferred weapon? {Club}, {axe} or {sword}?", npc, creature)
			knightChoice[playerId] = helmet
			npcHandler:setTopic(playerId, 8)
		end
		if npcHandler:getTopic(playerId) == 7 then
			player:setStorageValue(Storage.Grimvale.WereHelmetEnchant, vocations[helmet])
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Ok, jesli chcial bys go zmienic, wroc do mnie." or "So this is your choice. If you want to change it, you will have to come to me again.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif table.contains({ "axe", "club", "sword" }, message:lower()) and npcHandler:getTopic(playerId) == 8 then
		local weapontype = message:lower()
		if not vocations[knightChoice[playerId]][weapontype] then
			return false
		else
			player:setStorageValue(Storage.Grimvale.WereHelmetEnchant, vocations[knightChoice[playerId]][weapontype])
			npcHandler:say("So this is your choice. If you want to change it, you will have to come to me again.", npc, creature)
			knightChoice[playerId] = nil
			npcHandler:setTopic(playerId, 0)
		end
	elseif table.contains({ "soft boots" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz zamienic {worn soft boots}, czy {doladowac} jeszcze nie zuzyte? Koszt przywrocenia butow do stanu uzywalnosci to 20k." or "Would you like to exchange {worn soft boots}, or {charge} active ones? Cost of both services is 20k of gold.", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "worn soft boots" }, message) and npcHandler:getTopic(playerId) == 1 then
		if player:getItemCount(6530) > 0 then
			if player:removeMoney(20000) then
				player:removeItem(6530, 1)
				player:addItem(6529, 1)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo, oto Twoje buty." or "Here you are.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglupiales? Za darmo ja nie pracuje!" or "What?! I wont do it for free.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Wybacz, ale nie masz takich butow. Tylko {soft boots} moge naprawic." or "Sorry, but you dont have such item. I can only fix {soft boots}.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "doladowac", "charge" }, message) and npcHandler:getTopic(playerId) == 1 then
		if player:getItemCount(6529) > 0 then
			if player:removeMoney(20000) then
				player:removeItem(6529, 1)
				player:addItem(6529, 1)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo, oto Twoje buty." or "Here are your soft boots.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglupiales? Za darmo ja nie pracuje!" or "I wont do it for free!", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Wybacz, ale nie masz takich butow. Tylko {soft boots} moge naprawic." or "Sorry, but you dont have such item. I can only fix {soft boots}.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "no", "nie" }, message) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie to nie, spadaj!" or "Well, go away then!", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
	-- ============ DO 1 MISJI YALAHARI QUESTA =============
	if table.contains({ "zaproszenie", "ariel", "invitation" }, message) and player:getStorageValue(Storage.Yalahar.MiloscAriela) == 1 then
		if player:getItemCount(4846) > 0 then
			player:removeItem(4846, 1)
			player:setStorageValue(Storage.Yalahar.MiloscAriela, 2)
			npcHandler:say(config[1], npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif table.contains({
		"mission",
		"misja",
		"old postman",
		"zaproszenie",
		"wino",
	}, message) and player:getStorageValue(Storage.Yalahar.MiloscAriela) == 6 and player:getStorageValue(Storage.Yalahar.Haybed) == 1 then
		-- jesli po misji od postmna -- jesli po zebraniu wlosa -- i jesli mamy akurat winiaka przy sobie
		if player:getItemCount(19133) > 0 then
			player:removeItem(19133, 1)
			player:setStorageValue(Storage.Yalahar.MiloscAriela, 7)
			npcHandler:say(config[2], npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif table.contains({ "misja", "ariel", "mission", "zaproszenie" }, message) and player:getStorageValue(Storage.Yalahar.MiloscAriela) == 7 then
		player:setStorageValue(Storage.Yalahar.MiloscAriela, 8)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Zaproszenie na impreze od mojego ukochanego Ariela? Oczywiscie, ze pojde. Przekaz mu, zeby byl po mnie o 18." or "Party invitation from my lovely Ariel? Of course I will go. Tell him to pick me up at 6pm.", npc, creature)
		npcHandler:setTopic(playerId, 1)
	end
	-- ============ DO 1 MISJI YALAHARI QUESTA =============
	-- ============ DO MISJI TRUDNE POCZATKI =============
	if table.contains({ "pomoc", "help" }, message) then
		if player:getStorageValue(Storage.TrudnePoczatki.Rozeznanie) >= 2 then
			if player:getStorageValue(Storage.TrudnePoczatki.MadameAsked) < 1 then
				player:setStorageValue(Storage.TrudnePoczatki.MadameAsked, 1) -- lockujemy Malkin jako wykonanego
				player:setStorageValue(Storage.TrudnePoczatki.Rozeznanie, player:getStorageValue(Storage.TrudnePoczatki.Rozeznanie) + 1) -- +1 zeby kolejnosc nie miala znaczenia
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie potrzebuje pomocy, ale gdybys przyniosl mi po 1 {tkaninie} kazdego koloru to sie na pewno odwdziecze." or "I dont need any help, but I would be glad if you bring me one piece of {cloth} of each color. I will definitely pay back for that.", npc, creature)
			elseif player:getStorageValue(Storage.TrudnePoczatki.MadameAsked) >= 1 and player:getStorageValue(Storage.PomocMiejscowym.TaniRecykling) < 1 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie potrzebuje pomocy, ale gdybys przyniosl mi po 1 {tkaninie} kazdego koloru to sie na pewno odwdziecze." or "I dont need any help, but I would be glad if you bring me one piece of {cloth} of each color. I will definitely pay back for that.", npc, creature)
			elseif player:getStorageValue(Storage.TrudnePoczatki.MadameAsked) >= 1 and player:getStorageValue(Storage.PomocMiejscowym.TaniRecykling) == 1 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Czekam, az przyniesiesz mi po kawalku tkaniny z kazdego koloru." or "Im waiting for you to bring me piece of cloth of each color.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "No dzieki za te szmatki, co mi przyniosles. Nic wiecej mi nie potrzeba." or "Thank you for those pieces of cloth.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie potrzebuje pomocy." or "I dont need your help.", npc, creature)
		end
		-- ============ DO MISJI TRUDNE POCZATKI ============= 24/04/17
	elseif table.contains({ "naszyjnik", "necklace" }, message) and player:getStorageValue(Storage.NaPomocBagietom.BeLikeSchwarzenegger) == 2 then
		if player:getItemCount(10196) >= 5 and player:getItemCount(9685) >= 1 and player:getItemCount(10275) >= 5 then
			player:setStorageValue(Storage.NaPomocBagietom.BeLikeSchwarzenegger, 3)
			player:removeItem(10196, 5) -- zabieramy 5 zembuf ork
			player:removeItem(9685, 1) -- zabieramy 1 zembuf vamp
			player:removeItem(10275, 5) -- zabieramy 5 zembuf rot
			player:AddCustomItem({ id = 7754, addToStore = true }) 
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Ooo, dla Arniego? Pewnie, on jest taki przystojny. Jeszcze popsikam swoimi perfumami. Pozdrow go ode mnie i trzymaj naszyjnik." or "Oohh, from Arnie? For sure, he is so handsome. I will spray them with my perfumes. Greet him from me and take this necklace.", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "No z tego nie uplote takiego naszyjnika." or "I'm not able to make any necklace out of that..", npc, creature)
		end
		-- ============ DO MISJI TRUDNE POCZATKI ============= 24/04/17
		-- ============ MISJA ZE SZMATKAMI ============= 29/04/17
	elseif table.contains({ "tkaninie", "cloth" }, message) and player:getStorageValue(Storage.PomocMiejscowym.TaniRecykling) < 1 and player:getStorageValue(Storage.TrudnePoczatki.MadameAsked) >= 1 then
		player:setStorageValue(Storage.PomocMiejscowym.TaniRecykling, 1)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Lubie cos uszyc w wolnym czasie, ale powoli brakuje mi kolorowych tkanin. Przynies mi po jednej z kazdego koloru, a na pewno ci sie odwdziecze." or "I like to sew something when I am bored but slowly I am lack of colorful fabrics", npc, creature)
	end
	if table.contains({ "mission", "misja", "tkaniny", "tkanina", "cloth" }, message) then
		-- if player:getStorageValue(Storage.PomocMiejscowym.TaniRecykling) < 1 then
		--	player:setStorageValue(Storage.PomocMiejscowym.TaniRecykling, 1)
		--	npcHandler:say('Lubie cos uszyc w wolnym czasie, ale powoli brakuje mi kolorowych tkanin. Przynies mi po jednej z kazdego koloru, a na pewno ci sie odwdziecze.', npc, creature)
		-- end
		if player:getStorageValue(Storage.PomocMiejscowym.TaniRecykling) == 1 then
			if
				player:getItemCount(5909) > 0 -- white
				and player:getItemCount(5910) > 0 -- green
				and player:getItemCount(5911) > 0 -- red
				and player:getItemCount(5912) > 0 -- blue
				and player:getItemCount(5913) > 0 -- brown
				and player:getItemCount(5914) > 0 -- yellow
			then
				npcHandler:say(
					getPlayerLanguage(player) == "PL" and "Dziekuje ci, moze nie sa najlepszej jakosci, ale w koncu jestem Madame Malkin. Od teraz bedziesz mogl wymieniac mystic turbany, red robe oraz green tunic na tkaniny." or "Thank you, the quality is not the best but in the end I am Madame Malkin. I can replace your mystic turbans, red robes and green tunics for pieces of cloth from now on.",
					npc,
					creature
				)
				player:setStorageValue(Storage.PomocMiejscowym.TaniRecykling, 2) -- konczymy questa
				-- Q5.1
				player:addExperience(30000, true) -- 30k expa
				player:getPosition():sendMagicEffect(CONST_ME_STUN)
				-- Q5.1
				player:removeItem(5909, 1) -- white
				player:removeItem(5910, 1) -- green
				player:removeItem(5911, 1) -- red
				player:removeItem(5912, 1) -- blue
				player:removeItem(5913, 1) -- brown
				player:removeItem(5914, 1) -- yellow
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Mysle ze pominales jakis kolor, przynies wszystkie 6 za jednym razem." or "I think you missed some colour, bring me all 6 at once.", npc, creature)
			end
		end
	elseif (MsgContains(message, "mystic turban") or MsgContains(message, "red robe") or MsgContains(message, "green tunic")) and player:getStorageValue(Storage.PomocMiejscowym.TaniRecykling) < 1 then
		npcHandler:say(config[3], npc, creature)
		player:setStorageValue(Storage.PomocMiejscowym.TaniRecykling, 1)
	end
	if MsgContains(message, "belongings") or MsgContains(message, "medicine") then
		if player:getItemCount(12517) > 0 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Przyniosles dla mnie medicine pouch?" or "You have medicine pouch for me?", npc, creature)
			npcHandler:setTopic(playerId, 6)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Wzamian za medicine puch dam ci {belongings of deceased}. Wroc jesli je zdobedziesz." or "I can give you {belongings of deceased} for your {medicine puch}. Come back if you get one.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif (MsgContains(message, "yes") or MsgContains(message, "tak")) and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Wiec jaka profesje preferuejsz podczas nasycania helmu: {knight}, {sorcerer}, {druid} czy {paladin}?" or "So, which profession would you give preference to when enchanting the helmet: {knight}, {sorcerer}, {druid} or {paladin}?", npc, creature)
		npcHandler:setTopic(playerId, 7)
	elseif (MsgContains(message, "yes") or MsgContains(message, "tak")) and npcHandler:getTopic(playerId) == 3 then
		player:addItem(5912, player:getItemCount(3574)) -- daje niebieskie szmatki
		player:removeItem(3574, player:getItemCount(3574)) -- zabiera mystic turbany
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Robie to dla ciebie tylko z czystej sympatii." or "Im doing that only bacause of our friendship.", npc, creature)
	elseif (MsgContains(message, "yes") or MsgContains(message, "tak")) and npcHandler:getTopic(playerId) == 4 then
		player:addItem(5911, player:getItemCount(3566)) -- daje czerwone szmatki
		player:removeItem(3566, player:getItemCount(3566)) -- zabiera red roby
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Robie to dla ciebie tylko z czystej sympatii." or "Im doing that only bacause of our friendship.", npc, creature)
	elseif (MsgContains(message, "yes") or MsgContains(message, "tak")) and npcHandler:getTopic(playerId) == 5 then
		player:addItem(5910, 1) -- daje zielone szmatki
		player:removeItem(3563, 10) -- zabiera green tunici
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Robie to dla ciebie tylko z czystej sympatii." or "Im doing that only bacause of our friendship.", npc, creature)
	elseif (MsgContains(message, "yes") or MsgContains(message, "tak")) and npcHandler:getTopic(playerId) == 6 then
		if player:removeItem(12517, 1) then
			player:addItem(12413, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo." or "Here you are.", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie posiadasz wymaganych przedmiotow." or "You dont have that.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Dzien dobry! Pohandlujemy, a moze naprawie Ci zuzyte {soft boots}? Przebuje takze {medicine pouch}, zglos sie jesli zdobedziesz jakies.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Narazie!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Nie to nie, dobranoc!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello! You want to {trade}, or repair your worn {soft boots}? I can also exchange your {medicine pouch}.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Bye!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'Well, good bye!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "magician's robe", clientId = 7991, buy = 450 },
	{ itemName = "ethno coat", clientId = 8064, buy = 750 },
	{ itemName = "spirit cloak", clientId = 8042, buy = 1000 },
	{ itemName = "ethno coat", clientId = 8064, sell = 200 },
	{ itemName = "spirit cloak", clientId = 8042, sell = 350 },
	{ itemName = "focus cape", clientId = 8043, sell = 6000 },
	{ itemName = "batwing hat", clientId = 9103, sell = 8000 },
	{ itemName = "jade hat", clientId = 10451, sell = 9000 },
	{ itemName = "zaoan robe", clientId = 10439, sell = 12000 },
	{ itemName = "spellweaver's robe", clientId = 10438, sell = 12000 },
	{ itemName = "depth scutum", clientId = 13998, sell = 36000 },
	{ itemName = "wooden spellbook", clientId = 25699, sell = 12000 },
	{ itemName = "spellbook of enlightenment", clientId = 8072, sell = 4000 },
	{ itemName = "spellbook of lost souls", clientId = 8075, sell = 19000 },
	{ itemName = "spellbook of mind control", clientId = 8074, sell = 13000 },
	{ itemName = "spellbook of warding", clientId = 8073, sell = 8000 },
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
