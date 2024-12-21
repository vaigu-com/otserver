--39f
local internalNpcName = "Test Npc"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2500
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 154,
	lookHead = 120,
	lookBody = 5,
	lookLegs = 5,
	lookFeet = 114,
	lookAddons = 0,
}

npcConfig.flags = { floorchange = 0 }

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

local spawnLock = SpawnLocks.Steppes.TestNpc
local roomCorner1, roomCorner2 = Position(6235, 1026, 5), Position(6238, 1029, 5)

npcType.onThink = function(npc, interval)
	local players = CreatureList():Area(roomCorner1, roomCorner2):FilterByPlayer():Get()
	if TableSize(players) > 0 then
		spawnLock:Refresh()
	end

	if spawnLock:SecondsSinceRefresh() > 5 then
		spawnLock:Reset()
		npc:remove()
	end

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
	{ text = "Wejdz na arene i walcz ! Wroc z tarcza lub na tarczy !" },
	{ text = "Jesli nie brak Ci odwagi, sprawdz sie w obliczu ciezkiej walki!" },
	{ text = "My smiertelnicy jestesmy jedynie cieniami i pylem." },
	{ text = "To, co czynimy za zycia, odbija sie echem w wiecznosci." },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj dzielny wojowniku. Chcesz wejsc na {arene}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Uwazaj na siebie!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Powodzenia!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello competitor! Do you want to fight in the {arena}?')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Take care of yourself!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'Good luck!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
