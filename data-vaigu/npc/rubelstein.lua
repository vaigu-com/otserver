local internalNpcName = "Rubelstein"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 95,
	lookBody = 38,
	lookLegs = 57,
	lookFeet = 2,
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
		[10] = {
			[{ GREET }] = {
				text = "Boss, can you spare something to eat? Maybe I could have some {spam} from your inbox?",
			},
			[{ "spam" }] = {
				text = "Thanks, I feel better now. I see you managed to escape from the leather traders' prison. If you want to help me get out of here, I suggest you go to the coachman's room and find something that might be useful to me.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 11,
					[Storage.PerIustitiaAdAstra.Mission04] = 2,
				},
			},
		},
		[11] = {
			[{ "mission" }] = {
				text = "Go to the coachman's room now. There are probably various keys and uniforms stored there. It's on the upper floors of this building.",
			},
		},
		[12] = {
			[{ "mission" }] = {
				text = "So, one of the soldiers left their ID document in the dressing room... Maybe you can use that information to convince the main {guard} to release me.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 13,
					[Storage.PerIustitiaAdAstra.Mission04] = 4,
				},
			},
		},
		[13] = {
			[{ "straznika", "guard", "mission" }] = {
				text = "Head to the second building on this planet. The main guard, Klaus Schwab, likes to get some fresh air at the top of the tower. Try to negotiate my release with him. Oh, and watch out for the other guards. They won't be as understanding if they see someone in civilian clothes. Also you should only talk to Knopf in his own language, otherwise he will see though charade.",
			},
		},
		[{ min = 14 }] = {
			[{ "mission" }] = {
				text = "Thanks for helping me get out. Keep this - it's my cigarette case that I got for my eighteenth birthday. Personally I don't smoke , so maybe you'll find a better use for it.",
				requiredState = {
					[Storage.PerIustitiaAdAstra.HelpedRubelstein] = {
						min = 1,
						max = 1,
					},
				},
				rewards = {
					[6104] = {
						PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.rubelsteinScroll,
					},
				},
				nextState = { [Storage.PerIustitiaAdAstra.HelpedRubelstein] = 2 },
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_UNIVERSAL.setStorageRandomNumber, storage = Storage.PerIustitiaAdAstra.RubelsteinChecksum, min = 10 ^ 8, max = 10 ^ 9 },
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
	return TryResolveDialog(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
