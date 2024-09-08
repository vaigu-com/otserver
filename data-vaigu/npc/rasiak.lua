local internalNpcName = "Woody"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 102,
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Chlop jak domb ze mnie, nie ma co" },
	{ text = "Kazda ksiazke czytam z zaciekawieniem od deski do deski" },
	{ text = "Ehh te korniki ciagle mnie gryza i nie daja mi spokoju" },
	{
		text = "Podobno kiedys bylem malym chlopcem ale potem zamienilem sie w drewno",
	},
	{ text = "Pinokio moj syjamski blizniaku, tesknie za Toba..." },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	-- ============= MISJA 1 DRUID ADDON QUEST =================
	if table.contains({ "drewno", "dostawa", "wood", "delivery" }, message) then
		if player:getStorageValue(Storage.TrudnePoczatki.DostawaDrewna) == 1 then
			player:setStorageValue(Storage.TrudnePoczatki.DostawaDrewna, 2)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Jak to drewno nie dotarlo? 3 dni temu wyslalem karawane. Musialo sie cos stac po drodze, zbadaj to jesli mozesz." or "", npc, creature)
		end
	end
	return true
end

local dialogues = {
	[Storage.TrudnePoczatki.DostawaDrewna] = {
		[1] = {
			[{ "drewno", "dostawa", "wood", "delivery" }] = {
				text = "What?! What do you mean the wood is missing? Three days ago I sent a caravan by myself... Something must have happened on its way, could you investigate that?",
			},
		},
	},
	[Storage.TragedyaWCzterechAktach.Questline] = {
		[{ min = 4, max = 7 }] = { [{ "portal", "teleport", "retro" }] = { text = "" } },
	},
}

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Niech natura bedzie z toba!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ruszaj z wiatrem...")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello |PLAYERNAME|.')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye.')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'See you..')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
