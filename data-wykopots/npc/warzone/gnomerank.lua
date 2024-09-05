local internalNpcName = "Gnomerank"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 507,
	lookHead = 11,
	lookBody = 6,
	lookLegs = 11,
	lookFeet = 57,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = 0,
}

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

local t = {}
local renown = {}

local function greetCallback(npc, creature)
	npcHandler:setMessage(MESSAGE_GREET, "Witaj, jesli masz wystarczajace doswiadczenie, to moge cie {awansowac}! Spytaj o {rangi} po wiecej informacji ...")
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "awans", "awansowac", "advance" }, message) then
		if player:getStorageValue(Storage.BigfootBurden.Rank) >= 30 and player:getStorageValue(Storage.BigfootBurden.Rank) < 80 then -- 30-90
			if player:getStorageValue(Storage.BigfootBurden.QuestLine) == 14 then
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 15)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say("Otrzymujesz range Pomocnik Gnomow.", npc, creature)
				player:addAchievement("Pomocnik Gnomow")
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Posiadasz odpowiednia range." or "You have appropriate rank.", npc, creature)
			end
		elseif player:getStorageValue(Storage.BigfootBurden.Rank) >= 80 and player:getStorageValue(Storage.BigfootBurden.Rank) < 160 then --90-240
			if player:getStorageValue(Storage.BigfootBurden.QuestLine) <= 15 then
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 16)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say("Otrzymujesz range Przyjaciel Gnomow.", npc, creature)
				player:addAchievement("Przyjaciel Gnomow")
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Posiadasz odpowiednia range." or "You have appropriate rank.", npc, creature)
			end
		elseif player:getStorageValue(Storage.BigfootBurden.Rank) >= 160 and player:getStorageValue(Storage.BigfootBurden.Rank) < 320 then --240-430
			if player:getStorageValue(Storage.BigfootBurden.QuestLine) <= 16 then
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 17)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say('Otrzymujesz range "Niczym Gnom".', npc, creature)
				player:addAchievement("Niczym Gnom")
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Posiadasz odpowiednia range." or "You have appropriate rank.", npc, creature)
			end
		elseif player:getStorageValue(Storage.BigfootBurden.Rank) >= 320 then -- 430
			if player:getStorageValue(Storage.BigfootBurden.QuestLine) <= 17 then
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 18)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say("Otrzymujesz range Honorowy Gnom.", npc, creature)
				player:addAchievement("Honorowy Gnom")
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Posiadasz odpowiednia range." or "You have appropriate rank.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie moge cie awansowac." or "I cant advance you yet.", npc, creature)
		end
	elseif MsgContains(message, "rangi") or MsgContains(message, "ranks") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Wsrod gnomow wyrozniamy cztery rangi, sa to {Pomocnik Gnomow}, {Przyjaciel Gnomow}, {Niczym Gnom} oraz {Honorowy Gnom}." or "In gnome community we have four ranks, which are {Gnome Little Helper}, {Gnome Friend}, {Gnomelike} and {Honorary Gnome}", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "pomocnik gnomow") or MsgContains(message, "gnome little helper") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Jest to najnizsza ranga, potrzebujesz 30 punktow reputacji aby ja zdobyc." or "Thats the lowest rank. You need to colled 30 points to advance.", npc, creature)
		end
	elseif MsgContains(message, "przyjaciel gnomow") or MsgContains(message, "gnome friend") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Porzebujesz 80 punktow reputacji aby adobyc te range. Umozliwia ci ona wykonywanie powazniejszych zadan." or "You need to collect 80 points for this rank. It allows you to take new missions.", npc, creature)
		end
	elseif MsgContains(message, "niczym gnom") or MsgContains(message, "gnomelike") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz 160 punktow reputacji aby adobyc te range. Umozliwia ci ona wykonywanie powazniejszych zadan." or "You need to collect 160 points for this rank. It allows you to take new missions.", npc, creature)
		end
	elseif MsgContains(message, "honorowy gnom") or MsgContains(message, "honorary gnome") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz 320 punktow reputacji aby zdobyc te range. Umozliwia ci ona wejscie do strefy wojny." or "You need to collect 160 points for this rank. It allows you to entry warzone.", npc, creature)
		end
	end
	return true
end

local function onReleaseFocus(npc, creature)
	t[creature], renown[creature] = nil, nil
end

local function onAddFocus(npc, creature)
	local playerId = creature:getId()
end

local function onReleaseFocus(npc, creature)
	local playerId = creature:getId()
end

npcHandler:setCallback(CALLBACK_SET_INTERACTION, onAddFocus)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

npcHandler:setMessage(MESSAGE_GREET, "Witaj, jesli masz juz wystarczajace doswiadczenie to moge cie {awansowac}!")
--npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello! I can {advance} you, if youre experienced enough!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
