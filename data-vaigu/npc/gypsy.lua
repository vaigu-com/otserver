local internalNpcName = "Gypsy"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 150
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 25000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 430,
	lookHead = 97,
	lookBody = 1,
	lookLegs = 116,
	lookFeet = 114,
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
	{ text = "Piekny panie, daj pan zloty pierscionek ja powrozyc..." },
	{
		text = "Spokojnie, nie okradne Cie, mozesz sprzedac u mnie swoje kosztownosci...",
	},
	{ text = "Cooo? Yyyy no tego, mial kurde" },
	{ text = "Byla sakwa z hajsem, nie ma sakwy" },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "life crystal", "life ring", "life" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrafie wytwarzac pierscienie z {life crystal}, nauczyla mnie tego mama. Czy chcesz, abym przetworzyl twoje krysztaly?" or "I can exchange your life crystals for a life rings. Is that what youre interested in?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "yes", "tak" }, message) then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(3061) == 1 then
				local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
				if backpack and backpack:getEmptySlots(false) >= player:getItemCount(3061) then
					player:removeItem(3061, 1)
					player:addItem(3052, 1, true, 0, CONST_SLOT_BACKPACK)
				else
					player:removeItem(3061, 1)
					player:addItem(3052, 1)
				end
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo, oto Twoj pierscionek." or "Here you are.", npc, creature)
			elseif player:getItemCount(3061) > 1 then
				local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
				if backpack and backpack:getEmptySlots(false) >= player:getItemCount(3061) then
					player:addItem(3052, player:getItemCount(3061), true, 0, CONST_SLOT_BACKPACK)
				else
					player:addItem(3052, player:getItemCount(3061))
				end
				player:removeItem(3061, player:getItemCount(3061))
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo, oto Twoje pierscienie." or "Here you are.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Sorry, ale nie masz tego krysztalu ze soba. Tylko {life crystal} nadaje sie do wytworzenia tego pierscienia." or "Im sorry, but you dont have such crystal. Only life crystal counts.", npc, creature)
			end
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(3039) == 1 then
				local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
				if backpack and backpack:getEmptySlots(false) >= player:getItemCount(3039) then
					player:removeItem(3039, 1)
					player:addItem(3098, 1, true, 0, CONST_SLOT_BACKPACK)
				else
					player:removeItem(3039, 1)
					player:addItem(3098, 1)
				end
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Trzymaj pierscien!" or "Here you are!", npc, creature)
			elseif player:getItemCount(3039) > 1 then
				local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
				if backpack and backpack:getEmptySlots(false) >= player:getItemCount(3039) then
					player:addItem(3098, player:getItemCount(3039), true, 0, CONST_SLOT_BACKPACK)
				else
					player:addItem(3098, player:getItemCount(3039))
				end
				player:removeItem(3039, player:getItemCount(3039))
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Trzymaj swoje pierscienie!" or "Here you are!", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie posiadasz zadnego gemu!" or "You dont have such gem. Only red gem counts.", npc, creature)
			end
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "no", "nie" }, message) and npcHandler:getTopic(playerId) > 0 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie to nie, spadaj!" or "Well, better go away.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "red gem") and player:getStorageValue(Storage.PomocMiejscowym.ZniszczonaKula) == 2 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrafie z nich wykuc ring of healing, co ty na to?" or "I can exchange your red gems for a ring of healings. Confirm if youre interested in this.", npc, creature)
		npcHandler:setTopic(playerId, 2)
		-- ============ DO MISJI TRUDNE POCZATKI =============
	elseif table.contains({ "pomoc", "help" }, message) then
		if player:getStorageValue(Storage.TrudnePoczatki.Rozeznanie) >= 2 then
			if player:getStorageValue(Storage.TrudnePoczatki.GypsyAsked) < 1 then
				player:setStorageValue(Storage.TrudnePoczatki.GypsyAsked, 1) -- lockujemy Gypsya jako wykonanego
				player:setStorageValue(Storage.TrudnePoczatki.Rozeznanie, player:getStorageValue(Storage.TrudnePoczatki.Rozeznanie) + 1) -- +1 zeby kolejnosc nie miala znaczenia
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Kula! Ukradli mi moja {kule} do wrozenia!" or "Ball! My fortune telling {ball} got broken.", npc, creature)
			elseif player:getStorageValue(Storage.TrudnePoczatki.GypsyAsked) >= 1 and player:getStorageValue(Storage.PomocMiejscowym.ZniszczonaKula) < 1 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Kula! Ukradli mi moja {kule} do wrozenia!" or "Ball! My fortune telling {ball} got broken.", npc, creature)
			elseif player:getStorageValue(Storage.TrudnePoczatki.GypsyAsked) >= 1 and player:getStorageValue(Storage.PomocMiejscowym.ZniszczonaKula) == 1 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Czekam az mi ogarniesz nowa kule do wrozenia." or "I hope you will find new {ball} for me.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Jeszcze raz dzieki za te kule." or "Thank you again for this ball.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Eee.. wszystko u mnie w porzadku." or "Well.. everything is fine.", npc, creature)
		end
		-- ============ DO MISJI TRUDNE POCZATKI =============
	elseif table.contains({ "kula", "kule", "ball" }, message) and player:getStorageValue(Storage.TrudnePoczatki.GypsyAsked) >= 1 then
		if player:getStorageValue(Storage.PomocMiejscowym.ZniszczonaKula) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Moja kula wrozbiarska! Prawdopodobnie zostala skradziona, moze uda ci sie znalezc nowa aby ja zastapic, zglos sie wtedy do mnie!" or "My fortune telling ball! Probably it got stolen, maybe youll help me to find a new one? Come back to show me if you find any.", npc, creature)
			player:setStorageValue(Storage.PomocMiejscowym.ZniszczonaKula, 1) -- zaczynamy questa
		elseif player:getStorageValue(Storage.PomocMiejscowym.ZniszczonaKula) == 1 and player:getItemCount(3076) > 0 then
			-- Q5.1
			player:addExperience(20000, true) -- 20k expa
			player:getPosition():sendMagicEffect(CONST_ME_STUN)
			-- Q5.1
			player:setStorageValue(Storage.PomocMiejscowym.ZniszczonaKula, 2) -- koniec questa
			player:removeItem(3076, 1) -- zabieramy kule
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Hmm, poprzednia byla lepsza, ale tez jest super. Dzieki wielkie!" or "Well, previous one was beeter, but this one if fine too. Thak you!", npc, creature)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "W podziece pozwole ci wymieniac u mnie Red Gem na Ring of Healing." or "I can take some time to exchange your red gems for a ring of healing from now on.", npc, creature)
		end
	elseif table.contains({
		"furniture",
		"thief",
		"meble",
		"zlodziej",
		"kradziez",
	}, message) and player:getStorageValue(Storage.IKEAdlazuchwalych.Questline) == 2 and npcHandler:getTopic(playerId) == 0 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Po pierwsze: nic nie widzialem, po drugie: .. czekaj, powiedziales {meble}?" or "First: I didnt see anything, Second: ... wait, did you say {furniture}?", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif table.contains({ "furniture", "meble", "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie znam nikogo kto chcialby {krasc} te rupiecie od Komora." or "I don't know of anyone who would like to {steal} this junk from Komor.", npc, creature)
		npcHandler:setTopic(playerId, 4)
	elseif table.contains({ "krasc", "steal" }, message) and npcHandler:getTopic(playerId) == 4 then
		player:setStorageValue(Storage.IKEAdlazuchwalych.Questline, 3)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Ta rozmowa przypomniala mi o mojej kuli do wrozenia, ktora takze zostala skradziona." or "This conversation reminded me of my fortune telling ball, which was also stolen.", npc, creature)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Byc moze zlodziej ukrywa sie w podziemiach MirkoTown, raczej nie jest to nikt z zewnatrz. Nikt jednak nie ma odwagi tego sprawdzic." or "Maybe the thief is hiding beneath the MirkoTown, I doubt its anyone from outside of town. However, no one has the courage to check it out.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
