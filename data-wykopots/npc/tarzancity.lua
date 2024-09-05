local internalNpcName = "Tarzan"
local npcType = Game.createNpcType("TarzanCity")
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
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

	if player:isPzLocked() then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Wygladasz jakbys sie przed chwila z kims bil... Lepiej odejdz." or "Looks like you have fought someone.. Better step away, I can't trust you.", npc, creature)
		return false
	elseif table.contains({
		"sail",
		"plyn",
		"podroz",
		"transport",
		"plynac",
		"plyn",
		"oboz",
		"obozowiska",
		"malpy",
	}, message) then
		if player:removeMoney(200) then
			local position = Position(6564, 701, 7)
			player:teleportTo(position)
			position:sendMagicEffect(CONST_ME_TELEPORT)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Musisz miec 200 zlota, zeby tam plynac." or "You need to pay 200 gold to sail there.", npc, creature)
		end
		return true
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Elo, niestety trudne czasy zmusily mnie aby dorabiac plywajac lodka. Moge zabrac cie w poblize miejsca gdzie sie wychowalem- {obozowiska} malp.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Milego dnia!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Zegnaj.")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello, its pretty rough out there nowadays.. I can {sail} you close to place where I spent my childhood - ape city.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Have a nice day!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'Bye..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
