local internalNpcName = "Yana"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 471,
	lookHead = 0,
	lookBody = 57,
	lookLegs = 0,
	lookFeet = 68,
	lookAddons = 2,
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

npcConfig.currency = 22721

npcConfig.shop = {
	{ name = "axe of desctruction", clientId = 27451, buy = 50 },
	{ name = "blade of desctruction", clientId = 27449, buy = 50 },
	{ name = "bow of desctruction", clientId = 27455, buy = 50 },
	{ name = "chopper of desctruction", clientId = 27452, buy = 50 },
	{ name = "crossbow of desctruction", clientId = 27456, buy = 50 },
	{ name = "hammer of desctruction", clientId = 27454, buy = 50 },
	{ name = "mace of desctruction", clientId = 27453, buy = 50 },
	{ name = "rod of desctruction", clientId = 27458, buy = 50 },
	{ name = "slayer of desctruction", clientId = 27450, buy = 50 },
	{ name = "wand of desctruction", clientId = 27457, buy = 50 },
}

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

local products = {
	["strike"] = {
		["basic"] = {
			engtext = "The basic bundle for the strike imbuement consists of 20 protective charms. Would you like to buy it for 2 gold tokens?",
			text = "Paczka ta zawiera 20 protective charms. Chcesz ja zakupic za 2 gold token?",
			items = { [1] = { id = 11444, amount = 20 } },
			value = 2,
		},
		["intricate"] = {
			engtext = "The intricate bundle for the strike imbuement consists of 20 protective charms and 25 sabreteeth. Would you like to buy it for 4 gold tokens?",
			text = "Paczka ta zawiera 20 protective charms i 25 sabreteeth. Chcesz ja zakupic za 4 gold token?",
			items = {
				[1] = { id = 11444, amount = 20 },
				[2] = { id = 10311, amount = 25 },
			},
			value = 4,
		},
		["powerful"] = {
			engtext = "The powerful bundle for the strike imbuement consists of 20 protective charms, 25 sabreteeth and 5 vexclaw talons. Would you like to buy it for 6 gold tokens?",
			text = "Paczka ta zawiera 20 protective charms, 25 sabreteeth i 5 vexclaw talons. Chcesz ja zakupic za 6 gold token?",
			items = {
				[1] = { id = 11444, amount = 20 },
				[2] = { id = 10311, amount = 25 },
				[3] = { id = 22728, amount = 5 },
			},
			value = 6,
		},
	},
	["vampirism"] = {
		["basic"] = {
			engtext = "The basic bundle for the vampirism imbuement consists of 25 vampire teeth. Would you like to buy it for 2 gold tokens?",
			text = "Paczka ta zawiera 25 vampire teeth. Chcesz ja zakupic za 2 gold token?",
			items = { [1] = { id = 9685, amount = 25 } },
			value = 2,
		},
		["intricate"] = {
			engtext = "The intricate bundle for the strike imbuement consists of 20 protective charms and 25 sabreteeth. Would you like to buy it for 4 gold tokens?",
			text = "Paczka ta zawiera 25 vampire teeth i 15 bloody pincers. Chcesz ja zakupic za 4 gold token?",
			items = {
				[1] = { id = 9685, amount = 25 },
				[2] = { id = 9633, amount = 15 },
			},
			value = 4,
		},
		["powerful"] = {
			engtext = "The powerful bundle for the vampirism imbuement consists of 25 vampire teeth, 15 bloody pincers and 5 pieces of dead brain. Would you like to it for 6 gold tokens?",
			text = "Paczka ta zawiera 25 vampire teeth, 15 bloody pincers i 5 pieces of dead brain. Chcesz ja zakupic za 6 gold token?",
			items = {
				[1] = { id = 9685, amount = 25 },
				[2] = { id = 9633, amount = 15 },
				[3] = { id = 9663, amount = 5 },
			},
			value = 6,
		},
	},
	["void"] = {
		["basic"] = {
			engtext = "The basic bundle for the void imbuement consists of 25 rope belts. Would you like to buy it for 2 gold tokens?",
			text = "Paczka ta zawiera 25 rope belts. Chcesz ja zakupic za 2 gold token?",
			items = { [1] = { id = 11492, amount = 25 } },
			value = 2,
		},
		["intricate"] = {
			engtext = "The intricate bundle for the void imbuement consists of 25 rope belts and 25 silencer claws. Would you like to buy it for 4 gold tokens?.",
			text = "Paczka ta zawiera 25 rope belts i 25 silencer claws. Chcesz ja zakupic za 4 gold token?.",
			items = {
				[1] = { id = 11492, amount = 25 },
				[2] = { id = 20200, amount = 25 },
			},
			value = 4,
		},
		["powerful"] = {
			engtext = "The powerful bundle for the void imbuement consists of 25 rope belts, 25 silencer claws and 5 grimeleech wings. Would you like to buy it for 6 gold tokens?",
			text = "Paczka ta zawiera 25 rope belts, 25 silencer claws i 5 grimeleech wings. Chcesz ja zakupic za 6 gold token?",
			items = {
				[1] = { id = 11492, amount = 25 },
				[2] = { id = 20200, amount = 25 },
				[3] = { id = 22730, amount = 5 },
			},
			value = 6,
		},
	},
}

