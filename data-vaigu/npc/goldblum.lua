local internalNpcName = "Goldblum"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1218,
	lookHead = 59,
	lookBody = 115,
	lookLegs = 58,
	lookFeet = 97,
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
	[Storage.TheThreeSramatiansAndTheDragon.Questline] = {
		[1] = {
			[{ GREET }] = {
				text = "What are you doing in my kosher cave? And you know what, I only have two entrances here: one normal and one through the toilet. I can smell which one you used, you pig.",
			},
			[{ "mission" }] = {
				text = "I'm Goldblum, and I feel like you'll want something from me that I won't want to give. Like money, for example. Or maybe you need {help}?",
			},
			[{ "way", "wyjsc", "help" }] = {
				text = "Alright, but you have to answer my {riddle}. Then I'll answer yours. If you lose, it's sex for money without money.",
			},
			[{ "riddle", "zagodke" }] = {
				text = "What determines the valuation of structured bonds, index certificates, participation certificates, and other structured products, you school-less wretch?",
				nextTopic = 1,
			},
			[{ ANY_MESSAGE }] = {
				text = "What are you trying? Answer immediately!",
				requiredTopic = { min = 0, max = 0 },
			},
			[{ ANY_MESSAGE }] = {
				text = "No, no... now lets commence six for money. *licks his lips*",
				requiredTopic = { min = 1, max = 1 },
			},
			[{
				"Od aktualnego poziomu indeksu gieldowego, kursu akcji, ceny surowca, kursu waluty lub innego wskaznika rynkowego, ktory stanowi ich instrument bazowy",
				"It depends on the current level of the stock market index, stock price, commodity price, currency exchange rate or other market indicator that serves as their underlying instrument",
			}] = {
				text = "CUT THE CRAP! HOW DID YOU KNOW, YOU STUPID IDIOT!! Never mind. Ask your question - there's no question that will surprise my devious, vile mind.",
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 2,
					[Storage.TheThreeSramatiansAndTheDragon.Mission02] = 2,
				},
				requiredTopic = { min = 1, max = 1 },
			},
		},
		[2] = {
			[{ GREET }] = { text = "So, give me the ryddle!" },
			[{ ANY_MESSAGE }] = {
				text = "SHIT, because YOU'RE BROKE! No? How can that be? You're not welcome here anymore. Others like you went through that wire, and I showed them the way to the hive. Farewell, scoundrel.",
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 3,
					[Storage.TheThreeSramatiansAndTheDragon.Mission02] = 3,
					[Storage.TheThreeSramatiansAndTheDragon.Mission03] = 1,
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
