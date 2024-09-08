local internalNpcName = "Qasim"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 610,
	lookHead = 76,
	lookBody = 20,
	lookLegs = 114,
	lookFeet = 19,
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
		[3] = {
			[{ "mission" }] = {
				text = "This will be one of the largest {orders} I've ever received during my life. I'll be able to start working on this project right away.",
			},
			[{ "orders", "zamowien" }] = {
				text = "Start by gathering the materials needed to build the spaceship: 20 Gear Wheels, 3 Huge Chunks of Crude Iron, 1 {Glooth Converter}, 3 Gold Ingots, 1 Spark Sphere, 50 Wood, 5 Gearwheel Chains.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 4,
					[Storage.PerIustitiaAdAstra.Mission02] = 2,
				},
			},
		},
		[4] = {
			[{ "Glooth Converter" }] = {
				text = "Finding such a device won't be easy. It's possible it will be where Glooth creatures are created. Try your luck in the underground swamps.",
			},
			[{ "mission" }] = {
				text = "Good job. I'm getting ready to work on the spaceship. In the meantime, I suggest you start looking for star maps. You'll need them for navigation in space. You'll probably find some map pieces in the city of Bydgoschch, Maioorka. I heard rumors about some witches hiding their map in the ruined chapel, south of maioorka. I think three pieces should be enough for starters. You should also find rocket engine plans. They fell into the hands of the mysterious magician, who allied with outlaws on the north east from Maioor'ka. Now he refuses to share this piece crucial piece. You'll need to acquire both the maps and the engine blueprint for me so I can properly install the rocket propulsion in your vehicle.",
				requiredItems = {
					{ id = 8775, count = 20 },
					{ id = 5892, count = 3 },
					{
						id = 21761,
						count = 1,
						aid = Storage.PerIustitiaAdAstra.Rewards.Converter,
					},
					{ id = 9058, count = 3 },
					{ id = 23518, count = 1 },
					{ id = 5901, count = 50 },
					{ id = 21170, count = 5 },
				},
				textNoRequiredItems = "As I said, I need: 20 Gear Wheels, 3 Huge Chunks of Crude Iron, 1 {Glooth Converter}, 3 Gold Ingots, 1 Spark Sphere, 50 Wood, 5 Gearwheel Chains.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 5,
					[Storage.PerIustitiaAdAstra.Mission02] = 3,
				},
			},
		},
		[5] = {
			[{ "mission" }] = {
				text = "Alright, that's everything I needed. I'll send your spaceship into orbit with a special catapult shortly. I'd have you sit inside it right now, but it's too dangerous. You'll be able to access it through the unlicensed teleporter in the deepling base. Besides, I found this item in my warehouse. If I remember correctly, it's one of the components of rocket fuel. You can produce the fuel by using an atomic splitter on the fuel rod. I've placed this device on your spaceship. You'll also find a remote depot there. I think it will come in handy.",
				requiredItems = {
					PER_IUSTITIA_AD_ASTRA_KEY_ITEMS["MAP1"],
					PER_IUSTITIA_AD_ASTRA_KEY_ITEMS["MAP2"],
					PER_IUSTITIA_AD_ASTRA_KEY_ITEMS["MAP3"],
					PER_IUSTITIA_AD_ASTRA_KEY_ITEMS["ENGINE_BLUEPRINT"],
				},
				textNoRequiredItems = "I'll need engine blueprints. Also, you'll need to have some basic knowledge of astronomy, so have three sky map pieces with you. Without them, you won't get far.",
				rewards = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS["FUEL_ROD"] },
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 6,
					[Storage.PerIustitiaAdAstra.Mission02] = 4,
					[Storage.PerIustitiaAdAstra.Mission03] = 1,
					[Storage.PerIustitiaAdAstra.ShipControl.FuelLevel] = 0,
					[Storage.PerIustitiaAdAstra.ShipControl.Current] = Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings,
					[Storage.PerIustitiaAdAstra.ShipControl.Next] = Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings,
				},
			},
		},
		[6] = {
			[{ "mission" }] = {
				text = "Flights within a given system require only the power of mana. For intergalactic travel, you'll need rocket fuel. Therefore, you'll need to find a refueling station that sells such fuel. I've included the coordinates of a CPN-sponsored one in the ship's navigation. Good luck!",
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

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
