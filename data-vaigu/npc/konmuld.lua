local internalNpcName = "Konmuld"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 430,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 117,
	lookAddons = 3,
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
		[1] = {
			"WSPANIALA! Stworze sobie z tej duszy swoja wlasna dziewice! ...",
			"Tak jak obiecalem, masz do wyboru w podziece: {maska}, {spodnie}, {armor}. Ktore wybierasz?",
		},
		[2] = {
			"Powiem ci jak zrobimy. Od paru lat zaglebiam sie w tajemna sztuke czarnej magii. Ciagle brakuje mi duszy dziewicy. ...",
			"Nie wiem, jak ja zdobyc, ale {ktos} na pewno bedzie wiedzial. Sproboj sie dowiedziec, i przywlec mi przynajmniej jedna dusze.. Podaruje ci za to jedna z czesci mojego dawnego stroju.",
		},
	},
	["EN"] = {
		[1] = {
			"GREAT! I will create a virgin from that soul just for myself! ...",
			"As promissed. You can choose one of yalahari pieces: {mask}, {legs} or {armor}. What is your choice?",
		},
		[2] = {
			"I'll tell you what we will do. For a few years I have been studying the art of secret black magic. Still the soul of the virgin is missing. ...",
			"I don't know how to get it, but {someone} will know for sure. Try to find out and bring me at least one soul. I'll give you one piece of my old set.",
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
	-- ============= YALAHARI MISSION 2 =================

	if MsgContains(message, "aloha") then
		-- czy ma skonczoną pierwsza misje
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie mam humoru na rozmowe z toba." or "Im not in the mood to talk with you.", npc, creature)
	elseif table.contains({ "maska", "armor", "spodnie", "mask", "armor", "legs" }, message) and npcHandler:getTopic(playerId) == 2 then
		if player:getStorageValue(Storage.Yalahar.WstepDoCzarnejMagii) == 4 then
			if MsgContains(message, "maska") or MsgContains(message, "mask") then
				player:addItem(8864, 1) -- yalahari mask
				player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 5)
				player:setStorageValue(Storage.Finished.YalahariQuest, 1) -- quest done (website)
				player:addOutfit(324, 0)
				player:addOutfit(325, 0)
				player:addOutfitAddon(324, 3)
				player:addOutfitAddon(325, 3)
			elseif MsgContains(message, "armor") then
				player:addItem(8862, 1) -- yalahari armor
				player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 5)
				player:setStorageValue(Storage.Finished.YalahariQuest, 1) -- quest done (website)
				player:addOutfit(324, 0)
				player:addOutfit(325, 0)
				player:addOutfitAddon(324, 3)
				player:addOutfitAddon(325, 3)
			elseif MsgContains(message, "spodnie") or MsgContains(message, "legs") then
				player:addItem(8863, 1) -- yalahari legs
				player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 5)
				player:setStorageValue(Storage.Finished.YalahariQuest, 1) -- quest done (website)
				player:addOutfit(324, 0)
				player:addOutfit(325, 0)
				player:addOutfitAddon(324, 3)
				player:addOutfitAddon(325, 3)
			end
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Oto twoja nagroda!" or "Heres your reward!", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Juz odebrales nagrode!" or "You get your reward already.", npc, creature)
		end
	elseif table.contains({ "mission", "misja", "dusza", "gertruda", "yalahari" }, message) and player:getStorageValue(Storage.PathOfTheUndead.Mission03) ~= 1 then
		if player:getStorageValue(Storage.Yalahar.WstepDoCzarnejMagii) == 3 then
			if player:getLevel() >= 60 then
				npcHandler:say(config[1], npc, creature)
				player:addExperience(350000, true) -- 350k expa
				player:getPosition():sendMagicEffect(CONST_ME_STUN)
				player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 4)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Zglos sie po nagrode po zdobyciu 60 poziomu!" or "Come back when you reach 60 level!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(Storage.Yalahar.WstepDoCzarnejMagii) == 4 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Tak jak obiecalem, masz do wyboru w podziece: {maska}, {spodnie}, {armor}. Ktore wybierasz?" or "As promissed. You can choose one of yalahari pieces: {mask}, {legs} or {armor}. What is your choice?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.Yalahar.WstepDoCzarnejMagii) < 1 and player:getStorageValue(Storage.Yalahar.ZabojczyTrunek) == 3 then
			player:setStorageValue(Storage.Yalahar.WstepDoCzarnejMagii, 1) -- zaczynamy questa
			npcHandler:say(config[2], npc, creature)
		end
	elseif (table.contains({ "wodka", "trunek", "vodka" }, message) and player:getStorageValue(Storage.Yalahar.MiloscAriela) == 9 and player:getItemCount(6106) > 0) and player:getStorageValue(Storage.Yalahar.ZabojczyTrunek) == 2 then
		player:removeItem(6106, 1) -- zabieramy 1 wodke leszke
		player:setStorageValue(Storage.Yalahar.ZabojczyTrunek, 3)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Teraz to mozemy porozmawiac. Co cie tu sprowadza?" or "Now we can talk! Who bring you there?", npc, creature)
	elseif table.contains({ "ktos", "someone" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "W Mirko Town mieszka pewien specjalista od kopania grobow. Moze sprobuj sie od niego dowiedziec." or "In Mirkotown lives one specialist in grave digging. Try to get some information from him.", npc, creature)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ave |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ave Satan!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Ave |PLAYERNAME|.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Ave Satan!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, '...')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
