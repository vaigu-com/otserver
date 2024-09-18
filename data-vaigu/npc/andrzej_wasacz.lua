local internalNpcName = "Andrew The Moustachizzle"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 268,
	lookHead = 97,
	lookBody = 38,
	lookLegs = 95,
	lookFeet = 114,
	lookAddons = 0,
}

npcConfig.flags = { floorchange = false }

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

local function spawnBandits(player)
	Game.createMonster("bandit", Position(6051, 1638, 4), true, false)
	Game.createMonster("bandit", Position(6055, 1637, 4), true, false)
	Game.createMonster("bandit", Position(6056, 1640, 4), true, false)
	Game.createMonster("bandit", Position(6055, 1642, 4), true, false)
	Game.createMonster("smuggler", Position(6052, 1642, 4), true, false)
end

local config = nil
local lang_to_config = {
	["PL"] = {
		[1] = "Blagam, nie myslisz chyba ze od tak wydaje jakiekolwiek {informacje} o moich - ekhem - kontrahentach.",
		[2] = "Straze! Ten pan chyba juz musi isc, pokazcie mu gdzie wyrzucamy truchla.",
		[3] = "Dobra! - juz spokojnie, jakos sie dogadamy. Co ci skradziono?",
		[4] = {
			"Aha, ten typek... niedawno odplynal stad lodka. Pytal mnie, gdzie znajdzie dobre miejsce do ukrycia. ...",
			"Doradzalem mu, zeby poszukal na poludniu stepow. To wszystko co wiem.",
		},
		[5] = {
			"A wiec chcesz wiedziec jak zdobyc nowa tozsamosc? Aha, pytasz dla przyjaciela? Pogadaj z Ornuldem w dzungli, on zajmuje sie takimi interesami. ...",
			"Mozliwe, ze bedziesz potrzebowac czegos do pisania i papieru, najlepiej z bardzo pospolitej ksiegi, oraz oczywiscie slona zaplata. ...",
			"Jezeli milczenie jest zlotem, to wyrabianie dokumentow jest krysztalem. Co ja pierdole - od wody mieszaja mi sie zmysly. Tak czy siak miej ze soba crystal coina.",
		},
		[6] = "Jak nie masz nic madrego do powiedzenia to stad spieprzaj.",
	},
	["EN"] = {
		[1] = "Please, you don't think that I am giving any {information} about my - ekhem - contractors just like that.",
		[2] = "Guards! This man got to go, show him where we throw out carcass.",
		[3] = "Fine! - calm down, we will get along somehow. What has been stolen from you?",
		[4] = {
			"Ohh, that dude ... he left on a boat recently. He was asking me for some good place to hide. ...",
			"I told him to look around at the south of the steppes. That's all I know.",
		},
		[5] = {
			"So, you want to know how to obtain a new identity? Oh, you're asking for a friend? Have a chat with Ornuld in the jungle, he specializes in such matters...",
			"You might need something to write with and paper, preferably from a very common book, and, of course, the payment...",
			"If silence is gold, then forging documents is crystal. What the hell am I saying... Anyway, have a crystal coin with you.",
		},
		[6] = "Better go away.",
	},
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	config = GetConfigByPlayer(creature, lang_to_config)

	if table.contains({ "zlodziej", "thief" }, message) and player:getStorageValue(Storage.IKEAdlazuchwalych.Questline) == 9 then
		npcHandler:say(config[1], npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({ "informacje", "info", "information", "informations" }, message) and player:getStorageValue(Storage.IKEAdlazuchwalych.Questline) == 9 and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say(config[2], npc, creature)
		spawnBandits(player)
		player:setStorageValue(Storage.IKEAdlazuchwalych.Questline, 10)
	elseif table.contains({ "informacje", "informations", "zlodziej", "thief" }, message) and player:getStorageValue(Storage.IKEAdlazuchwalych.Questline) == 10 then
		npcHandler:say(config[3], npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "meble", "drewno", "furniture", "wood" }, message) and player:getStorageValue(Storage.IKEAdlazuchwalych.Questline) == 10 and npcHandler:getTopic(playerId) == 1 then
		player:setStorageValue(Storage.IKEAdlazuchwalych.Questline, 11)
		npcHandler:say(config[4], npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({
		"tozsamosc",
		"dokument",
		"document",
		"identity",
		"czeslaw",
		"chester",
	}, message) and player:getStorageValue(Storage.ChesterTheDwarf.Mission02) == 2 then
		npcHandler:say(config[5], npc, creature)
	else
		npcHandler:say(config[6], npc, creature)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Czego ty chcesz?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Spadaj stad!")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'What do you want?!')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Go away!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
