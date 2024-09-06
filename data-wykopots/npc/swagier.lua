local internalNpcName = "Swagger"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1618,
	lookHead = 0,
	lookBody = 77,
	lookLegs = 82,
	lookFeet = 86,
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

local config = {
	[Storage.PerIustitiaAdAstra.Questline] = {
		[7] = {
			[{ "fuel", "paliwo", "mission" }] = {
				text = "Do you need fuel? Of course - I sell ready-to-use rocket fuel. The current {exchange rate} is 50,000 crystal coins for 100 liters.",
			},
			[{ "rates", "przelicznik", "exchange rate" }] = {
				text = "If my fuel prices don't suit you, I can sell you a {raw} fuel rod instead.",
			},
			[{ "raw", "surowy" }] = {
				text = "Wait a moment, these rods were stolen from me recently by some clever thieves. I think they were flying towards Ganymede moon. That place is known for its numerous mountain peaks. Most of the mountains and rocks are too dangerous and steep to hide in. The bandits hide in the valleys of the Vaux Maich mountains. I've sent the moon's location to your ship.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 8,
					[Storage.PerIustitiaAdAstra.Mission03] = 3,
					[Storage.PerIustitiaAdAstra.ShipDestinations.Ganymede] = 1,
				},
			},
		},
		[8] = {
			[{ ANY_MESSAGE }] = {
				text = "I don't know what kind of gigachads those thieves must have been to move a crate of that weight.",
			},
		},
		[9] = {
			[{ "mission" }] = {
				text = "Thanks for your help. In return, I can give you one rod. Be careful; they're very heavy! I can sell you more rods for a small fee of 1000 gp each. One more thing: recently, Sad Gentlemen turned up at my station. From an overheard conversation, I learned that they're involved in transporting REDACTED to Hugo Boss's summer cottage.",
				requiredItems = {
					PER_IUSTITIA_AD_ASTRA_KEY_ITEMS["SWAGIER_CRATE"],
				},
				rewards = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS["FUEL_ROD"] },
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 10,
					[Storage.PerIustitiaAdAstra.Mission03] = 5,
					[Storage.PerIustitiaAdAstra.Mission04] = 1,
					[Storage.PerIustitiaAdAstra.BuyFuelRodAccess] = 1,
					[Storage.PerIustitiaAdAstra.ShipDestinations.HugoTarPlanet] = 1,
				},
			},
		},
	},
	[Storage.PerIustitiaAdAstra.BuyFuelRodAccess] = {
		[1] = {
			[{ "fuel", "rod", "paliwo", "pret" }] = {
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_UNIVERSAL.openTradeWindow },
				},
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, config, npcHandler, npc)
	return true
end

local function creatureSayCallback(npc, creature, type, msg)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveConversation(creature, msg, config, npcHandler, npc)
end

npcConfig.shop = {
	{
		itemName = "Fissile fuel rod",
		clientId = 7752,
		buy = 1000,
		storageKey = Storage.PerIustitiaAdAstra.BuyFuelRodAccess,
		storageValue = 1,
	},
	{ itemName = "parcel", clientId = 3503, buy = 15 },
	{ itemName = "letter", clientId = 3505, buy = 10 },
	{ itemName = "label", clientId = 3507, buy = 1 },
	{ itemName = "ultimate mana potion", clientId = 23373, buy = 360 },
	{ itemName = "ultimate spirit potion", clientId = 23374, buy = 350 },
	{ itemName = "ultimate health potion", clientId = 7643, buy = 350 },
	{ itemName = "supreme health potion", clientId = 23375, buy = 620 },
	{ itemName = "health potion", clientId = 266, buy = 45 },
	{ itemName = "mana potion", clientId = 268, buy = 50 },
	{ itemName = "strong health potion", clientId = 236, buy = 110 },
	{ itemName = "strong mana potion", clientId = 237, buy = 90 },
	{ itemName = "great health potion", clientId = 239, buy = 220 },
	{ itemName = "great mana potion", clientId = 238, buy = 140 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 190 },
}
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

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
