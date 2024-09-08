local internalNpcName = "Anon's father"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 129,
	lookHead = 97,
	lookBody = 79,
	lookLegs = 87,
	lookFeet = 115,
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

local config = nil
local lang_to_config = {
	["PL"] = {
		[1] = "Aby zobaczyc, co mam w swojej ofercie, napisz {trade}.",
		[2] = {
			"Panie, ja tu sobie spokojnie lowie ryby, az tu nagle jakis czlowiek wyplywa na powierzchnie.",
			"Mowisz ze jest zlodziejem? - pobiegl o tam, na wschod.",
		},
		[4] = "Jaki zlodziej, co ty pieprzysz..",
		[5] = "Przyniosles ze soba moja paczke?",
		[6] = "Dziekuje Ci za wyjasnienie tej sprawy. Oto twoja nagroda. Jesli to nie klopot, to  mam jeszcze inny {problem}, z ktorym moglbys mi pomoc.",
		[7] = "Wroc do mnie jak wyjasnisz te sprawe z Old Postmanem.",
		[8] = "Sluchaj, na przestrzeni ostatnich kilku lat zgubilem kilka komponentow mojego sprzetu wedkarskiego w roznych oczkach wodnych i jeziorkach kolo mirko. Dokladnie to zgubilem drewniany {splawik}, {spinning} oraz moj stary {stolek}. Znajdz wszystkie te przedmioty i wroc do mnie.",
		[9] = "Znalazles ktorys z moich przedmiotow?",
		[10] = "Ktory z przedmiotow znalazles? Byl to {spinning}, {splawik} orak {stolek}.",
		[11] = "Super! Mam nadzieje, ze reszte tez masz.",
		[12] = "Dzieki! Oto twoja na nagroda. Ale chwila! - ktos pogryzmolil moj stolek mazakiem! Nosz {kuuurla}..",
		[13] = "Nie masz tego przedmiotu.",
		[14] = "Juz mi go oddales.",
		[15] = "Wpadl mi kiedys do stawku obok. Mam nadzieje, ze go znajdziesz.",
		[16] = "Na moj aktualny stan pomoze tylko bigos z chinska cebula ping pong, miesem z niedojonego stuletniego byka wychowanego przez wilki i wszystko podlane winem ukradzionym z winnicy kutonapletonu. Ewentualnie moze tez byc zwykla {zupa} rotwormowa.",
		[17] = "Mlask mlask... Juz mi lepiej. W sumie to nie daje rady, reszte mozesz zabrac. Zjedz albo oddaj potrzebujacym. Swoja nagrode mozesz odebrac u Mojego {syna}.",
		[18] = "Wroc z zupa, bo nie recze!",
		[19] = "Zajmuje sie on transportem morskim. Mozesz go znalezc w zachodniej czesci przedmiesci Mirkotown.",
		[20] = "Zgubilem go lowiac za zachodnia brama. Mam nadzieje, ze go znajdziesz.",
		[21] = "Wpadl mi do wody nad jeziorkiem przy plazy. Mam nadzieje, ze go znajdziesz.",
	},
	["EN"] = {
		[1] = "Say {trade} if you want to see my offer.",
		[2] = {
			"Mister, I’m just fishing here quietly, and all of the sudden I see a man flows to the surface.",
			"Youre saying that he is a thief? - he ran that way, to the east.",
		},
		[4] = "I dont know what you're talking about",
		[5] = "Did you bring my package with you?",
		[6] = "Thank you for clarifying this matter. Here's your reward. If you're willing, I have another {problem} that you could help me with.",
		[7] = "Come back to me once you've resolved the matter with the Old Postman.",
		[8] = "Listen, over the past few years, I've lost a few components of my fishing gear in various ponds and lakes around Mirko. Specifically, I lost my wooden {float}, {reel}, and my old {stool}. Find all these items and return to me.",
		[9] = "Have you found any of my items?",
		[10] = "Which of the items did you find? It was either the {reel}, {float}, or the {stool}.",
		[11] = "Great! I hope you have the rest as well.",
		[12] = "Thank you! Here's your reward. Wait a moment! Someone scribbled on my chair with a marker! Oh, darn it...",
		[13] = "You don't have that item.",
		[14] = "You've already given it to me.",
		[15] = "It fell into the small pond nearby once. I hope you find it.",
		[16] = "For my current condition, only a stew with Chinese ping pong onion, meat from an under-milked centennial bull raised by wolves, all topped with wine stolen from the Kutonapleton winery, will help. Alternatively, a simple rotworm {stew} might do the trick.",
		[17] = "Slurp slurp... I'm feeling better now. To be honest, I can't finish the rest. Either eat or give it to those in need. You can collect your reward from my {son}.",
		[18] = "Return with the stew, or I won't vouch for anything!",
		[19] = "He's involved in maritime transport. You can find him in the western part of the suburbs of Mirkotown.",
		[20] = "I lost it while fishing by the western gate. I hope you can find it.",
		[21] = "It slipped into the water by the lake at the beach. I hope you find it.",
	},
}

