local internalNpcName = "Mazarius"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 78,
	lookBody = 76,
	lookLegs = 0,
	lookFeet = 19,
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

local items = { item1 = { 6499, 22182 } }
local counts = { count1 = { 30, 1 } }

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "otchlan", "piekielna otchlan", "piekielne otchlanie" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Nigdy nie bylo to miejsce przyjazne smiertelnikom. Z tego powodu wlasnie ukryl sie tam jeden z najpotezniejszych magow naszych czasow.",
			"Nieznane nikomu korytarze wypelnione sa najstraszniejszymi kreaturami, podobno ukrywaja sie za nimi opetani {podwladni} poteznego maga, ktory przekazal im czesc swojej energii.",
		} or {
			"This place was never friendly for mortals. That's why one of the most powerful wizards is hiding out there. ...",
			"Unknown corridors are full of horrifying creatures, I've heard that possesed {ruthless seven} of a powerful wizard are hiding in there, he gave them some of his powers.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "podwladni", "ruthless seven" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Siedem poteznych bestii, ktorych nikt nawet nie podjal sie pokonac. Dopiero po zwalczeniu ich wszystkich mozna dostac sie do glownej komnaty maga. ...",
			"Byc moze bedziesz jednym z pierwszych, jednak na pewno nie uda ci sie to w pojedynke. ...",
			"Potwierdz jesli chcesz sie tego podjac.",
		} or {
			"Seven powerful beasts, which nobody even tried to conquer. After killing all of them you will be able to get to the main chamber with the wizard. ...",
			"Maybe you will be the first one, but you won't make it on your own. ...",
			"Confirm if you're down for that.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "yes", "tak", "potwierdzam", "confirm" }, message) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Abym mial pewnosc, ze nie zginiesz tam zaraz po wejsciu, udowodnij mi swoje doswiadcznie, i pokonaj troche demonow znajdujacych sie po naszej stronie swiata..",
			"Przynies mi 30 {demonicznych esencji} jako dowod, wtedy dam ci pozwolenie na przejscie..",
		} or {
			"To make sure that you wont fail right after entering the portal, prove your strength by bringing me 30 {demonic essence}s.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({
		"demonic essence",
		"demoniczne esencje",
		"demonicznych esencji",
	}, message) then
		if player:getStorageValue(Storage.Ferumbras.EssencesBringed) <= 0 then
			if getPlayerItemCount(creature, items.item1[1]) >= counts.count1[1] then
				doPlayerRemoveItem(creature, items.item1[1], counts.count1[1])
				doPlayerAddItem(creature, items.item1[2], counts.count1[2])
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Swietnie! Mozesz teraz uzyc mojego teleportu." or "Great, you can use teleport now!", npc, creature)
				player:setStorageValue(Storage.Ferumbras.EssencesBringed, 1)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz " .. counts.count1[1] .. " " .. getItemName(items.item1[1]) .. ", aby uzyskac dostep." or "You still need to bring me " .. counts.count1[1] .. " " .. getItemName(items.item1[1]) .. " to let me pass you there.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Posiadasz juz dostep." or "You are able to pass there.", npc, creature)
		end
		return true
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|. Zapewne przyslal cie Mezamir, na pewno nie wtargnales tu przypadkiem.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Narazie!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. How did you get there?! Probably Mezamir let you in.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