local answerType = {}
local answerLevel = {}

local function greetCallback(npc, creature)
	local playerId = creature:getId()
	npcHandler:setTopic(playerId, 0)
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if message then
		message = message:lower()
	end

	if MsgContains(message, "information") or MsgContains(message, "informacji") then
		npcHandler:say(
			getPlayerLanguage(player) == "PL" and "{Token}'y to male przedmioty wykonane z metalu. Mozesz dzieki nim kupic ekwipunek od handlarzy takich jak ja. Zdobedziesz je pokonujac rozmaite bosy."
				or "{Tokens} are small objects made of metal or other materials. You can use them to buy superior equipment from token traders like me. There are several ways to obtain the tokens I'm interested in - killing certain bosses, for example. In exchange for a certain amount of tokens, I can offer you some first-class items.",
			npc,
			creature
		)
	elseif MsgContains(message, "tokens") or MsgContains(message, "token") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Jesli masz jakies {gold} tokeny ze soba, postaram ci sie zaoferowac cos wzamian." or "If you have any {gold} tokens with you, let's have a look! Maybe I can offer you something in exchange.", npc, creature)
	elseif MsgContains(message, "gold") then
		npc:openShopWindow(creature)
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Oto moja oferta. Sprzedaje takze kilka paczek zawierajacych {creature products}. ...",
		} or {
			"If you have any gold tokens with you, let's have a look! These are my offers. I'm also selling {creature products) bundles.",
		}, npc, creature)
	elseif MsgContains(message, "creature products") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Posiadam creature produkty na kilka z imbuingow: {strike}, {vampirism} i {void}." or "I have creature products for the imbuements {strike}, {vampirism} and {void}. Make your choice, please!.", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif npcHandler:getTopic(playerId) == 3 then
		local imbueType = products[message]
		if imbueType then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Zdecydowales sie na " .. message .. ". {Basic}, {intricate} czy {powerful}?",
			} or {
				"You have chosen " .. message .. ". {Basic}, {intricate} or {powerful}?",
			}, npc, creature)
			answerType[playerId] = message
			npcHandler:setTopic(playerId, 4)
		end
	elseif npcHandler:getTopic(playerId) == 4 then
		local imbueLevel = products[answerType[playerId]][message]
		if imbueLevel then
			if getPlayerLanguage(player) == "PL" then
				npcHandler:say({ imbueLevel.text }, npc, creature)
			else
				npcHandler:say({ imbueLevel.engtext }, npc, creature)
			end
			answerLevel[playerId] = message
			npcHandler:setTopic(playerId, 5)
		end
	elseif npcHandler:getTopic(playerId) == 5 then
		if MsgContains(message, "yes") or MsgContains(message, "tak") then
			local neededCap = 0
			for i = 1, #products[answerType[playerId]][answerLevel[playerId]].items do
				neededCap = neededCap + ItemType(products[answerType[playerId]][answerLevel[playerId]].items[i].id):getWeight() * products[answerType[playerId]][answerLevel[playerId]].items[i].amount
			end
			if player:getFreeCapacity() > neededCap then
				if player:getItemCount(npcConfig.currency) >= products[answerType[playerId]][answerLevel[playerId]].value then
					for i = 1, #products[answerType[playerId]][answerLevel[playerId]].items do
						player:addItem(products[answerType[playerId]][answerLevel[playerId]].items[i].id, products[answerType[playerId]][answerLevel[playerId]].items[i].amount)
					end
					player:removeItem(npcConfig.currency, products[answerType[playerId]][answerLevel[playerId]].value)
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze." or "There it is.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie masz wystarczajacej ilosci tokenow. Przynies " .. products[answerType[playerId]][answerLevel[playerId]].value .. " to pogadamy." or "I'm sorry but it seems you don't have enough tokens yet. Bring me " .. products[answerType[playerId]][answerLevel[playerId]].value .. " of them and we'll make a trade.", npc, creature)
				end
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Nie zdolasz tego uniesc. Potrzebujesz " .. neededCap .. " oz udzwigu." or "You don't have enough capacity. You must have " .. neededCap .. " oz.", npc, creature)
			end
		end
	end
	return true
end

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Wymieniam tokeny! Dostepny ekwipunek najwyzszej klasy!" },
}

npcHandler:setCallback(CALLBACK_SET_INTERACTION, onAddFocus)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Witaj, |PLAYERNAME|! W czym moge pomoc? Chcesz wymienic {token}'y, lub potrzebujesz jakichs {informacji}?")
-- npcHandler:setMessage(MESSAGE_GREET_ENG, 'Blessings, |PLAYERNAME|! How may I help you? Do you wish to trade some {tokens}, or do you need some {information}?')

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