local function fajtlapaRewards(creature)
	local player = Player(creature)
	player:setStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa, 2) -- mission - finish
	player:setStorageValue(Storage.UstatkowanyFanatyk.Bigos, 1)
	player:addExperience(40000, true) -- 10k expa
	player:addItem(12735, 1) -- shimmer glower
	player:addItem(7457, 1) -- fur boots
	player:addOutfitAddon(157, 1) -- beggar outfit
	player:addOutfitAddon(153, 1) -- beggar outfit
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	config = GetConfigByPlayer(creature, lang_to_config)

	if table.contains({ "sprzet", "sprzet wedkarski", "oferta", "ofert" }, message) then
		npcHandler:say(config[1], npc, creature)
	elseif table.contains({ "zlodziej", "thief" }, message) then
		if player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) == 8 then
			npcHandler:say(config[2], npc, creature)
			if player:getStorageValue(Storage.IKEAdlazuchwalych.StaryAsked) <= 0 then
				player:setStorageValue(Storage.IKEAdlazuchwalych.ZlodziejAsked, player:getStorageValue(Storage.IKEAdlazuchwalych.ZlodziejAsked) + 1)
				player:setStorageValue(Storage.IKEAdlazuchwalych.StaryAsked, 1)
			end
			if player:getStorageValue(Storage.IKEAdlazuchwalych.ZlodziejAsked) >= 2 then
				player:setStorageValue(Storage.IKEAdlazuchwalych.RemanentMain, 9)
			end
		else
			npcHandler:say(config[4], npc, creature)
		end
	elseif table.contains({ "paczka", "paczke", "mission", "misja", "puszka" }, message) and player:getStorageValue(Storage.UstatkowanyFanatyk.Zastoj) == 1 then
		npcHandler:say(config[5], npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 1 then
		local item = player:getItemById(15817, 1)
		if item and item.actionid == 11086 then
			item:remove()
			npcHandler:say(config[6], npc, creature)
			player:setStorageValue(Storage.UstatkowanyFanatyk.Zastoj, 2)
			player:addExperience(10000, true) -- 10k expa
			player:addItem(12807, 1) -- shimmer ball
			player:addOutfitAddon(157, 0) -- beggar outfit
			player:addOutfitAddon(153, 0) -- beggar outfit
		else
			npcHandler:say(config[7], npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "no", "nie" }, message) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say(config[7], npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "mission", "misja", "problem" }, message) and (player:getStorageValue(Storage.UstatkowanyFanatyk.Zastoj) == 2 and player:getStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa) <= 0) then
		player:setStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa, 1)
		player:setStorageValue(Storage.UstatkowanyFanatyk.FajtlapaItems, 0)
		npcHandler:say(config[8], npc, creature)
	elseif table.contains({ "mission", "misja" }, message) and player:getStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa) == 1 then
		npcHandler:say(config[9], npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say(config[10], npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "splawik", "float" }, message) and player:getStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa) == 1 then
		if player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaSplawik) == 1 then
			local item = player:getItemById(6126, 1)
			if item and item.actionid == 11088 then
				item:remove()
				player:setStorageValue(Storage.UstatkowanyFanatyk.FajtlapaSplawik, 2)
				if player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaItems) >= 2 then -- all items
					npcHandler:say(config[12], npc, creature)
					fajtlapaRewards(player)
				else -- not all items
					npcHandler:say(config[11], npc, creature)
					player:setStorageValue(Storage.UstatkowanyFanatyk.FajtlapaItems, player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaItems) + 1)
				end
			else
				npcHandler:say(config[13], npc, creature) -- brak item
			end
		elseif player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaSplawik) == 2 then
			npcHandler:say(config[14], npc, creature) -- oddany
		else
			npcHandler:say(config[15], npc, creature) -- nadzieja
		end
	elseif table.contains({ "spinning", "reel" }, message) and player:getStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa) == 1 then
		if player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaSpinning) == 1 then
			local item = player:getItemById(3224, 1)
			if item and item.actionid == 11090 then
				item:remove()
				player:setStorageValue(Storage.UstatkowanyFanatyk.FajtlapaSpinning, 2)
				if player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaItems) >= 2 then -- all items
					npcHandler:say(config[12], npc, creature)
					fajtlapaRewards(player)
				else -- not all items
					npcHandler:say(config[11], npc, creature)
					player:setStorageValue(Storage.UstatkowanyFanatyk.FajtlapaItems, player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaItems) + 1)
				end
			else
				npcHandler:say(config[13], npc, creature) -- brak item
			end
		elseif player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaSpinning) == 2 then
			npcHandler:say(config[14], npc, creature) -- oddany
		else
			npcHandler:say(config[20], npc, creature) -- nadzieja spinning
		end
	elseif table.contains({ "stolek", "stool" }, message) and player:getStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa) == 1 then
		if player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaStolek) == 1 then
			local item = player:getItemById(3107, 1)
			if item and item.actionid == 11092 then
				item:remove()
				player:setStorageValue(Storage.UstatkowanyFanatyk.FajtlapaStolek, 2)
				if player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaItems) >= 2 then -- all items
					npcHandler:say(config[12], npc, creature)
					fajtlapaRewards(player)
				else -- not all items
					npcHandler:say(config[11], npc, creature)
					player:setStorageValue(Storage.UstatkowanyFanatyk.FajtlapaItems, player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaItems) + 1)
				end
			else
				npcHandler:say(config[13], npc, creature) -- brak item
			end
		elseif player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaStolek) == 2 then
			npcHandler:say(config[14], npc, creature) -- oddany
		else
			npcHandler:say(config[21], npc, creature) -- nadzieja
		end
	elseif table.contains({ "kuuurla", "mission", "misja", "nastroj" }, message) and player:getStorageValue(Storage.UstatkowanyFanatyk.Bigos) == 1 then
		npcHandler:say(config[16], npc, creature)
		player:setStorageValue(Storage.UstatkowanyFanatyk.Bigos, 2)
	elseif table.contains({ "bigos", "zupa", "soup", "stew", "mission", "misja" }, message) and player:getStorageValue(Storage.UstatkowanyFanatyk.Bigos) == 2 then
		if player:getItemCount(9079) >= 1 then
			npcHandler:say(config[17], npc, creature) -- jest zupka
			player:setStorageValue(Storage.UstatkowanyFanatyk.Bigos, 3)
		else
			npcHandler:say(config[18], npc, creature) -- ni ma zupka
		end
	elseif table.contains({ "syn", "syna", "son", "mission", "misja" }, message) and player:getStorageValue(Storage.UstatkowanyFanatyk.Bigos) == 3 then
		npcHandler:say(config[19], npc, creature) -- o synie
	end
	return true
end

local function onAddFocus(npc, creature)
	local player = Player(creature)
	npcHandler:say(getPlayerLanguage(player) == "PL" and "No witam, mam do zaoferowania {sprzet wedkarski} oraz skupuje ryby." or "Hello, I {trade} with fishing equipment, take a look at my offer if you want.", npc, creature)
end

npcHandler:setCallback(CALLBACK_SET_INTERACTION, onAddFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "fishing rod", clientId = 3483, buy = 100 },
	{ itemName = "worm", clientId = 3492, buy = 1 },
	{ itemName = "fish", clientId = 3578, buy = 5 },
	{ itemName = "potrawa rybacka", clientId = 9088, buy = 10000 },
	{ itemName = "marlin", clientId = 901, sell = 200 },
	{ itemName = "pstrag", clientId = 7158, sell = 90 },
	{ itemName = "szczupak", clientId = 3580, sell = 35 },
	{ itemName = "okon", clientId = 7159, sell = 15 },
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
