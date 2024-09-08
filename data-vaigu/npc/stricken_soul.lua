local internalNpcName = "Stricken Soul"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 48,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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

	if MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 0 then
		if player:getStorageValue(Storage.TheDreamCourts.QuestLine) == 2 then
			if player:getStorageValue(Storage.TheDreamCourts.StrickenMission) < 1 then
				npcHandler:say("Yeeeees... you need to help meeeeeee. I want those ghosts gone... this is my home and I need it to teach my students. Will you take care of the... ghosts?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("Good luck...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		else
			npcHandler:say("Go away, please...", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("Excellent... I hope they will haaaaaaunt my house no longer. What was your... naaaaaame again, tell me?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif MsgContains(message, player:getName()) and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say({
			"Ah yeeeeees.. I will remember you. Now, lessons are every day in the morning and once a week in the evening... ...",
			"Oh, you're not here for this, are you? So about the ghoooosts, yes. You seeeee, there is secret passages here. ...",
			"Thiiiiis is a nexus... A gateway to a once hidden cathedral. Sheltering a small and peaceful society of scholars and monks. Secluded from every distraction. ...",
			"I was one of them and ordered to hold contact to the outside woooorld. But then, something... happened. ...",
			"Outsiders managed to sneak in, infiltrate and influence the society... for the worse. Who knows for what ends. They chaaaaanged... ...",
			"Shortly after, contact was lost... the nexus broken and sealed, ghosts appeared... eeeeeeeverywhere. ...",
			"Find the passage... one is right here in the cellars. ...",
			"Restore their connection and open this nexus to access the buried cathedral and find the cause to this... eliminate all remainders there if you must.",
		}, npc, creature)
		player:setStorageValue(Storage.TheDreamCourts.StrickenMission, 1)
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "This place is... haunted... heed my warning... there are... ghooooooosts here...! Why are you giving me that... look? I am certain, there aaaaaaare ghosts here - I've seen them! Do you believe me?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye...")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Bye...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'This place is... haunted... heed my warning... there are... ghooooooosts here...! Why are you giving me that... look? I am certain, there aaaaaaare ghosts here - I've seen them! Do you believe me?')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Bye...')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'Bye...')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
