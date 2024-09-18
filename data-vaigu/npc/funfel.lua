local internalNpcName = "Funfel"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 154,
	lookHead = 114,
	lookBody = 49,
	lookLegs = 125,
	lookFeet = 0,
	lookAddons = 2,
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
	{ text = "Mikstury, runy, magia !" },
	{
		text = "Ale w tej dzungli goraco i wilgotno, a klimatyzacji nie ma do dzis....",
	},
	{ text = "Sklep magiczny, Funfel zaprasza, pelen asortyment !" },
	{ text = "Magiczne napoje i runy na wyprawe zawsze sie przydadza..." },
	{ text = "Abrakadabra, to czary i magia...." },
	{
		text = "Ehhh, gdyby tylko te cholerne malpy zostawily nasze magazyny w spokoju! Niech ktos pogada z przywodca malp.",
	},
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local questProgress = player:getStorageValue(Storage.TheApeCity.QuestProgress)
	if table.contains({ "syrop", "plyn", "fluid", "kaszel", "syrup" }, message) then
		if player:getStorageValue(Storage.TheApeCity.QuestProgress) == 3 then
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "W obecnej sytuacji mamy malo syropu na stanie. Ciagle zaczepki ze strony malp pozbawily nas duzej ilosci zapasow magazynie. Dlatego za jedna sztuke bedziesz musial zaplacic 1000 golda. Jestes w stanie nam tyle dac?"
					or "At the moment we're almost out of syrup. Those monkeys keep pestering us about it. That's why we charge 1000 gold for each bottle, do you have such money?",
				npc,
				creature
			)
			npcHandler:setTopic(playerId, 1)
		else
			npcHandler:say(
				getPlayerLanguage(player) == "PL" and "W zwiazku z cywilizacyjnym postepem i zamieszkaniem w miastach, a co za tym idzie, odwroceniem sie od natury, ludzie zaczeli mocno chorowac. A my jestesmy dystrybutorem i ekseporterem lekarstwa na swiat. Ehhh, gdyby tylko te cholerne malpy zostawily nasze magazyny w spokoju! Niech ktos pogada z przywodca malp."
					or "Urbanisation and the progress of civilization, which in turn meant ignorance towards the forces of nature, caused many people to fall ill. We export and sell medicine all over the world. If only those pesky monkeys could leave our warehouse alone.",
				npc,
				creature
			)
		end
	elseif table.contains({ "tak", "yes" }, message) then
		if npcHandler:getTopic(playerId) == 1 then
			if not player:removeMoney(1000) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Ale najpierw bedziesz musial zaplacic." or "I dont think you have enough money for that.", npc, creature)
			else
				player:addItem(4828, 1)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Zdrowia zycze." or "I wish you health.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Slucham?" or "What?", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "no", "nie" }, message) then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Wiem, ze to wysoka cena, ale budzetowka nas zje, jesli im w priorytecie nie przyniesiemy." or "I am aware this is a lot, but this is the cost of the top notch service.", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "O co ci chodzi?" or "What do you want?", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "krag", "kregi", "circles", "cromlech" }, message) and player:getStorageValue(Storage.PathOfTheUndead.Questline) == 2 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Krag ten znajduje sie za wzgorzem orkow na zachodzie miasta. W okolicy kreca sie tez szczuroludzie." or "This cromlech is located behind the orc hill in the west of the city. There's also corym village nearby.", npc, creature)
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Hej hej |PLAYERNAME|. Tylko naturalne plyny.")
npcHandler:setMessage(MESSAGE_DECLINE, "A wez idz, szkoda Ci |TOTALCOST| na takie precjoza...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello, hello |PLAYERNAME|. Only organic fluids.')
-- npcHandler:setMessage(MESSAGE_DECLINE_ENG, 'What?! You wont even spend |TOTALCOST| for this?')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = {
	{ itemName = "small potion flask", clientId = 285, sell = 5 },
	{ itemName = "strong potion flask", clientId = 283, sell = 10 },
	{ itemName = "great potion flask", clientId = 284, sell = 15 },
	{ itemName = "wand of vortex", clientId = 3074, sell = 50 },
	{ itemName = "wand of dragonbreath", clientId = 3075, sell = 200 },
	{ itemName = "wand of decay", clientId = 3072, sell = 1000 },
	{ itemName = "wand of draconia", clientId = 8093, sell = 1500 },
	{ itemName = "wand of cosmic energy", clientId = 3073, sell = 2000 },
	{ itemName = "wand of inferno", clientId = 3071, sell = 3000 },
	{ itemName = "wand of starstorm", clientId = 8092, sell = 3600 },
	{ itemName = "wand of voodoo", clientId = 8094, sell = 4400 },
	{ itemName = "snakebite rod", clientId = 3066, sell = 50 },
	{ itemName = "moonlight rod", clientId = 3070, sell = 200 },
	{ itemName = "necrotic rod", clientId = 3069, sell = 1000 },
	{ itemName = "northwind rod", clientId = 8083, sell = 1500 },
	{ itemName = "terra rod", clientId = 3065, sell = 2000 },
	{ itemName = "hailstorm rod", clientId = 3067, sell = 3000 },
	{ itemName = "springsprout rod", clientId = 8084, sell = 3600 },
	{ itemName = "underworld rod", clientId = 8082, sell = 4400 },
	{ itemName = "ogre scepta", clientId = 22183, sell = 3600 },
	{ itemName = "dream blossom staff", clientId = 25700, sell = 5000 },
	{ itemName = "muck rod", clientId = 16117, sell = 6000 },
	{ itemName = "glacial rod", clientId = 16118, sell = 6500 },
	{ itemName = "wand of defiance", clientId = 16096, sell = 6500 },
	{ itemName = "wand of everblazing", clientId = 16115, sell = 6000 },
	{ itemName = "ultimate mana potion", clientId = 23373, buy = 360 },
	{ itemName = "ultimate spirit potion", clientId = 23374, buy = 350 },
	{ itemName = "supreme health potion", clientId = 23375, buy = 620 },
	{ itemName = "vial", clientId = 2874, subType = 5, buy = 50 },
	{ itemName = "spellbook", clientId = 3059, buy = 150 },
	{ itemName = "magic lightwand", clientId = 3046, buy = 400 },
	{ itemName = "blank rune", clientId = 3147, buy = 10 },
	{ itemName = "health potion", clientId = 266, buy = 45 },
	{ itemName = "mana potion", clientId = 268, buy = 50 },
	{ itemName = "strong health potion", clientId = 236, buy = 110 },
	{ itemName = "strong mana potion", clientId = 237, buy = 90 },
	{ itemName = "great health potion", clientId = 239, buy = 220 },
	{ itemName = "great mana potion", clientId = 238, buy = 140 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 190 },
	{ itemName = "ultimate health potion", clientId = 7643, buy = 350 },
	{ itemName = "antidote potion", clientId = 7644, buy = 50 },
	{ itemName = "fireball rune", clientId = 3189, buy = 30 },
	{ itemName = "intense healing rune", clientId = 3152, buy = 95 },
	{ itemName = "ultimate healing rune", clientId = 3160, buy = 175 },
	{ itemName = "magic wall rune", clientId = 3180, buy = 116 },
	{ itemName = "destroy field rune", clientId = 3148, buy = 25 },
	{ itemName = "light magic missile rune", clientId = 3174, buy = 10 },
	{ itemName = "heavy magic missile rune", clientId = 3198, buy = 12 },
	{ itemName = "great fireball rune", clientId = 3191, buy = 55 },
	{ itemName = "explosion rune", clientId = 3200, buy = 31 },
	{ itemName = "sudden death rune", clientId = 3155, buy = 120 },
	{ itemName = "paralyze rune", clientId = 3165, buy = 700 },
	{ itemName = "animate dead rune", clientId = 3203, buy = 375 },
	{ itemName = "convince creature rune", clientId = 3177, buy = 80 },
	{ itemName = "chameleon rune", clientId = 3178, buy = 210 },
	{ itemName = "desintegrate rune", clientId = 3197, buy = 26 },
	{ itemName = "icicle rune", clientId = 3158, buy = 30 },
	{ itemName = "avalanche rune", clientId = 3161, buy = 55 },
	{ itemName = "fire bomb rune", clientId = 3192, buy = 147 },
	{ itemName = "energy bomb rune", clientId = 3149, buy = 203 },
	{ itemName = "poison bomb rune", clientId = 3173, buy = 85 },
	{ itemName = "fire wall rune", clientId = 3190, buy = 61 },
	{ itemName = "energy wall rune", clientId = 3166, buy = 85 },
	{ itemName = "poison wall rune", clientId = 3176, buy = 52 },
	{ itemName = "wild growth rune", clientId = 3156, buy = 160 },
	{ itemName = "stone shower rune", clientId = 3175, buy = 37 },
	{ itemName = "thunderstorm rune", clientId = 3202, buy = 47 },
	{ itemName = "soulfire rune", clientId = 3195, buy = 46 },
	{ itemName = "fire field rune", clientId = 3188, buy = 28 },
	{ itemName = "poison field", clientId = 3172, buy = 21 },
	{ itemName = "energy field", clientId = 3164, buy = 38 },
	{ itemName = "wand of vortex", clientId = 3074, buy = 500 },
	{ itemName = "wand of dragonbreath", clientId = 3075, buy = 1000 },
	{ itemName = "wand of decay", clientId = 3072, buy = 5000 },
	{ itemName = "wand of draconia", clientId = 8093, buy = 7500 },
	{ itemName = "wand of cosmic energy", clientId = 3073, buy = 10000 },
	{ itemName = "wand of inferno", clientId = 3071, buy = 15000 },
	{ itemName = "wand of starstorm", clientId = 8092, buy = 18000 },
	{ itemName = "wand of voodoo", clientId = 8094, buy = 22000 },
	{ itemName = "snakebite rod", clientId = 3066, buy = 500 },
	{ itemName = "moonlight rod", clientId = 3070, buy = 1000 },
	{ itemName = "necrotic rod", clientId = 3069, buy = 5000 },
	{ itemName = "northwind rod", clientId = 8083, buy = 7500 },
	{ itemName = "terra rod", clientId = 3065, buy = 10000 },
	{ itemName = "hailstorm rod", clientId = 3067, buy = 15000 },
	{ itemName = "springsprout rod", clientId = 8084, buy = 18000 },
	{ itemName = "underworld rod", clientId = 8082, buy = 22000 },
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
