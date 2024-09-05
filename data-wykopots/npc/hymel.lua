local internalNpcName = "Hymel"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 159,
	lookHead = 94,
	lookBody = 77,
	lookLegs = 78,
	lookFeet = 79,
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

local config = nil
local lang_to_config = {
	["PL"] = {
		[1] = "Jak chcesz nowa zapalniczke to ci opchne, wiecej za darmo nie dostaniesz. Jak cos to popros o {handel}.",
		[2] = {
			"Eeeekstra to bylo, z daleka widze ten dym ktory zaraz bede wdychac. ...",
			"Trzymaj za swoje zaslugi bron, ktora bedziesz mogl wszystko zawsze podpalac. ...",
			"Dzieki za zabawe, do zobaczenia!",
		},
		[3] = "Zglos sie po nagrode po zdobyciu 20 poziomu!",
		[4] = {
			"Raz z koleszkami mialem zabawe i sialismy w calym MirkoTown toksyczne kwiaty, niektore byly poza murami miasta. ...",
			"Niestety nie jestem w stanie ci powiedziec, ktore to dokladnie, bo wygladaja jak zwykle czerwone kwiatki. ...",
			"Jak je zjarasz, to pewnie cale miasto bedzie na haju, zajmiesz sie tym?",
		},
		[5] = {
			"Szkoda, ze nie moge zobaczyc ich min jak sie skapna. ...",
			"Rozkrecasz sie, jak cie najdzie chetka to przyjdz po wiecej! Trzymaj za to laske prawdziwego jaracza!",
		},
		[6] = {
			"Jak jeszcze mieszkalem w MirkoTown to ogarnalem miejsce gdzie straznicy ida na przerwe, siedza przy ognisku i odpoczywaja. ...",
			"Podpal im drzewo przy ktorym siedza, a napewno sie wnerwia. ...",
			"Piszesz sie na to?",
		},
		[7] = {
			"Zajebiscie sie jara stary, mam nadzieje ze straznicy sie zbyt nie spala xD. ...",
			"Widze ze ci sie to spodobalo, jak bedziesz miec ochote to pytaj, cos jeszcze podpalimy, a {zapalniczke} sobie zostaw, jesli ci nie wybuchla.",
		},
		[8] = {
			"Oo tak, podpalil bym cos, moze te szczury z MirkoTown? Wyeksmitowali mnie przez moje zapedy pirotechniczne. ...",
			"Chcesz cos ze mna podpalic?",
		},
		[9] = {
			"To jak chcesz sie pobawic, to najpierw spal dla mnie ziolo, ktore zostalo w mojej chacie. Lepiej zeby straznicy nie znalezli go, bo bede musial jeszcze dalej uciekac. ...",
			"Sam nie moge sie pokazywac w miescie, moja chata lezy na polnocy miasta, od razu poznasz ta meline xD. ...",
			"Trzymaj {zapalniczke}, przyda ci sie. Gdyby wybuchla, to popros o {trade}, albo od razu kup na zapas.",
		},
	},
	["EN"] = {
		[1] = "If you want a new lighter I can sell you one, you won't get another one for free. If you want to buy it just ask for {trade}. ",
		[2] = {
			"It was great! I already can see that smoke I'll be breathing in. ...",
			"Take this weapon for your achievements, you will be able to burn more stuff with it. ...",
			"That was fun! See you!",
		},
		[3] = "Come back when you reach 20 level.",
		[4] = {
			"Once with my fellas we were having fun and we planted some toxic flowers in Mirkotown, some of them were beyond city walls.",
			"Sadly I am not able to tell you which ones exactly because they look like normal red flowers. ...",
			"If you burn them the whole city will be high, would you do that?",
		},
		[5] = {
			"Too bad that I won't see their faces when they will find out. ...",
			"You're getting better, if you will need more just come back! Take this staff for the real smoker!",
		},
		[6] = {
			"When I was still living in MirkoTown I've seen place where guards are going for a brake, they are sitting around campfire and rest there. ...",
			"Set the tree on fire near them, they will get mad for sure. ...",
			"Are you down for that?",
		},
		[7] = {
			"It burns so nice dude, I'm hoping that guards won't get too high xD ...",
			"I see that you liked it, if you want to burn some more just ask, you can keep the {lighter} if it hasn't exploded yet.",
		},
		[8] = {
			"Ohh Yes, I would burn something, maybe those rats from Mirkotown? They evicted me for my pyrotechnic tendencies. ...",
			"Wanna set somethin' on fire?",
		},
		[9] = {
			"If you want to play a little bit, go and burn some weed which I left in my house. Better for me if guards won't find it otherwise I'll have to run away. ...",
			"I can't show myself in the city, my cottage is located in the north of the city, you will recognize it immediately. ...",
			"Get this {fire bug}, you'll need it.",
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

	-- PODPALACZ QUEST ---
	if table.contains({
		"zapalniczke",
		"zapalniczka",
		"bug",
		"podpalic",
		"fire",
		"lighter",
	}, message) and player:getStorageValue(Storage.Firestarter.Mission1) > 0 then
		npcHandler:say(config[1], npc, creature)
	end
	if MsgContains(message, "zajarac") or MsgContains(message, "mission") or MsgContains(message, "misja") then
		if player:getStorageValue(Storage.Firestarter.Mission3) == 2 then
			if player:getLevel() >= 20 then
				player:setStorageValue(Storage.Firestarter.Mission3, 3)
				player:setStorageValue(Storage.Finished.Firestarter, 1) -- quest done (website)
				player:addItem(3280) -- fire sword
				player:addItem(3731, 5) -- 5 fire mushroom
				-- Q5.1
				player:addExperience(45000, true) -- 45k expa
				player:getPosition():sendMagicEffect(CONST_ME_STUN)
				-- Q5.1
				npcHandler:say(config[2], npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say(config[3], npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
		if player:getStorageValue(Storage.Firestarter.Mission2) == 3 and player:getStorageValue(Storage.Firestarter.Mission3) < 1 then
			npcHandler:say(config[4], npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
		if player:getStorageValue(Storage.Firestarter.Mission2) == 2 then
			if player:getLevel() >= 20 then
				player:setStorageValue(Storage.Firestarter.Mission2, 3)
				player:addItem(7430, 1) -- dragonbone staff
				player:addItem(3731, 5) -- 5 fire mushroom
				-- Q5.1
				player:addExperience(40000, true) -- 40k expa
				player:getPosition():sendMagicEffect(CONST_ME_STUN)
				-- Q5.1
				npcHandler:say(config[5], npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say(config[3], npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
		if player:getStorageValue(Storage.Firestarter.Mission1) == 3 and player:getStorageValue(Storage.Firestarter.Mission2) < 1 then
			npcHandler:say(config[6], npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
		if player:getStorageValue(Storage.Firestarter.Mission1) == 2 then
			if player:getLevel() >= 20 then
				player:setStorageValue(Storage.Firestarter.Mission1, 3)
				-- Q5.1
				player:addItem(3731, 5) -- 5 fire mushroom
				player:addExperience(20000, true) -- 20k expa
				player:getPosition():sendMagicEffect(CONST_ME_STUN)
				-- Q5.1
				npcHandler:say(config[7], npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 20 poziomu!" or "Come back when you reach 20 level.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
		if player:getStorageValue(Storage.Firestarter.Mission1) < 1 then
			npcHandler:say(config[8], npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	end
	if MsgContains(message, "yes") or MsgContains(message, "tak") then
		if npcHandler:getTopic(playerId) == 1 and player:getStorageValue(Storage.Firestarter.Mission2) == 3 and player:getStorageValue(Storage.Firestarter.Mission3) < 1 then
			player:setStorageValue(Storage.Firestarter.Mission3, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Wiedzialem ze moge na ciebie liczyc, uwazaj tylko na ten stuff." or "I wanted to know if you are reliable, just be careful with that stuff.", npc, creature)
		end
		if npcHandler:getTopic(playerId) == 1 and player:getStorageValue(Storage.Firestarter.Mission1) == 3 and player:getStorageValue(Storage.Firestarter.Mission2) < 1 then
			player:setStorageValue(Storage.Firestarter.Mission2, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Tylko nie traf na ich przerwe, bo nie mam dodatkowego lozka xD." or "Just don't go there on their brake, I don't have more beds xD.", npc, creature)
		end
		if npcHandler:getTopic(playerId) == 1 and player:getStorageValue(Storage.Firestarter.Mission1) < 1 then
			player:setStorageValue(Storage.Firestarter.Mission1, 1)
			player:addItem(5467, 1) -- dostaje firebuga
			npcHandler:say(config[9], npc, creature)
		end
	end
	-- PODPALACZ QUEST ---

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Elo |PLAYERNAME|. Idziemy {zajarac}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Z dymem!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Z dymem!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Yo, |PLAYERNAME|! You want to {smoke} some?')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Stay high!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'Stay high!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = { { itemName = "fire bug", clientId = 5467, buy = 500 } }
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
