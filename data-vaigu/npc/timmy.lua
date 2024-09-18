local internalNpcName = "Timmy"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1245,
	lookHead = 116,
	lookBody = 42,
	lookLegs = 39,
	lookFeet = 57,
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
	[Storage.FourActTragedy.Questline] = {
		[4] = {
			[{ "mission" }] = {
				text = "It seems I got lost in the corridors of time. I have vague memories from the future that I am a bouncer in my hometown. I think I could help you with the immigrant influx, but first, I need to reconcile with my present self. Find my equipment stolen by bandits, and I will help you.",
				nextState = {
					[Storage.FourActTragedy.Questline] = 5,
					[Storage.FourActTragedy.Mission02] = 2,
					[Storage.FourActTragedy.WawelDragonAccess] = 1,
				},
			},
		},
		[5] = {
			[{ "mission" }] = {
				text = "I don't know where they moved my stuff to.",
			},
		},
		[6] = {
			[{ "mission" }] = {
				text = "Thank you, that's mine. Okay, now I'm going back to the {present}!",
				requiredItems = {
					TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS.timmyBag,
				},
				textNoRequiredItems = "Are you sure you didn't lose any of my stuff along the way?",
				nextState = {
					[Storage.FourActTragedy.Questline] = 7,
					[Storage.FourActTragedy.Mission02] = 4,
				},
			},
		},
		[7] = {
			[{ "mission", "present", "terazniejszosci" }] = {
				text = "Tell Tomek that I will deal with those refugees as soon as I can. Actually, I've already dealt with them. Yeah, the paradoxes of time travel. And one more thing: the person responsible for convincing immigrants to use the HF-P/X portal was none other than Rat Bum.",
				requiredItems = {
					TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS.timmyPowder,
				},
				textNoRequiredItems = "My magic doesn't seem to work. We'll need elven spells. Go to the elves' rock and get some magical powder that I can use for the ritual. Watch out for the dormant Soros foundations. I've seen that they too got lost in this world.",
				nextState = {
					[Storage.FourActTragedy.Questline] = 8,
					[Storage.FourActTragedy.Mission02] = 5,
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
