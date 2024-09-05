local internalNpcName = "Richard Petrol"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 1500
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 472,
	lookHead = 0,
	lookBody = 29,
	lookLegs = 95,
	lookFeet = 79,
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
	{ text = "U mnie twoje pieniadze sa bezpieczne." },
	{
		text = "Darmowe wplaty i wyplaty, a za prowadzenie konta nic nie pobieramy.",
	},
	{
		text = "Bo na swiecie jest o ile nie pamietam 130 pare krajow... a do kazdego przelewy za darmo !",
	},
	{ text = "Przypominam ze po swietach jest szesciu kroli... Tak? " },
	{
		text = "Sa takie momenty kiedy imperia padaja. Imperia  padaja zwykle w szczycie swojej chwaly, na przyklad Reborn. ",
	},
	{ text = "Balans Twojego konta? Mam to w komorce..." },
	{ text = "Darmowe przelewy blyskawiczne." },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	-- Parse bank
	npc:parseBank(message, npc, creature, npcHandler)
	-- Parse guild bank
	npc:parseGuildBank(message, npc, creature, playerId, npcHandler)
	-- Normal messages
	npc:parseBankMessages(message, npc, creature, npcHandler)
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "No witam cie |PLAYERNAME|, co potrzebujesz? Przelewu? Wyplaty? Wplaty? Decyduj sie, bo czas to pieniadz.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Milego dnia.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Milego dnia.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
