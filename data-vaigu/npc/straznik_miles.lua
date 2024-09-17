local internalNpcName = "Miles, The Guard"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 131,
	lookHead = 0,
	lookBody = 19,
	lookLegs = 19,
	lookFeet = 19,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if (MsgContains(message, "trouble") or MsgContains(message, "problemy")) and player:getStorageValue(Storage.TheInquisition.MilesGuard) < 1 and player:getStorageValue(Storage.TheInquisition.Mission01) ~= -1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Jest w porzadku, nic mi nie wadzi." or "I'm fine. There's no trouble at all.", npc, creature)
		if player:getStorageValue(Storage.TheInquisition.MilesGuard) < 1 then
			player:setStorageValue(Storage.TheInquisition.MilesGuard, 1)
			player:setStorageValue(Storage.TheInquisition.Mission01, player:getStorageValue(Storage.TheInquisition.Mission01) + 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
			player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		end
	elseif table.contains({ "zlodziej", "thief" }, message) then
		if player:getStorageValue(Storage.IKEAdlazuchwalych.Questline) == 8 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Widzialem jak ktos pobiegl za brame miasta, a nastepnie na wschod. Moze udal sie w kierunku {obozu} bandytow?" or "I saw someone run past the city gate and then to the east. Maybe he went to the bandit's {camp}?", npc, creature)
			if player:getStorageValue(Storage.IKEAdlazuchwalych.MilesAsked) <= 0 then
				player:setStorageValue(Storage.IKEAdlazuchwalych.ZlodziejAsked, player:getStorageValue(Storage.IKEAdlazuchwalych.ZlodziejAsked) + 1)
				player:setStorageValue(Storage.IKEAdlazuchwalych.MilesAsked, 1)
			end
			if player:getStorageValue(Storage.IKEAdlazuchwalych.ZlodziejAsked) >= 2 then
				player:setStorageValue(Storage.IKEAdlazuchwalych.Questline, 9)
			end
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.IKEAdlazuchwalych.Questline) >= 9 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Mam nadzieje ze go zlapiesz." or "I hope that youll catch him.", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie widzialem zadnego zlodzieja." or "I dint see anything suspicious.", npc, creature)
		end
	elseif table.contains({ "obozu", "camp" }, message) and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie wiesz gdzie jest ich oboz? To w okolicy wschodniego wybrzeza, kierujac sie z poludniowej bramy." or "You don't know where their camp is? Its around eastern coast, going from south gate.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

keywordHandler:addKeyword({ "job" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Moim zajeciem jest obrona miasta.",
})

npcHandler:setMessage(MESSAGE_GREET, "NIECH ZYJE KROL!")
npcHandler:setMessage(MESSAGE_FAREWELL, "NIECH ZYJE KROL!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "NIECH ZYJE KROL!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
