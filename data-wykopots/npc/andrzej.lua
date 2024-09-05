local internalNpcName = "Andrew"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 97,
	lookBody = 95,
	lookLegs = 58,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "pomoc", "help" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Jesli masz jakies small enchanted sapphire, to moge ci je {rozetrzec} na mial. Nic za to nie oczekuje." or "If you have some small enchanted sapphires, I can turn them ino sapphire {dust} for you.", npc, creature)
	elseif table.contains({ "rozetrzec", "dust" }, message) then
		if player:getItemCount(675) > 0 then
			player:removeItem(675, 1)
			player:addItem(30004, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo." or "Here you are.", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Zebym tylko mial co.." or "Yeah, maybe if you had some.", npc, creature)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|. Pewnie zainteresowales sie tym rozcieraczem? Moge ci {pomoc}, bo sam sobie nie poradzisz.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Do widzenia!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Zegnaj..")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|. You want some {help}, with this machine?')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
