local internalNpcName = "Xelvar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 70,
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

	if MsgContains(message, "adventures") or MsgContains(message, "przygoda") then
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Rasa gnomow potrzebuje wszelkiej pomocy. Jestem tutaj aby poszukiwac i rektutowac smialkow. Mysle ze sie nadasz. Jestes zainteresowany dolaczeniem?",
			} or {
				"The gnomes are locked in a war with an enemy that thins out their resources but foremost their manpower. We have suggested that people like you could be just the specialists they are looking for. ...",
				"If you are interested to {join} the gnomish cause I can arrange a meeting with their recruiter.",
			}, npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif table.contains({ "join", "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Bardzo mnie to cieszy. Gnomowie sa nekani przez dziwne kreatury panoszace sie po ich kopalniach, oraz wykradajace surowce. ...",
			"Zyskujesz pozwolenie do uzywania ich systemu teleportacyjnego. Musisz posiadac przy sobie co najmniej jeden krysztal, aby uzyc teleportu. ...",
			"Dam ci ich kilka na poczatek, jednak jesli bedziesz potrzebowal wiecej, to ci je sprzedam. ...",
			"Teleport przeniesie cie do jednej z wiekszych osad gnomow. ...",
			"Jesli zdobedziesz ich zaufanie, to pozwola ci wykonywac dosc wymagajace zadania, oczywiscie z pewnymi korzysciami dla ciebie. Powodzenia!",
		} or {
			"I am glad to hear that. In the spirit of our own foreign legion we suggested the gnomes might hire heroes like you to build some kind of troop. They gave me that strange crystal to allow people passage to their realm. ...",
			"I hereby grant you permission to use the basic gnomish teleporters. I also give you four gnomish teleport crystals. One will be used up each time you use the teleporter. ...",
			"You can stock up your supply by buying more from me. Just ask me for a {trade}. Gnomette in the teleport chamber of the gnome outpost will sell them too. ...",
			"The teleporter here will transport you to one of the bigger gnomish outposts. ...",
			"There you will meet Gnomerik, the recruitment officer of the Gnomes. If you are lost, Gnomette in the teleport chamber might be able to help you with directions. ...",
			"Good luck to you and don't embarrass your race down there! Keep in mind that you are a representative of the big people.",
		}, npc, creature)
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 1)
		player:addItem(16167, 4)
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj, jestes zainteresowany {przygoda}?")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello, are you interested in {adventures}?')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.shop = { { itemName = "teleport crystal", clientId = 16167, buy = 150 } }

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
