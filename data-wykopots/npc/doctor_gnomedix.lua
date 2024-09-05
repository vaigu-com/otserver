local internalNpcName = "Doctor Gnomedix"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 493,
	lookHead = 85,
	lookBody = 85,
	lookLegs = 85,
	lookFeet = 85,
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

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if player:getStorageValue(Storage.BigfootBurden.QuestLine) == 5 then
		if getPlayerLanguage(player) == "PL" then
			npcHandler:setMessage(MESSAGE_GREET, "Wejdz prosze na platforme egzaminacyjna, |PLAYERNAME|.")
		else
			npcHandler:setMessage(MESSAGE_GREET, "Stand still on the examination platform |PLAYERNAME|.")
		end
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 6)
	end
	npcHandler:onSay(npc, creature, type, message)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