end

npcHandler:setMessage(MESSAGE_GREET, "AAAAAMUULETY ZA DWA ZLOTA, PIERSCIONECZKI DLA PIEKNYCH DZIEWCZYYYYN, WYMIANA {LIFE CRYSTAL}. Zapraszam do straganuuu!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Nara, uwazaj zeby cie ktos nie ocyganil.")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'NECKLACES ONLY FOR TWO BUCKS, CHEAP RINGS FOR PRETTY WOMANS, {LIFE CRYSTAL} EXCHANGE! Take a look at my offer!')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Bye, be aware of pickpockets!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "wedding ring", clientId = 3004, sell = 100 },
	{ itemName = "time ring", clientId = 3053, sell = 100 },
	{ itemName = "sword ring", clientId = 3091, sell = 100 },
	{ itemName = "stealth ring", clientId = 3049, sell = 200 },
	{ itemName = "ring of the sky", clientId = 3006, sell = 30000 },
	{ itemName = "ring of healing", clientId = 3098, sell = 100 },
	{ itemName = "power ring", clientId = 3050, sell = 50 },
	{ itemName = "might ring", clientId = 3048, sell = 250 },
	{ itemName = "life ring", clientId = 3052, sell = 50 },
	{ itemName = "gold ring", clientId = 3063, sell = 8000 },
	{ itemName = "energy ring", clientId = 3051, sell = 100 },
	{ itemName = "dwarven ring", clientId = 3097, sell = 100 },
	{ itemName = "death ring", clientId = 6299, sell = 1000 },
	{ itemName = "crystal ring", clientId = 3007, sell = 250 },
	{ itemName = "club ring", clientId = 3093, sell = 100 },
	{ itemName = "axe ring", clientId = 3092, sell = 100 },
	{ itemName = "emerald bangle", clientId = 3010, sell = 800 },
	{ itemName = "crystal of balance", clientId = 9028, sell = 1000 },
	{ itemName = "crystal of focus", clientId = 9027, sell = 2000 },
	{ itemName = "crystal of power", clientId = 9067, sell = 3000 },
	{ itemName = "Small Sapphire", clientId = 3029, sell = 250 },
	{ itemName = "Small Diamond", clientId = 3028, sell = 300 },
	{ itemName = "Black Pearl", clientId = 3027, sell = 280 },
	{ itemName = "Gold ingot", clientId = 9058, sell = 5000 },
	{ itemName = "Scarab coin", clientId = 3042, sell = 100 },
	{ itemName = "Small Amethyst", clientId = 3033, sell = 200 },
	{ itemName = "Small Enchanted Amethyst", clientId = 678, sell = 200 },
	{ itemName = "Small Diamond", clientId = 3028, sell = 300 },
	{ itemName = "Small Emerald", clientId = 3032, sell = 250 },
	{ itemName = "Small Enchanted Emerald", clientId = 677, sell = 250 },
	{ itemName = "Small Ruby", clientId = 3030, sell = 250 },
	{ itemName = "Small Enchanted Ruby", clientId = 676, sell = 250 },
	{ itemName = "Small Sapphire", clientId = 3029, sell = 250 },
	{ itemName = "Small Enchanted Sapphire", clientId = 675, sell = 250 },
	{ itemName = "Small Topaz", clientId = 9057, sell = 200 },
	{ itemName = "White Pearl", clientId = 3026, sell = 160 },
	{ itemName = "Blue Gem", clientId = 3041, sell = 5000 },
	{ itemName = "Green Gem", clientId = 3038, sell = 5000 },
	{ itemName = "Red Gem", clientId = 3039, sell = 1000 },
	{ itemName = "Violet Gem", clientId = 3036, sell = 10000 },
	{ itemName = "Yellow Gem", clientId = 3037, sell = 1000 },
	{ itemName = "Explorer Brooch", clientId = 4871, sell = 50 },
	{ itemName = "Necklace of the Deep", clientId = 13990, sell = 3000 },
	{ itemName = "Glooth Amulet", clientId = 21183, sell = 2000 },
	{ itemName = "Crystal Necklace", clientId = 3008, sell = 400 },
	{ itemName = "Ruby Necklace", clientId = 3016, sell = 2000 },
	{ itemName = "Wolf Tooth Chain", clientId = 3012, sell = 100 },
	{ itemName = "Dragon Necklace", clientId = 3085, sell = 100 },
	{ itemName = "Garlic Necklace", clientId = 3083, sell = 50 },
	{ itemName = "Beetle Necklace", clientId = 10457, sell = 1500 },
	{ itemName = "Ancient Amulet", clientId = 3025, sell = 200 },
	{ itemName = "Demonbone Amulet", clientId = 3019, sell = 32000 },
	{ itemName = "Golden Amulet", clientId = 3013, sell = 2000 },
	{ itemName = "Scarab Amulet", clientId = 3018, sell = 200 },
	{ itemName = "Star Amulet", clientId = 3014, sell = 500 },
	{ itemName = "Platinum Amulet", clientId = 3055, sell = 2500 },
	{ itemName = "Scarf", clientId = 3572, sell = 5 },
	{ itemName = "Amulet of loss", clientId = 3057, sell = 25000 },
	{ itemName = "Bronze Amulet", clientId = 3056, sell = 50 },
	{ itemName = "Elven amulet", clientId = 3082, sell = 100 },
	{ itemName = "Glacier amulet", clientId = 815, sell = 1500 },
	{ itemName = "Leviathans amulet", clientId = 9303, sell = 3000 },
	{ itemName = "Lightning pendant", clientId = 816, sell = 1500 },
	{ itemName = "Magma amulet", clientId = 817, sell = 1500 },
	{ itemName = "Protection amulet", clientId = 3084, sell = 100 },
	{ itemName = "Sacred Tree Amulet", clientId = 9302, sell = 3000 },
	{ itemName = "Shockwave Amulet", clientId = 9304, sell = 3000 },
	{ itemName = "Silver Amulet", clientId = 3054, sell = 25 },
	{ itemName = "Stone Skin Amulet", clientId = 3081, sell = 500 },
	{ itemName = "Strange Talisman", clientId = 3045, sell = 30 },
	{ itemName = "Terra Amulet", clientId = 814, sell = 1500 },
	{ itemName = "Gill Necklace", clientId = 16108, sell = 10000 },
	{ itemName = "Butterfly Ring", clientId = 25698, sell = 2000 },
	{ itemName = "Orb", clientId = 3060, sell = 750 },
	{ itemName = "orichalcum pearl", clientId = 5021, sell = 50 },
	{ itemName = "collar of blue plasma", clientId = 23542, sell = 6000 },
	{ itemName = "collar of green plasma", clientId = 23543, sell = 6000 },
	{ itemName = "collar of red plasma", clientId = 23544, sell = 6000 },
	{ itemName = "ring of blue plasma", clientId = 23529, sell = 8000 },
	{ itemName = "ring of green plasma", clientId = 23531, sell = 8000 },
	{ itemName = "ring of red plasma", clientId = 23533, sell = 8000 },
	{ itemName = "Crunor Idol", clientId = 30055, sell = 30000 },
	{ itemName = "Giant Emerald", clientId = 30060, sell = 90000 },
	{ itemName = "Giant Ruby", clientId = 30059, sell = 70000 },
	{ itemName = "Giant Sapphire", clientId = 30061, sell = 50000 },
	{ itemName = "Hexagonal Ruby", clientId = 30180, sell = 30000 },
	{ itemName = "Event Golden", clientId = 7369, sell = 6000 },
	{ itemName = "Event Silver", clientId = 7370, sell = 3000 },
	{ itemName = "Event Bronze", clientId = 7371, sell = 2000 },
	{ itemName = "Broken Ring of Ending", clientId = 12737, sell = 4000 },
	{ itemName = "werewolf amulet", clientId = 22060, sell = 3000 },
	{ itemName = "wedding ring", clientId = 3004, buy = 990 },
	{ itemName = "time ring", clientId = 3053, buy = 2000 },
	{ itemName = "sword ring", clientId = 3091, buy = 500 },
	{ itemName = "stealth ring", clientId = 3049, buy = 5000 },
	{ itemName = "signet ring", clientId = 349, buy = 15000 },
	{ itemName = "ring of healing", clientId = 3098, buy = 2000 },
	{ itemName = "power ring", clientId = 3050, buy = 100 },
	{ itemName = "might ring", clientId = 3048, buy = 5000 },
	{ itemName = "life ring", clientId = 3052, buy = 900 },
	{ itemName = "energy ring", clientId = 3051, buy = 2000 },
	{ itemName = "dwarven ring", clientId = 3097, buy = 2000 },
	{ itemName = "club ring", clientId = 3093, buy = 500 },
	{ itemName = "axe ring", clientId = 3092, buy = 500 },
	{ itemName = "Ruby Necklace", clientId = 3016, buy = 3560 },
	{ itemName = "Wolf Tooth Chain", clientId = 3012, buy = 400 },
	{ itemName = "Dragon Necklace", clientId = 3085, buy = 1000 },
	{ itemName = "Garlic Necklace", clientId = 3083, buy = 100 },
	{ itemName = "Golden Amulet", clientId = 3013, buy = 6600 },
	{ itemName = "Scarf", clientId = 3572, buy = 10 },
	{ itemName = "Bronze Amulet", clientId = 3056, buy = 100 },
	{ itemName = "Elven amulet", clientId = 3082, buy = 500 },
	{ itemName = "Protection amulet", clientId = 3084, buy = 700 },
	{ itemName = "Silver Amulet", clientId = 3054, buy = 50 },
	{ itemName = "Stone Skin Amulet", clientId = 3081, buy = 5000 },
	{ itemName = "Strange Talisman", clientId = 3045, buy = 100 },
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
