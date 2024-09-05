local internalNpcName = "Gnomespector"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 493,
	lookHead = 59,
	lookBody = 59,
	lookLegs = 59,
	lookFeet = 58,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "recruit") then
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) == 3 then
			npcHandler:say({
				"Your examination is quite easy. Just step through the green crystal {apparatus} in the south! We will examine you with what we call g-rays. Where g stands for gnome of course ...",
				"Afterwards walk up to Gnomedix for your ear examination.",
			}, npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "apparatus") and npcHandler:getTopic(playerId) == 1 then
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) == 3 then
			npcHandler:say("Don't be afraid. It won't hurt! Just step in!", npc, creature)
			player:setStorageValue(Storage.BigfootBurden.QuestLine, 4)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hello fearless {recruit}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye.")
--npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello fearless {recruit}.')
--npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
