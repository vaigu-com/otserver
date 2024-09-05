local internalNpcName = "Myzzi"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 982,
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

local config = nil
local lang_to_config = {
	["PL"] = {
		[1] = "Jestem tylko poslancem bedacym tutaj, aby znalezc odwaznych poszukiwaczy przygod, ktorzy moga {pomoc} moim przyjaciolom w potrzebie.",
		[2] = "Poszukiwani sa bohaterzy, aby zapobiec wielkiemu {zagrozeniu} dla calego swiata.",
		[3] = "Mam nadzieje, ze nam pomozesz.",
		[4] = "Nie jestes wystarczajaco doswiadczony. Wroc co najmniej z 60 poziomem.",
		[5] = {
			"Wiem niewiele i zapominam tak duzo.. Tak wiele rzeczy klebi mi sie w glowie! ...",
			"Moge zapewnic ci dostep do {Letniego Dworu}, jesli obiecasz pomoc! Tam spotkasz sie Vanysem. On powie ci wiecej o problemie.",
		},
		[6] = {
			"W ogromnym lesie daleko na poludnie od Miasta Mirko znajduje sie {wejscie} do Letniego Dworu. ...",
			"Dzieki mojej magii bedziesz mogl wejsc na Dziedziniec. Znajdz Vanysa i porozmawiaj z nim.",
		},
		[7] = "Wiec jestes gotow pomoc w tych trudnych czasach?",
		[8] = "Prawdziwy bohater! Teraz zdolasz przejsc przez drzwi broniace dostepu do Dworu. Moi przyjaciele czekaja.",
	},
	["EN"] = {
		[1] = "I'm just a mere messenger and I'm here to find brave adventurers that might {help} my friends in this time of need.",
		[2] = "Lady Alivar of the Summer Court and Lord Cadion of the Winter Court are in need of brave adventurers to avert a great {threat} for the whole world.",
		[3] = "I hope you will help us. Good luck.",
		[4] = "Im pretty sure you are not experienced enough. Come back with at least 60 lvl.",
		[5] = {
			"I know only little and I forget so much. So many things going around my mind! ...",
			"However, I can grant you access to the {Court} of Summer and Winter if you promise to help! There you can meet with Undal or Vanys, the servants of Lord Cadion and Lady Alivar. They will be able to tell you more about the issue.",
		},
		[6] = {
			"There is {entrance} to Summer Court in the huge forest far south from Mirko Town. ...",
			"With my magic you will be able to enter the Court. Find Vanys and talk to him.",
		},
		[7] = "So, are you willing to help in this time of need?",
		[8] = "You are a true hero! Here, take my enchantment and you will be able to pass the doors. Now hurry, my friends are waiting.",
	},
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	config = GetConfigByPlayer(creature, lang_to_config)

	if MsgContains(message, "good") or MsgContains(message, "dobrze") then
		npcHandler:say(config[1], npc, creature)
	elseif MsgContains(message, "help") or MsgContains(message, "pomoc") then
		if player:getLevel() >= 60 then
			if player:getStorageValue(Storage.TheDreamCourts.QuestLine) < 1 then
				npcHandler:say(config[2], npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say(config[3], npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		else
			npcHandler:say(config[4], npc, creature)
		end
	elseif (MsgContains(message, "threat") or MsgContains(message, "zagrozeniu")) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say(config[5], npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif (MsgContains(message, "court") or MsgContains(message, "letniego dworu")) and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say(config[6], npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif (MsgContains(message, "entrance") or MsgContains(message, "wejscie")) and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say(config[7], npc, creature)
		npcHandler:setTopic(playerId, 4)
	elseif (MsgContains(message, "yes") or MsgContains(message, "tak")) and npcHandler:getTopic(playerId) == 4 then
		npcHandler:say(config[8], npc, creature)
		if player:getStorageValue(Storage.TheDreamCourts.QuestLine) < 1 then
			player:setStorageValue(Storage.TheDreamCourts.QuestLine, 1)
		end
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj przybyszu. Jak {dobrze} cie widziec.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Narka.")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello adventurer. It is {good} to see you.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Bye.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
