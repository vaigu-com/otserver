local internalNpcName = "Moustachilles"
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

-- ToDo: localization tables missing the sentences below
local dialog = {
	[LOCALIZER_UNIVERSAL] = {
		[INCOMPREHENSIBLE] = {
			text = "Go away, or even better: flip off.",
		},
	},
	[Storage.IKEAdlazuchwalych.Localizer] = {
		[Storage.IKEAdlazuchwalych.Mission01] = {
			[9] = {
				[{ "thief", "zlodziej" }] = {
					text = "Please, you don't think that I am giving any {information} about my - ekhem - contractors just like that.",
				},
				[{ "informacje", "info", "information", "informations" }] = {
					text = "Guards! This man got to go, show him where we throw out carcasses.",
					spawnMonstersOnSuccess = {
						["bandit"] = 2,
						["smuggler"] = 3,
					},
					nextState = {
						[Storage.IKEAdlazuchwalych.Mission01] = 10,
					},
				},
			},
			[10] = {
				[{ "informacje", "info", "information", "informations", "thief", "zlodziej" }] = {
					text = "Fine! - calm down, we will get along somehow. What has been stolen from you?",
				},
				[{ "meble", "drewno", "furniture", "wood" }] = {
					text = "Ohh, that dude ... he left on a boat recently. He was asking me for some good place to hide. ...\nI told him to look around at the south of the steppes. That's all I know.",
					nextState = {
						[Storage.IKEAdlazuchwalych.Mission01] = 11,
					},
				},
			},
		},
	},
	[Storage.ChesterTheDwarf.Localizer] = {
		[Storage.ChesterTheDwarf.Mission01] = {
			[{ "tozsamosc", "dokument", "document", "identity", "czeslaw", "chester" }] = {
				"So, you want to know how to obtain a new identity? Oh, you're asking for a friend? Sure.. Have a chat with Ornuld in the jungle, he specializes in such matters...\nYou might need something to write with and paper, preferably from a very common book, and, of course, the payment...\nIf silence is gold, then forging documents is crystal. What the hell am I saying... Anyway, have a crystal coin with you.",
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, dialog, npcHandler, npc)
	return true
end

local function creatureSayCallback(npc, creature, type, msg)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveDialog(creature, dialog, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
