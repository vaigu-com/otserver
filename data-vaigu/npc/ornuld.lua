local internalNpcName = "Ornuld"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 0,
	lookBody = 103,
	lookLegs = 4,
	lookFeet = 94,
	lookAddons = 3,
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
		[1] = "Lekarstwo powiadasz? Ale ono nie jest takie tanie.. W zasadzie mozesz mi pomoc w zamian, co ty na to?",
		[2] = {
			"Kolekcjonuje egzotyczne zwierzeta.. Od jednego handlarza dowiedzialem sie o jaju Wyrmy. ...",
			"Zdobadz prosze dla mnie jedno, podobno mozna znalezc legowiska Wrym gdzies na polnoc stad.",
		},
		[4] = "Wspaniale jajko, troche peklo. Ale wciaz jestem ci niezmiernie wdzieczny, prosze. Oto lekarstwo!",
		[5] = "Standardowo: Papier w miare dobrej jakosci, moze byc spellbook. Do tego inkwell oraz oplata 10000 gp. Czy masz juz wszystkie {skladniki} i payment?",
		[6] = "Masz, oto twoj dokument.",
		[7] = "Wroc ze wszystkimi przedmiotami.",
	},
	["EN"] = {
		[1] = "Medicine you said? It won't be as cheap as you think. Well, you can help me in return, how about that?",
		[2] = {
			"I collect exotic animals. One of traders told me about Wyrm's egg. ...",
			"Get one for me, please. You can find Wyrm's lair on the mountain to the north from here.",
		},
		[4] = "It cracked a bit, but it's still great! I am really grateful to you. Here is the medicine.",
		[5] = "As usual: Fairly good quality paper, may be a spellbook. Additionally an inkwell and a fee of 10,000 gp. Do you already have all {materials} and the payment?",
		[6] = "Here's the document for you.",
		[7] = "Get back when you get all the items.",
	},
}

local czeslawRewards = { CZESLAW_KRANSOLUD_KEY_ITEMS.identityDocument }

local czeslawCosts = { { id = 3059 }, { id = 3509 } }

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	config = GetConfigByPlayer(creature, lang_to_config)

	if table.contains({
		"lekarstwo",
		"receptura",
		"leki",
		"lek",
		"medicine",
		"antidote",
	}, message) and player:getStorageValue(Storage.SciezkaDruida.LekarstwoOdOrnulda) < 1 then
		npcHandler:say(config[1], npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "yes", "tak", "ok", "dobrze", "pewnie" }, message) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say(config[2], npc, creature)
		player:setStorageValue(Storage.SciezkaDruida.LekarstwoOdOrnulda, 1) -- zaczynamy klesta
	elseif table.contains({ "jajko", "jajo", "egg", "wyrm" }, message) and player:getStorageValue(Storage.SciezkaDruida.LekarstwoOdOrnulda) == 2 and player:getItemCount(18996) > 0 then
		npcHandler:say(config[4], npc, creature)
		player:AddCustomItem({ id = 8819, addToStore = true }) 
		player:removeItem(18996, 1)
		player:setStorageValue(Storage.SciezkaDruida.LekarstwoOdOrnulda, 3)
		player:addExperience(150000, true) -- 150k expa
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
	elseif table.contains({
		"tozsamosc",
		"dokument",
		"document",
		"identity",
		"czeslaw",
		"chester",
	}, message) and player:getStorageValue(Storage.CzeslawKrasnolud.Mission02) == 2 then
		npcHandler:say(config[5], npc, creature)
	elseif table.contains({ "yes", "tak", "materials", "skladniki" }, message) and player:getStorageValue(Storage.CzeslawKrasnolud.Mission02) == 2 then
		if player:HasItems(czeslawCosts) and player:getMoney() > 10000 then
			if player:TryAddItems(czeslawRewards) then
				player:removeMoney(10000)
				npcHandler:say(config[6], npc, creature)
				player:setStorageValue(Storage.CzeslawKrasnolud.Questline, 4)
				player:setStorageValue(Storage.CzeslawKrasnolud.Mission02, 3)
			end
		else
			npcHandler:say(config[7], npc, creature)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Czego tutaj szukasz |PLAYERNAME|?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Zegnaj przybyszu!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Nie daj sie zjesc w dzungli.")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'What are you looking for, |PLAYERNAME|?')
-- npcHandler:setMessage(MESSAGE_FAREWELL_ENG, 'Good bye!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY_ENG, 'Be aware of the Jungle.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
