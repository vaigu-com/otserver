local internalNpcName = "Santa Claus"
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
	lookHead = 0,
	lookBody = 112,
	lookLegs = 93,
	lookFeet = 95,
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

local normalItems = {
	{ 7439, 7440, 7443 }, -- mastermindy
	{ 2688, 6508 }, -- bundle
	{ 2688, 6506 }, -- bundle
	{ 2688, 6507 }, -- bundle
	{ 2688, 2114 }, -- swinka
	{ 2688, 2111 }, -- sniezka
	{ 2167, 2213, 2214 }, -- ringi
	{ 11227 }, -- shiny stone 500gp
	{ 2156 }, -- red gem 1k
}

local semiRareItems = {
	{ 2173 }, -- aol
	{ 9954 }, -- dracole
	{ 9971 }, -- gold ingot
	{ 5080 }, -- panda
	{ 2153 }, -- violet gem 10k
}

local rareItems = { { 2110 }, { 5919 }, { 6567 }, { 11255 }, { 11256 }, { 6566 }, { 2112 } }

local veryRareItems = { { 2659 }, { 3954 }, { 2644 }, { 10521 } }

local function getReward()
	local rewardTable = {}
	local random = math.random(100)
	if random <= 100 then
		rewardTable = normalItems
	elseif random <= 20 then
		rewardTable = semiRareItems
	elseif random <= 5 then
		rewardTable = rareItems
	elseif random <= 1 then
		rewardTable = veryRareItems
	end

	local rewardItem = rewardTable[math.random(#rewardTable)]
	return rewardItem
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "present") or MsgContains(message, "prezent") then
		if player:getStorageValue(Storage.santaPresent) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Otrzymales juz prezent." or "You got your present already.", npc, creature)
			return false
		end
		if player:getLevel() < 20 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz 20 poziom, aby otrzymac prezent." or "You need at least 20 lvl to get a present.", npc, creature)
			return false
		end

		local reward = getReward()
		local cont = Container(player:addItem(6510):getUniqueId())
		local count = 1

		for i = 1, #reward do
			if reward[i] == 2111 or reward[i] == 2688 then
				count = 10
			end
			cont:addItem(reward[i], count)
		end

		player:setStorageValue(Storage.santaPresent, 1)
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Wesolych swiat!" or "Merry Christmas!", npc, creature)
		-- npcHandler:say("Kto to widzial, zeby o prezent prosic w takim terminie... No ale masz, z dobrego serca.", npc, creature)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Wesolych swiat, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Zegnaj, |PLAYERNAME|!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Merry Christmas, |PLAYERNAME|.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye, |PLAYERNAME|!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
