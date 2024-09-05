local internalNpcName = "Narro"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
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
	{ text = "Uwazaj podrozniku, Ryba zasadzil sie na Ciebie!" },
	{ text = "Welcome to Knurrrow" },
	{
		text = "Mysleliscie ze mozna mnie bezkarnie ponizac? Ze bede waszym popychadlem?",
	},
	{ text = "Miarka sie przebrala ! Przejmuje hajs i wladze nad Mirkotown! " },
	{ text = "Do budy? Do budy? Wy do budy, i to juz!" },
	{ text = "Narro jestem, chyba widac , nie?!" },
}

local function spawnBandits(npc, player)
	if player:getStorageValue(Storage.TrudnePoczatki.WaskiStages) == 3 then
		player:setStorageValue(Storage.TrudnePoczatki.DostawaDrewna, 5)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Dobra dobra, nie bij juz. Powiedz komisarzowi Rybie ze moze przyjsc po drewno." or "Okay, stop! Tell Commissioner Fisher that he can get this wood back.", npc, player)
	end
	if player:getStorageValue(Storage.TrudnePoczatki.WaskiStages) == 2 then
		player:setStorageValue(Storage.TrudnePoczatki.WaskiStages, 3)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Sadziles ze mafie Narroego tak latwo pokonasz?" or "You thought thats gonna be this easy?!", npc, player)
		Game.createMonster("Hunter", player:getPosition(), true, false)
		Game.createMonster("Hunter", player:getPosition(), true, false)
		Game.createMonster("Hunter", player:getPosition(), true, false)
		Game.createMonster("Assassin", player:getPosition(), true, false)
		Game.createMonster("Assassin", player:getPosition(), true, false)
		Game.createMonster("Bandit", player:getPosition(), true, false)
		Game.createMonster("Bandit", player:getPosition(), true, false)
	end
	if player:getStorageValue(Storage.TrudnePoczatki.WaskiStages) == 1 then
		player:setStorageValue(Storage.TrudnePoczatki.WaskiStages, 2)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Tym razem nie dasz rady." or "Not this time.", npc, player)
		Game.createMonster("Valkyrie", player:getPosition(), true, false)
		Game.createMonster("Valkyrie", player:getPosition(), true, false)
		Game.createMonster("Assassin", player:getPosition(), true, false)
		Game.createMonster("Assassin", player:getPosition(), true, false)
		Game.createMonster("Hunter", player:getPosition(), true, false)
		Game.createMonster("Hunter", player:getPosition(), true, false)
		Game.createMonster("Hunter", player:getPosition(), true, false)
	end
	if player:getStorageValue(Storage.TrudnePoczatki.WaskiStages) < 1 then
		player:setStorageValue(Storage.TrudnePoczatki.WaskiStages, 1)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Zaraz sie przekonamy czy masz racje." or "We'll see who's right!", npc, player)
		Game.createMonster("Bandit", player:getPosition(), true, false)
		Game.createMonster("Bandit", player:getPosition(), true, false)
		Game.createMonster("Bandit", player:getPosition(), true, false)
		Game.createMonster("Bandit", player:getPosition(), true, false)
		Game.createMonster("Bandit", player:getPosition(), true, false)
		Game.createMonster("Valkyrie", player:getPosition(), true, false)
	end
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "no") or MsgContains(message, "nie") then
		if player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna, 4) and npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 then
			if player:getStorageValue(Storage.TrudnePoczatki.WaskiStages) < 3 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "CO NIE JEST DEBESCIAK?!" or "YOU SAID IM NOT BADASS?!", npc, creature)
			end
			spawnBandits(npc, player)
			npcHandler:setTopic(playerId, 0)
		end
	end
	if MsgContains(message, "yes") or MsgContains(message, "tak") then
		if player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna, 4) and npcHandler:getTopic(playerId) == 2 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Dokladnie tak, szybko sie uczysz mlody." or "Thats right.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
		if player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna, 4) and npcHandler:getTopic(playerId) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Bardzo dobre, a jego mafia tez jest debesciak?" or "Thats right! And my mafia is badass too?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	end
	if table.contains({ "drewno", "dostawa", "misja", "mission", "wood" }, message) then
		if player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna) == 4 and npcHandler:getTopic(playerId) == 0 then
			player:getPosition():sendMagicEffect(49)
			doCreatureSay(player:getPosition(), "*Pif paf*", TALKTYPE_ORANGE_1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "On jest debesciak? JA JESTEM DEBESCIAK." or "Huh, hes badass? I AM THE BADASS.", npc, creature)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Powiedz, Narro jest debesciak?" or "Please tell me, Narro is badass?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
		if player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna) == 2 then
			player:setStorageValue(Storage.TrudnePoczatki.DostawaDrewna, 3)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Drewno chcesz? To teraz jest drewno Narroego i jego mafii. Przekaz to komisarzowi Rybie." or "What? Are you looking for the wood? Now thats my wood. You can tell Commissioner Fisher that he'll never get it back.", npc, creature)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "A idz stad!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ruszaj z wiatrem...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
